
clc;

% Equation given: ex -5x +2

% Determine a g(x) such that the iteration is convergent, -1 < g'(x) < 1
% g(x) = ln(5x - 2)

% Given
x0 = 1;

% Set stopping condition
limit = 0.0005;

%% Solving

fprintf("FIXED POINT ITERATION\n");

fprintf("\nx[i+1] = g(x[i])\n");

fprintf("\ni\t\txi\t\t\t\t|xi - xi-1|\n");

x = x0;

fprintf("0\t\t%.6f\n", x);

for i = 1:1000
    % Put g(x) here
    gx = sin(sqrt(x));
    error = abs(x-gx);
    x = gx;
    fprintf("%d\t\t%.6f\t\t%.5f\n", i, x, error);
    if error < limit
        fprintf('\nRoot = %.9f\n%d iterations.\n\n',x,i);
        return
    end
end

i=i+1;
gx = x - sin(sqrt(x));
error = abs(x-gx);
x = gx;
fprintf("%d\t\t%.4f\t\t%.5f\n", i, x, error);
