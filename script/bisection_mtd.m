%% Bisection Method

clc;

% Define f(x) here
f = @(x) -sin(x) + (x^2)/2 - 10;

% Define the interval [a,b] here
a = -5;
b = -4;

% State when to stop. |f(ci)| < limit
limit = 0.005;

%% Workings

fprintf("\nBISECTION METHOD\n");

if f(a)*f(b) > 0
    fprintf('No roots in the interval.');
    return
end

if f(a) == 0
    fprintf('x1 is a root!');
    return
elseif f(b) == 0
    fprintf('x2 is a root!');
    return
end

i = 0;

%%

fprintf("\n\nci = (ai + bi)/2\n\n");

fprintf("\nbisection\ta\t\t\tmid\t\t\tb\t\t\tf(a)\t\tf(mid)\t\tf(b)\t\t|b-a|\n");

%%

while abs(a-b) > limit
    mid = (a+b)/2;
    i = i + 1;
    fprintf("%d\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t", i, a, mid, b);
    fprintf("%.4f\t\t%.4f\t\t%.4f\t\t%.5f\n", f(a), f(mid), f(b), abs(a-b));
    if f(a)*f(mid) < 0
        b = mid;
    elseif f(b)*f(mid) < 0
        a = mid;
    end
end

mid = (a+b)/2;
i = i + 1;
fprintf("%d\t\t\t%.4f\t\t%.4f\t\t%.4f\t\t", i, a, mid, b);
fprintf("%.4f\t\t%.4f\t\t%.4f\t\t%.5f\n", f(a), f(mid), f(b), abs(f((a+b)/2)));
if f(a)*f(mid) < 0
    b = mid;
elseif f(b)*f(mid) < 0
    a = mid;
end

fprintf('\nRoot = %.9f\nNumber of bisections = %d\n', mid, i);


