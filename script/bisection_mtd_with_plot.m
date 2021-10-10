%% Bisection Method

clc;

% Define f(x) here
f = @(x) exp(x) - 5*x + 2;

% Define the interval [x1,x2] here
x1 = 0.5;
x2 = 1;

% State when to stop. |f(ci)| < limit
limit = 0.005;

%% Workings

fprintf("\nBISECTION METHOD\n");

val_x1(1) = x1;
val_x2(1) = x2;

if f(x1)*f(x2) > 0
    fprintf('No roots in the interval.');
    return
end

if f(x1) == 0
    fprintf('x1 is a root!');
    return
elseif f(x2) == 0
    fprintf('x2 is a root!');
    return
end

i = 0;

%%

fprintf("\nbisection\tx1\t\t\tx_mid\t\tx2\t\t\tf(x1)\t\tf(x_mid)\tf(x2)\t\t|f(ci)|\n");

%%

while abs(f((x1+x2)/2)) > limit
    x_mid = (x1+x2)/2;
    i = i + 1;
    fprintf("%d\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t", i, x1, x_mid, x2);
    fprintf("%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n", f(x1), f(x_mid), f(x2), abs(f((x1+x2)/2)));
    if f(x1)*f(x_mid) < 0
        x2 = x_mid;
    elseif f(x2)*f(x_mid) < 0
        x1 = x_mid;
    end
    val_x1(i+1) = x1;
    val_x2(i+1) = x2;
end

%%

x_mid = (x1+x2)/2;
i = i + 1;
fprintf("%d\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t", i, x1, x_mid, x2);
fprintf("%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n", f(x1), f(x_mid), f(x2), abs(f((x1+x2)/2)));
if f(x1)*f(x_mid) < 0
    x2 = x_mid;
elseif f(x2)*f(x_mid) < 0
    x1 = x_mid;
end
val_x1(i+1) = x1;
val_x2(i+1) = x2;

fprintf('\nRoot = %.9f\nNumber of bisections = %d\n', x_mid, i);

%% Data visualisation

val_y = 1:i+1;

x = linspace(-10,10,1000);
line_y = f(x);

hold on
grid on
title('Bisection Method');
scatter(val_x1, val_y, 'blue');
scatter(val_x2, val_y, 'red');
plot(val_x1, val_y, 'blue');
plot(val_x2, val_y, 'red');
plot(x, line_y, 'black');
xline(x_mid,'magenta');


