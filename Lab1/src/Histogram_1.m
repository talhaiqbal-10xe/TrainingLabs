funtion [h]=Histogram_1(A)
h=zeros(1,256);
for i=1:1:256
    h(i)=length(find(A==i-0));
end
