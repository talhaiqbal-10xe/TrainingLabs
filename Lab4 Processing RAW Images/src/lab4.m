%% -------- change the working directory to the "../Lab 4 Processing RAW Images/src"  to run this file
addpath(pwd) % so that functions in /src can be called from anywhere 


%% Loading and reading RAW Image files
chdir_src2input()
filename = 'sample.DNG';
warning off MATLAB:tifflib:TIFFReadDirectory:libraryWarning
t = Tiff(filename,'r');
offsets = getTag(t,'SubIFD');
setSubDirectory(t,offsets(1));
raw = read(t); % Create variable ’raw’, the Bayer CFA data
close(t);
meta_info = imfinfo(filename);
% Crop to only valid pixels
%x_origin = meta_info.SubIFDs{1}.ActiveArea(2)+1; % +1 due to MATLAB indexing
%width = meta_info.SubIFDs{1}.DefaultCropSize(1);
%y_origin = meta_info.SubIFDs{1}.ActiveArea(1)+1;
%height = meta_info.SubIFDs{1}.DefaultCropSize(2);
%raw = double(raw(y_origin:y_origin+height-1,x_origin:x_origin+width-1));
chdir_src();

%% Linearization
if isfield(meta_info.SubIFDs{1},'LinearizationTable')
      ltab=meta_info.SubIFDs{1}.LinearizationTable; 
      raw = ltab(raw+1); %% ??
end
black = meta_info.SubIFDs{1}.BlackLevel(1);
saturation = meta_info.SubIFDs{1}.WhiteLevel;
lin_bayer = (raw-black)/(saturation-black);
lin_bayer = max(0,min(lin_bayer,1));


%% White balancing 
wb_multipliers = (meta_info.AsShotNeutral)-1;
wb_multipliers = wb_multipliers/wb_multipliers(2);
mask = wbmask(size(lin_bayer,1),size(lin_bayer,2),wb_multipliers,'rggb');
balanced_bayer = lin_bayer .* mask;
imshow(balanced_bayer)

%% Demosicing 
temp = uint16(balanced_bayer/max(balanced_bayer(:))*2^16);
lin_rgb = double(demosaic(temp,'rggb'))/2^16;
imshow(lin_rgb)


%% Color matrix conversion
rgb2xyz=[0.4124564 0.3575761 0.1804375; 0.2126729 .7151522 0.0721750; 0.0193339 0.1191920 0.9503041];
xyz2cam=transpose(reshape(meta_info.ColorMatrix2,[3 3]));
rgb2cam = xyz2cam * rgb2xyz; % Assuming previously defined matrices
rgb2cam = rgb2cam ./ repmat(sum(rgb2cam,2),1,3); % Normalize rows to 1
cam2rgb = rgb2cam^-1;
lin_srgb = apply_cmatrix(lin_rgb, cam2rgb);
lin_srgb = max(0,min(lin_srgb,1));


%% Brightness and Gamma Correction
grayim = rgb2gray(lin_srgb);
grayscale = 0.25/mean(grayim(:));
bright_srgb = min(1,lin_srgb*grayscale);

nl_srgb = bright_srgb.^(1/2.2);