function [h] = gaussFilter(N,var)
h=zeros(N,N);
start=-1*((N-1)/2);
for i=1:N
    for j=1:N
        e=((start+(i-1))^2 +(start+(j-1))^2)/(2*var);
        h(i,j)=exp(-1*e);
    end
end
C=sum(sum(h));
h=h/C;

