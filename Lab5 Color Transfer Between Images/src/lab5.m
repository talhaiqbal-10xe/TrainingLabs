%% working directory should be ..\Lab 5 Color Transfer Between Images\src
addpath(pwd)
%% reading images into MATLAB
chdir_src2input();
source_file='source2.jpg';
target_file='target2.jpg';
s_image=imread(source_file);
t_image=imread(target_file);
chdir_src();


%% Coversion from RGB to LAB
s_image_lab=rgb2lab(s_image);
t_image_lab=rgb2lab(t_image);

%% 1 computing means and standard deviations
s_mean_L=mean(reshape(s_image_lab(:,:,1),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
s_mean_a=mean(reshape(s_image_lab(:,:,2),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
s_mean_b=mean(reshape(s_image_lab(:,:,3),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
s_std_L=std(reshape(s_image_lab(:,:,1),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
s_std_a=std(reshape(s_image_lab(:,:,2),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
s_std_b=std(reshape(s_image_lab(:,:,3),[1,size(s_image_lab,1)*size(s_image_lab,2)]));
t_mean_L=mean(reshape(t_image_lab(:,:,1),[1,size(t_image_lab,1)*size(t_image_lab,2)]));
t_mean_a=mean(reshape(t_image_lab(:,:,2),[1,size(t_image_lab,1)*size(t_image_lab,2)]));
t_mean_b=mean(reshape(t_image_lab(:,:,3),[1,size(t_image_lab,1)*size(t_image_lab,2)]));
t_std_L=std(reshape(t_image_lab(:,:,1),[1,size(t_image_lab,1)*size(t_image_lab,2)]));
t_std_a=std(reshape(t_image_lab(:,:,2),[1,size(t_image_lab,1)*size(t_image_lab,2)]));
t_std_b=std(reshape(t_image_lab(:,:,3),[1,size(t_image_lab,1)*size(t_image_lab,2)]));

%% 2 subtracting means in taget image
t_image_lab(:,:,1)=t_image_lab(:,:,1)-t_mean_L;
t_image_lab(:,:,2)=t_image_lab(:,:,2)-t_mean_a;
t_image_lab(:,:,3)=t_image_lab(:,:,3)-t_mean_b;

%% scaling relative to std s
t_image_lab(:,:,1)=t_image_lab(:,:,1)*(t_std_L/s_std_L);
t_image_lab(:,:,2)=t_image_lab(:,:,2)*(t_std_a/s_std_a);
t_image_lab(:,:,3)=t_image_lab(:,:,3)*(t_std_b/s_std_b);

%% Adding average of the source
t_image_lab(:,:,1)=t_image_lab(:,:,1)+s_mean_L;
t_image_lab(:,:,2)=t_image_lab(:,:,2)+s_mean_a;
t_image_lab(:,:,3)=t_image_lab(:,:,3)+s_mean_b;

%% converting back to rgb
result=lab2rgb(t_image_lab);
%% showing and saving results
close all;
% imshow(result)
% title('result');
% figure;
% imshow(s_image);
% title('source');
% figure;
% imshow(t_image);
% title('target');
fig1=figure;
subplot(1,3,1);
imshow(s_image);
title('source');
subplot(1,3,2);
imshow(t_image);
title('target');
subplot(1,3,3);
imshow(result);
title('Result of Color Transformation');
chdir_output();
saveas(fig1,'results.png')
chdir_src();



