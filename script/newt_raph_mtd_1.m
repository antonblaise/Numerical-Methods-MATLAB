clc;

% Evaluate sqrt(12) to 4 decimal places by using Newton Raphson Method.

y = @(x) (x^3) - 18;  % f(x)
y1 = @(x) 3*(x^2);                 % f'(x)
x = 5;
x1 = 4;
i = 0;

fprintf("i\tti\t\tti+1\t|ti - ti+1|\n");
while abs(y(x)) > 0.0005
    i = i + 1;
    x1 = x - (y(x)/y1(x));
    err = abs(x1-x);
    fprintf("%d\t%.4f\t%.4f\t%.5f\n",i,x,x1,err);
    x = x1;
end

i = i + 1;
x1 = x - (y(x)/y1(x));
err = abs(x1-x);
fprintf("%d\t%.4f\t%.4f\t%.5f\n",i,x,x1,err);
x = x1;

fprintf("\nRoot = %.4f\n%d iterations.\n", x1, i);