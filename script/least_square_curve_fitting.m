%% Least Square Curve Fitting

clc;

fprintf("LEAST SQUARE CURVE FITTING\n");

%% Check if x is already defined

if exist('x','var') ~= 0
    fprintf("\nSeems like you have defined x values.\n");
    disp(x);
    fprintf("Would you like to keep it?\ny: Yes, continue to y.\nn: No, I want to change x values.\n");
    
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end
    
    % Make sure x is a horizontal array or 1-row matrix.
    if size(x,1) ~= 1
       x = transpose(x); 
    end
    
    if strcmpi(str,'y') || strcmpi(str,'Y')
        length = size(x,2);
    end
else
    str = 'n';
end


%% Insert sizes for x

while exist('x','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
    fprintf("\nHow many values of x?\n");
    prompt = input("> ");
    while ~strcmpi(class(prompt),'double') || isempty(prompt) == 1 || prompt < 1
        if prompt < 1
            fprintf("INVALID INPUT\n");
            prompt = input("> ");
        else
            prompt = input("> ");
        end
    end

    x = zeros(1,prompt);

    length = prompt;

    %% Insert values for x
    fprintf("\nx =");
    disp(x);
    fprintf("\nInsert values for x\n");

    % x
    for i = 1:length
        fprintf("\nx%d", i);
        val_x = input("> ");
        while ~strcmpi(class(val_x),'double') || isempty(val_x) == 1
            val_x = input("> ");
        end
        x(1,i) = val_x;
        fprintf("\nx = ");
        disp(x);
    end

    fprintf("Confirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
    str = input("> ", 's');

    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
        if strcmpi(str,'n') && strcmpi(str,'N')
            break 
        elseif strcmpi(str,'y') && strcmpi(str,'Y')
            break
        else
            fprintf("INVALID INPUT\n");
        end
    end

    while strcmpi(str,'n') && strcmpi(str,'N')
        fprintf("Which one do you want to edit?\n1: Length\n2: Value\n");
        prompt = input("> ");
        while prompt ~= 1 && prompt ~= 2
            fprintf("INVALID INPUT\n");
            prompt = input("> ");
        end

        if prompt == 1
            fprintf("Please press Ctrl+C to restart. Thank you!\n");
            quit
        end

        fprintf("Current x values:\n")
        disp(x);
        fprintf("Which one to change?\n")
        val_w = input("x?: ");
        % failsafe
        while ~strcmpi(class(val_w),'double') || isempty(val_w) == 1 || val_w > length || val_w < 1
            if val_w > length || val_w < 1
                fprintf("INVALID INPUT\n");
                val_w = input("x?: ");
            else
                val_w = input("x?: ");
            end
        end

        fprintf("Insert value:\n")
        fprintf("x%d", val_w);
        val_x = input("> ");
        % failsafe
        while ~strcmpi(class(val_x),'double') || isempty(val_x) == 1
            fprintf("x%d", val_w);
            val_x = input("> ");
        end
        x(1, val_w) = val_x;
        disp(x);
        fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
        str = input("> ", 's');
    end
end

%% Check if y is already defined

if exist('y','var') == 1 && nnz(y) ~= 0
    fprintf("\nSeems like you have defined y values.\n");
    disp(y);
    fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change y values.\n");
    
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
        if strcmpi(str,'n') && strcmpi(str,'N')
            break 
        elseif strcmpi(str,'y') && strcmpi(str,'Y')
            break
        else
            fprintf("INVALID INPUT\n");
        end
    end
    
    % Make sure y is also a horizontal array or a 1-row matrix.
    if size(y,1) ~= 1
       y = transpose(y); 
    end
    
else
    str = 'n';
end

%% Insert sizes for y

while exist('y','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
    
    y = zeros(1,length);
    
    fprintf("\ny =");
    disp(y);
    fprintf("\nInsert values for y\n");

    % y
    for i = 1:length
        fprintf("\ny%d", i);
        val_y = input("> ");
        while ~strcmpi(class(val_y),'double') || isempty(val_y) == 1
            val_y = input("> ");
        end
        y(1,i) = val_y;
        fprintf("\ny =");
        disp(y);
    end

    fprintf("Confirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
    str = input("> ", 's');

    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
        if strcmpi(str,'n') && strcmpi(str,'N')
            break 
        elseif strcmpi(str,'y') && strcmpi(str,'Y')
            break
        else
            fprintf("INVALID INPUT\n");
        end
    end

    while strcmpi(str,'n') && strcmpi(str,'N')
        fprintf("Which one do you want to edit?\n1: Length\n2: Value\n");
        prompt = input("> ");
        while prompt ~= 1 && prompt ~= 2
            fprintf("INVALID INPUT\n");
            prompt = input("> ");
        end

        if prompt == 1
            fprintf("Please press Ctrl+C to restart. Thank you!\n");
            quit
        end

        fprintf("Current y values:\n")
        disp(y);
        fprintf("Which one to change?\n")
        val_w = input("y?: ");
        % failsafe
        while ~strcmpi(class(val_w),'double') || isempty(val_w) == 1 || val_w > length || val_w < 1
            if val_w > length || val_w < 1
                fprintf("INVALID INPUT\n");
                val_w = input("y?: ");
            else
                val_w = input("y?: ");
            end
        end

        fprintf("Insert value:\n")
        fprintf("y%d", val_w);
        val_y = input("> ");
        % failsafe
        while ~strcmpi(class(val_y),'double') || isempty(val_y) == 1
            fprintf("y%d", val_w);
            val_y = input("> ");
        end
        y(1, val_w) = val_y;
        disp(y)
        fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
        str = input("> ", 's');
    end
end

%% Set the order

fprintf("\nPolynomial of order? (j = ?)\n");
ord = input("> ");
while ~strcmpi(class(ord),'double') || isempty(ord) == 1 || ord < 1
    if ord < 1
        fprintf("INVALID INPUT\n");
        ord = input("> ");
    else
        ord = input("> ");
    end
end

%% Display everything we have so far

fprintf("\nx =");
disp(x);
fprintf("y =");
disp(y);

%% Au = b

% Make matrices A and b
A = zeros(ord+1,ord+1);
b = zeros(ord+1,1);

row_A = size(A,1);
col_A = size(A,2);

row_b = size(b,1);

count = 0;

% Put values into matrix A

for m = 1:row_A
    count2 = count;
    for n = 1:col_A
        if m == 1 && n == 1
            A(m,n) = length;
        else
            A(m,n) = sum(x.^count2);
        end
        count2 = count2 + 1;
    end
    count = count + 1;
end

% Put values into matrix b

count3 = 0;

for m = 1:row_b
    if m == 1
        b(m) = sum(y);
    else
        b(m) = sum((x.^count3).*y);
    end
    count3 = count3 + 1;
end

%% Solving

u = A\b;

trans_u = transpose(u);
coef = fliplr(trans_u);

pow = 0:1:ord;
pow = fliplr(pow);

% 
% val_x = 1.25;
% 
% poly_x = val_x.^pow;
% 
% f = poly_x.*coef;
% f = sum(f);
% 
% fprintf("f(%.4f) = %f\n\n", val_x, f);

%% Answer script

fprintf("\n######################################################################################################################################\n");
fprintf("\nAnswer script starts HERE:\n");

fprintf('\nLet Ax = b\n');
fprintf('\nA = \n\n');
disp(A);
fprintf('\nb = \n\n');
disp(b);

fprintf("\nUse Gaussian Elimination or any other method to solve for x\n");
fprintf('\nx = \n\n');
disp(u);

fprintf("\nFunction of fitted curve:\n");
fprintf("\nf(x) = ");
for i = 1:row_b
    if round(u(i), 4) ~= 0
        if i-1 == 0
            fprintf("%.4f", u(i));
        elseif i-1 == 1
            fprintf(" + %.4fx", u(i));
        else
            fprintf(" + %.4fx^%d", u(i), i-1);
        end
    end
end

fprintf("\n\n*** END ***\n\n");

%% Plotting

spacing = 1000;

xfit = linspace(x(1), x(end), spacing);
yfit = zeros(1, spacing);

poly_x = 0;

for i = 1:spacing
    val_x = xfit(i);
    poly_x = val_x.^pow;
    f = poly_x.*coef;
    yfit(i) = sum(f);
end

scatter(x,y,'filled','red');

hold on
grid on

plot(xfit,yfit,'blue','LineWidth',1);
title('Least Square Curve Fitting');
legend('(x,y)','f(x)','Location','south');
xlabel('x');
ylabel('y, f(x)');

hold off


