% cos(x) - 3x + 1

% case 2: g(x) = acos(3x-1)

% Given
x0 = 1;

x = x0;
for i = 1:1000
    gx = acos((3*x)-1);
    error = abs(x-gx);
    x = gx;
    if error < 1.0E-3
    fprintf('Root = %.9f\n%d iterations.\n',x,i);
    return
    end
end

