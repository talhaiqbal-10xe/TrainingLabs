%% __init()__
close all;
load ('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab2\in\ycbcr');
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab2\in\girl.tif');
A=imread(image_path);

%% RGB and YCbCr separate
R=A(:,:,1);
G=A(:,:,2);
B=A(:,:,3);
fig1=figure;
subplot(2,2,1);
image(A);
%colormap(gray(256));
title('original image');
subplot(2,2,2);
image(R);
title('red channel');
subplot(2,2,3);
image(G);
title('Green channel');
subplot(2,2,4);
image(B);
title('Blue channel');

fig2=figure;
subplot(1,3,1);
image(ycbcr(:,:,1));
colormap(gray(256));
title('Y channel');
subplot(1,3,2);
image(ycbcr(:,:,2));
title('Cb channel');
subplot(1,3,3);
image(ycbcr(:,:,1));
title('Cr channel');

%% Effects of filtering in Y,Cr,Cb channels
rgb=ycbcr2rgb(ycbcr);
ycbcr_1=ycbcr;
ycbcr_2=ycbcr;
ycbcr_3=ycbcr;
fig3=figure;
subplot(2,2,1)
image(rgb);
title('YCbCr converted to RGB');
ycbcr_1(:,:,1)=filter2(h,ycbcr_1(:,:,1));
ycbcr_1(:,:,2)=filter2(h,ycbcr_2(:,:,2));
ycbcr_1(:,:,3)=filter2(h,ycbcr_3(:,:,3));
rgb1=ycbcr2rgb(ycbcr_1);
rgb2=ycbcr2rgb(ycbcr_2);
rgb3=ycbcr2rgb(ycbcr_3);
subplot(2,2,2);
image(ycbcr_1);  % blurred more than others.
title('Filtered Y');
subplot(2,2,3);
image(ycbcr_2);
title('Filtered Cb');
subplot(2,2,4);
image(ycbcr_3);
title('Filtered Cr');

%% Half toning exeercises
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab2\in\house.tif');
B=imread(image_path);
fig4=figure;
image(B);
colormap(gray(256));
title('Original Image');
fig5=figure;
Y=255*(B>108);
image(Y);
colormap(gray(256));
title('Quantized at T=108');
fig6=figure;
error_image=abs(double(B)-double(Y));
image(error_image);
colormap(gray(256));
title('Error Image');
MSE=sum(sum(error_image.^2))/(size(error_image,1)*size(error_image,2))



