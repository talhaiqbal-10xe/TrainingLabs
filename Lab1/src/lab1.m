%% start
close all;
cd 'C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\source';
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\yacht.tif');

house_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\house.tif');
image_house=imread(house_path);
A=imread(image_path);
B=double(A);
image(B);
colormap(gray(256));
axis('image')
title ('yatch')
close;

% Horizontally Flipped Image
h_flip=flip(B,2);
fig1=figure;
subplot (1,2,1);
image(h_flip);
colormap(gray(256));
title('horizontally flipped');
% Vertical Flip
v_flip=flip(B,1);
subplot (1,2,2);
image(v_flip);
colormap(gray(256));
title('vertically fillped');


% Negative of the image
negative=255-B;
fig2=figure;
subplot (1,2,1);
image(negative);
colormap(gray(255));
title ('negative image');
% multiplication by 1.5
multiplied = 1.5*B;
subplot (1,2,2);
image(multiplied);
colormap(gray(255));
title('multiplied by 1.5');

%% histogram
%manual histogram
narrow_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\narrow.tif');
image_house=imread(narrow_path);
h=image_histogram(image_house);
fig3=figure;
subplot (2,1,1);
stem(h);
title('manually calculated histogram');
im_reshape=reshape(image_house,1,size(image_house,1)*size(image_house,2));
subplot (2,1,2);
hist(im_reshape,[0:255]);
title('histogram using command');
%% Point transform

transformed=pointTrans(double(image_house),70,180);
% if you don't covert the image into double, the 
% results won't make any sense.
fig4=figure;
subplot(2,2,1);
image(image_house);
colormap(gray(255));
title('normal image');
subplot(2,2,2);
image(transformed);
colormap(gray(255));
title('point transformed');
subplot(2,2,3);
stem(h);
title('normal histogream');
transformed_histogram=image_histogram(transformed);
subplot(2,2,4);
stem(transformed_histogram);
title('transformed histogram');

%% Gemma Correction
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\dark.tif');
A=imread(image_path);
fig5=figure;
subplot (1,2,1);
image(A);
colormap(gray(256));
title('Normal image');
B=gemmaCorrection(double(A),2.2);
subplot (1,2,2);
image(B);
colormap(gray(256));
title('Image with Gemma Correction Applied');

%% Image Enhancement based on Filtering.
image1_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\race.tif');
image2_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\noise1.tif');
image3_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\noise2.tif');
A=imread(image1_path);
B=imread(image2_path);
C=imread(image3_path);

% 7x7 filter 
h=gaussFilter(7,1);
H=fftshift(fft2(h,33,33)); %frequency response of the filter 
mag_H=abs(H);  % magnitude of H
[X,Y] = meshgrid(-1*pi:pi/16:1*pi); %had to change from 32x32 to 33x33
fig6=figure;
s=mesh(X,Y,mag_H)
title('2D Gaussian Filter');

fig7=figure;
subplot(2,4,1);
image(A);
colormap(gray(256));
title('Original Image');
subplot(2,4,2);
image(B);
title('Noise Image 1');
Y=filter2(h,B);
subplot(2,4,3);
image(Y);
title('Gaussian Filtered ');
m=medianFilter(B);
subplot(2,4,4);
image(m);
title('Median Filtered image');
subplot(2,4,5);
image(A);
title('Original Image');
subplot(2,4,6);
image(C);
title('Noise Image 2');
Y=filter2(h,C);
subplot(2,4,7);
image(Y);
title('Gaussian Filtered ');
m=medianFilter(C);
subplot(2,4,8);
image(m);
title('Median Filtered ');
%% Sharpening Exercise
h=gaussFilter(5,1);
H=fftshift(fft2(h,33,33));
I=ones(33);
alpha=2;
beta=1;
H=alpha-beta*H;
mag_H=abs(H);
[X,Y] = meshgrid(-1*pi:pi/16:1*pi);
fig8=figure;
s=mesh(X,Y,mag_H)
title('frequency response of unsharp filter');
image4_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\Lab1\in\blur.tif');
A=imread(image4_path);

fig9=figure;
subplot(1,3,1);
image(A);
title('original blurred');
colormap(gray(256));
B=alpha.*double(A)-beta.*(filter2(h,double(A)));
subplot(1,3,2);
image(B);
title('sharpened a=2, b=1');
alpha=10;
beta=9;
C=alpha.*double(A)-beta.*(filter2(h,double(A)));
subplot(1,3,3);
image(C);
title('sharpened a=10, b=9');


%% Saving Results
cd ..;
cd out;
saveas(fig1,'flipping.png')
saveas(fig2,'negative_multiplication.png')
saveas(fig3,'histogram calculation.png')
saveas(fig4,'point tranforms.png')
saveas(fig5,'gemma correction.png')
saveas(fig6,'Gaussian Filter.png')
saveas(fig7,'Gaussain vs Median.png')
saveas(fig8,'Sharpening Filter.png')
saveas(fig9,'Sharpened images.png')




