function [h]=image_histogram(A)
h=zeros(1,256);
for i=1:256
    h(i)=length(find(A==i-1));
end
