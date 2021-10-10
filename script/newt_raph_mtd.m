%% Newton Raphson Method

clc;

fprintf("NEWTON RAPHSON METHOD\n");

% Input

syms f(x)
syms f1(x)
syms x

fprintf("\nInsert your equation\n");
f = input("> ");
f(x) = f;

% differentiate the equation
f1(x) = diff(f, x, 1);

% Display equations
fprintf("\n f(x) = ");
disp(f(x));
fprintf("f'(x) = ");
disp(f1(x));

% define x0
x0 = input("\nx0 = ");

% set stopping condition
fprintf("\nStop when error is lower than...\n");
stop = input("> ");

%% Solving

err = inf;
i = 0;

fprintf("\ni\t\txi\t\t\t\tf(x)\t\t\tf'(x)\t\t\t|x(i) - x(i-1)|\n");
x1 = x0;
fprintf("%d\t\t%.6f\t\t%.6f\t\t%.6f\t\t%.6f\n",i,x1,f(x1),f1(x1),err);
while abs(f(x0)) > stop
    i = i + 1;
    x1 = x0 - (f(x0)/f1(x0));
    err = x1 - x0;
    fprintf("%d\t\t%.6f\t\t%.6f\t\t%.6f\t\t%.6f\n",i,x1,f(x1),f1(x1),err);
    x0 = x1;
end

i = i + 1;
x1 = x0 - (f(x0)/f1(x0));
err = x1 - x0;
fprintf("%d\t\t%.6f\t\t%.6f\t\t%.6f\t\t%.6f\n",i,x1,f(x1),f1(x1),err);
x0 = x1;

fprintf("\nRoot = %f\n%d iterations.\n", x1, i);

%%

