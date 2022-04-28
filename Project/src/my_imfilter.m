function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

%% Determining number of channels
channels=length(size(image));
if (channels<3)
    channels=1;
else
    channels=size(image,3);
end

%% Asserting filter dimensions are odd
f_rows=size(filter,1);
f_columns=size(filter,2);
assert(~(mod(f_rows,2)==0 || mod(f_columns,2)==0),'filter dimensions must be odd')

%% boundary handling
row_start=(f_rows-1)/2;
column_start=(f_columns-1)/2;
padded_image=zeros(size(image,1)+f_rows-1,size(image,2)+f_columns-1,channels);
padded_image(row_start+1:row_start+size(image,1),column_start+1:column_start+size(image,2),1:channels)=image;

%% filtering
output=zeros(size(image));
for k=1:channels
    for i=row_start+1:row_start+size(image,1)
        for j=column_start+1:column_start+size(image,2)
            output(i-row_start,j-column_start,k)=sum(sum(padded_image(i-row_start:i+row_start,j-column_start:j+column_start,k).*filter));
        end
    end
end








