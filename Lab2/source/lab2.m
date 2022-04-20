%% __init()__
close all;
clear all;

%-----------change the working directory to the ..\Lab2------------
%---------------Otherwise there will be error----------------------

% the directory ..\Lab2 contains 4 folders in out source doc
cd in
load ('ycbcr');
A=imread('girl.tif');

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

B=imread('house.tif');
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
title('Error Image (simple Quantization)');
MSE_simple=sum(sum(error_image.^2))/(size(error_image,1)*size(error_image,2));

%% Ordered dithering
I=[12 8 10 6; 4 16 2 14; 9 5 11 7;1 13 3 15];
T=(I-0.5)/16;
T=255*T;
T_mat=zeros(size(B));
for i=1:4:size(B,1)
    for j=1:4:size(B,2)
        T_mat(i:i+3,j:j+3)=T;
    end
end

OD=255*(double(B)>T_mat);
fig7=figure;
image(OD);
colormap(gray(256));
title('Ordered dithering');
error_image=abs(OD-double(B));
fig8=figure;
image(error_image);
colormap(gray(256))
title('Error Image after Ordered Dithering');
MSE_dithering=immse(OD,double(B));


%% half tonnig using diffusion techniques. 
B=double(B);
D=zeros(size(B));
T=108;
e=0;
for i=1:size(B,1)
    for j=1:size(B,2)
        if (B(i,j)>T)
            D(i,j)=255;
        else
            D(i,j)=0;
        end
        e=B(i,j)-D(i,j);
        % diffusing error into future pixels
        if (j+1 <= size(B,2) && i+1 <= size(B,1))
             B(i+1,j+1)=B(i+1,j+1)+(1/16)*e;
             B(i+1,j)=B(i+1,j)+(5/16)*e;
             B(i,j+1)=B(i,j+1)+(7/16)*e;
        else if(i+1<=size(B,1))
            B(i+1,j)=B(i+1,j)+(5/16)*e;
             else if(j+1<=size(B,2))
                     B(i,j+1)=B(i,j+1)+(7/16)*e;
                 end
            end
        end
        if (j-1 >= 1 && i+1 <= size(B,1))
            B(i+1,j-1)=B(i+1,j-1)+(3/16)*e;
        end
    
    end
end
fig9=figure;
image(D);
colormap(gray(256));
title('diffused dithering');
error_image=abs(D-B);
fig10=figure;
image(error_image);
colormap(gray(256));
title('Error image after diffused dithering');
MSE_diffused=immse(D,B);

%% filtered MSE
Y_filtered=filter2(h,Y);
OD_filtered=filter2(h,OD);
D_filtered=filter2(h,D);


MSE_Y_f=immse(Y_filtered,B);
MSE_OD_f=immse(OD_filtered,B);
MSE_D_f=immse(D_filtered,B);

fig11=figure;
y=[MSE_simple MSE_Y_f; MSE_dithering MSE_OD_f; MSE_diffused MSE_D_f];
bar(y)
xticklabels({'Thresholding','Ordered Dithering','Diffused Dithering'})
legend({'without filtering','Gaussian Filtered'});
ylabel('MSE'); 
title('Mean Square Error Comparison');

%% Saving Results

cd ..;
cd out;
saveas(fig1,'1_R G and B Channels.png')
saveas(fig2,'2_Y Cb Cr channels.png')
saveas(fig3,'3_YCbCr2RGB filtering.png')
saveas(fig4,'4_House Original.png')
saveas(fig5,'5_Thresholding Quantized.png')
saveas(fig6,'6_Thresholding Error.png')
saveas(fig7,'7_Ordered Dithering Quantized.png')
saveas(fig8,'8_Ordered Dithering Error.png')
saveas(fig9,'9_Diffused Dithering Quantized.png')
saveas(fig10,'10_Diffused Dithering Error.png')
saveas(fig11,'11_MES comparison.png')
cd ..

     




