function [out]=pointTrans(inp,T1,T2)
out=zeros(size(inp));
m=255/(T2-T1);
c=-1*(m*T1);
for i=1:size(inp,1)*size(inp,2)
    if inp(i)<=T1
        out(i)=0;
    else
        if inp(i)>=T2
            out(i)=255;
        else
            out(i) = ceil(m*inp(i)+c);
        end
    end
end

                