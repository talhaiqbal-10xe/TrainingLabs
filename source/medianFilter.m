function out=medianFilter(inp)
%is median filter a separable filter?
[x y]=size(inp);
out=zeros(x-2,y-2);
for i = 2:x-1
    for j=2:y-1
        window=reshape(inp(i-1:i+1,j-1:j+1),1,9);
        out(i-1,j-1)=median(window);
    end
end

        
        
        