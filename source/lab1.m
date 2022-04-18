close all;
cd 'C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\source';
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\in\yacht.tif');

house_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\in\house.tif');
image_house=imread(house_path);
A=imread(image_path);
%whos
B=double(A);
whos
image(B);
colormap(gray(256));
axis('image')
title ('yatch')

% Horizontally Flipped Image
h_flip=flip(B,2);
figure;
image(h_flip);
colormap(gray(256));
title('horizontally flipped');
cd ..;
cd out;
imwrite(uint8(h_flip),'yatch_h_flip.png','PNG');

% Vertical Flip
v_flip=flip(B,1);
figure;
image(v_flip);
colormap(gray(256));
title('vertically fillped');


% Negative of the image
negative=255-B;
figure;
image(negative);
colormap(gray(255));
title ('negative image');

% multiplication by 1.5
multiplied = 1.5*B;
image(multiplied);
colormap(gray(255));
title('multiplied by 1.5');

%manual histogram
narrow_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\in\narrow.tif');
image_house=imread(narrow_path);
h=image_histogram(image_house);
stem(h);
figure;
im_reshape=reshape(image_house,1,size(image_house,1)*size(image_house,2));
hist(im_reshape,[0:255]);

%point transform
transformed=pointTrans(double(image_house),70,180);
% if you don't covert the image into double, the 
% results won't make any sense.
figure;
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
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\in\dark.tif');
A=imread(image_path);
figure;
subplot (1,2,1);
image(A);
colormap(gray(255));
B=gemmaCorrection(A,2.2);
subplot (1,2,2);
image(B);
colormap(gray(255));







