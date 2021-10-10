
function [d]=Divided_diff(x,y)
d=y;
n=length(x);
for j=2:n
    for k=n:-1:j
        d(k)=(d(k)-d(k-1))/(x(k)-x(k-j+1));
    end
end