%% Fixed Point Iteration

clc;

% Equation: cos(x) - 3x + 1

% Determine a g(x) such that the iteration is convergent, -1 < g'(x) < 1
% g(x) = (cos(x)+1)/3

% Given
x0 = 2;

% Set stopping condition
limit = 0.005;

x = x0;
val_x(1) = x;
val_y(1) = cos(x) - 3*x + 1;

for i = 1:1000
    % Put g(x) here
    gx = log(5*x - 2);
    error = abs(x-gx);
    x = gx;
    val_x(i+1) = x;
    val_y(i+1) = cos(x) - 3*x + 1;
    if error < limit
        fprintf('Root = %.9f\n%d iterations.\n',x,i);
        return
    end
end


%% Data visualisation

line_x = linspace(-10,10,1000);
line_y = exp(line_x) - 5*line_x +2;

hold on
grid on
scatter(val_x, val_y,'red');
plot(val_x, val_y, 'blue');
plot(line_x, line_y, 'black');
xline(x, 'magenta');

hold off
