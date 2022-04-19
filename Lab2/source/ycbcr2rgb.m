function[rgb]=ycbcr2rgb(inp)
rgb=zeros(size(inp));
rgb(:,:,1)=inp(:,:,1)+1.4025*(inp(:,:,3)-128);
rgb(:,:,2)=inp(:,:,1)-0.3443*(inp(:,:,2)-128)+0.7144*(inp(:,:,3)-128);
rgb(:,:,3)=inp(:,:,1)+1.7730*(inp(:,:,2)-128);
rgb=uint8(rgb);