%% Newton Raphson Method

clc;

%% Edit settings here

% Insert equations of f(x) and f'(x) here
y = @(x) x.^3 - 2.*x - 5;   % f(x)
y1 = @(x) 3.*(x.^2) - 2; % f'(x)

% define x0
x0 = 1;

% set stopping condition

stop = 0.0005;

%% Solving

fprintf("NEWTON-RAPHSON METHOD\n\n");

err = inf;
i = 0;

fprintf("i\t\txi\t\t\tf(x)\t\tf'(x)\t\t|x(i) - x(i-1)|\n");
x1 = x0;
val_x(1) = x1;
fprintf("%d\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.5f\n",i,x1,y(x1),y1(x1),err);
while abs(y(x0)) > stop
    i = i + 1;
    x1 = x0 - (y(x0)/y1(x0));
    val_x(i+1) = x1;
    err = x1 - x0;
    fprintf("%d\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.5f\n",i,x1,y(x1),y1(x1),err);
    x0 = x1;
end

i = i + 1;
x1 = x0 - (y(x0)/y1(x0));
err = x1 - x0;
fprintf("%d\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.5f\n",i,x1,y(x1),y1(x1),err);
x0 = x1;

fprintf("\nRoot = %.4f\n%d iterations.\n", x1, i);

%% Data visualisation

val_y = 1:i;

hold on
plot(val_x, val_y, 'blue');
scatter(val_x, val_y, 'filled', 'black');
xlabel('x');
ylabel('iteration');
grid on




