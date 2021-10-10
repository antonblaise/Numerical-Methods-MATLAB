clc;

% Newton Raphson Method
% Find smallest root
% x = (2 - e^-x + x^2) / 3 = 0
% 4 d.p.


y = @(x) (x^2) + 2 - exp(-x) - 3*x;   % f(x)
y1 = @(x) 2*x + exp(-x) - 3; % f'(x)

% Determine the interval containing the root (positive side)
intv = input("Interval = ");
a = 0;
b = a + intv;

fprintf("\na\t\tb\n");

while y(a)*y(b) > 0
    fprintf("%.4f\t%.4f\n",a,b);
    b = a;
    a = a + intv;
end

fprintf("%.4f\t%.4f\tRoot\n",a,b);
fprintf("\nThe smallest positive root is in between %.4f & %.4f.\n",a,b)

% Set the best initial values of x and x1 before iteration.

x = b;
x1 = a;

i = 0;

fprintf("\ni\tx\t\tx1\t\tf(x)\n");
while abs(y(x)) > 0.001
    i = i + 1;
    x1 = x - (y(x)/y1(x));
    fprintf("%d\t%.4f\t%.4f\t%.4f\n",i,x,x1,y(x1));
    x = x1;
end

fprintf("\nSmallest positive root = %.4f\n%d iterations.\n", x1, i);