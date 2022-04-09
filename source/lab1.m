cd 'C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\source';
image_path=('C:\Users\user3\Downloads\Documents\Training\3_Image_Processing_Labs\in\yacht.tif');
A=imread(image_path);
whos
B=double(A);
whos
image(B);
colormap(gray(256));
axis('image')

% Horizontally Flipped Image
h_flip=flip(B,2);
figure;
image(h_flip);
colormap(gray(256));
title('horizontally flipped');

% Vertical Flip
v_flip=flip(B,1);
figure;
image(v_flip);
colormap(gray(256));
title('vertically fillped');

% Negative of the image


