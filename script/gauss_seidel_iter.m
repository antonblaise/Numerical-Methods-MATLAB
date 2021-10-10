% Jacobi iteration

clc;

%% Input matrices
% define dimensions
fprintf("GAUSS SEIDEL METHOD\n");
fprintf("\nAx = b\n");

if exist('A','var') ~= 0
    fprintf("\nSeems like you have defined matrix A.\n");
    disp(A);
    fprintf("Would you like to keep it?\ny: Yes, continue to matrix b.\nn: No, I want to change matrix A.\n");
    
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end
    
    if strcmpi(str,'y') || strcmpi(str,'Y')
        rows = size(A,1);
        colms = rows;
    end
else
    str = 'n';
end

while exist('A','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
    fprintf("\nInput matrices A and b to solve for x.\n\nMatrix A:\n");
    fprintf("\nNOTE: Matrix A must be a square matrix, so just tell me how many rows.\n")
    rows = input("\nRows = ");
    %failsafe
    while ~strcmpi(class(rows),'double') || isempty(rows) == 1
        fprintf("\nPlease input a number")
        rows = input("\nRows = ");
    end
    colms = rows;

    A = zeros(rows, colms);

    %% input values for A
    fprintf("\nInput values for matrix A:\n\n")
    for i = 1:rows
        for j = 1:colms
            disp(A)
            fprintf("R%d,C%d", i, j);
            val_a = input("> ");
            % failsafe
            while ~strcmpi(class(val_a),'double') || isempty(val_a) == 1
                fprintf("R%d,C%d", i, j);
                val_a = input("> ");
            end
            A(i,j) = val_a;
        end
    end
    disp(A)

    fprintf("Confirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end

    while strcmpi(str,'n') && strcmpi(str,'N')
        fprintf("Which one do you want to edit?\n1: Dimension\n2: Value\n");
        prompt = input("> ");
        while prompt ~= 1 && prompt ~= 2
            fprintf("INVALID INPUT\n");
            prompt = input("> ");
        end

        if prompt == 1
            fprintf("Please press Ctrl+C to restart. Thank you!\n");
            quit
        end

        fprintf("Current matrix A:\n")
        disp(A)
        fprintf("Where to change?\n")
        val_r = input("Row: ");
        val_c = input("Column: ");
        fprintf("Insert value:\n")
        fprintf("R%d,C%d", val_r, val_c);
        val_a = input("> ");
        % failsafe
        while ~strcmpi(class(val_a),'double')
            fprintf("R%d,C%d", i, j);
            val_a = input("> ");
        end
        A(val_r,val_c) = val_a;
        disp(A)
        fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end
    end
end

%% Check if matrix A is diagonally dominant

d = diag(A);

for i = 1:rows
   row = abs(A(i,:)); % Take the magnitude of every member in row number i of A
   diff = sum(row) - d(i); % Add all the row members except the diagonal member
   if d(i) <= diff
       error("Your matrix A is NOT diagonally dominant, but it should be.");
   end
end

%% input values for b

if exist('b','var') == 1 && nnz(b) ~= 0
    fprintf("\nSeems like you have defined matrix b.\n");
    disp(b);
    fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change matrix b.\n");
    
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end
else
    str = 'n';
end


% input values for b
while exist('b','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
    fprintf("\nNext,\nmatrix b must be a column matrix with the same row number as matrix A.\n")
    
    b = zeros(rows,1);
    
    fprintf("Input values for matrix b:\n")
    for i = 1:rows
        disp(b)
        fprintf("R%d,C1", i)
        val_b = input("> ");
        % failsafe
        while ~strcmpi(class(val_b),'double') || isempty(val_b) == 1
            fprintf("R%d,C%d", i, j);
            val_b = input("> ");
        end
        b(i,1) = val_b;
    end
    disp(b)

    fprintf("Confirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end

    while strcmpi(str,'n') && strcmpi(str,'N')
        fprintf("Which one do you want to edit?\n1: Dimension\n2: Value\n");
        prompt = input("> ");
        % failsafe
        while prompt ~= 1 && prompt ~= 2
            fprintf("INVALID INPUT\n");
            prompt = input("> ");
        end

        if prompt == 1
            fprintf("Please press Ctrl+C to restart. Thank you!\n");
            return
        end

        fprintf("Current matrix b:\n")
        disp(b)
        fprintf("Where to change?\n")
        val_rb = input("Row: ");
        fprintf("Insert value:\n")
        fprintf("R%d,C1", val_rb);
        val_b = input("> ");
        b(val_rb,1) = val_b;
        disp(b)
        fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end
    end
end

%% Set tolerance level

fprintf("\nStop iterating when deviation or error goes smaller than __?__ decimal places.\n");
fprintf("0: stop only when relative error is very close to 0 (relative error < 1e-10).\n")
dp = input("> ");
% failsafe
while ~isa(dp, "double")    
    if isa(dp, "double")
        break
    else
        fprintf("Please give a number\n");
        dp = input("> ");
    end
end

if dp == 0
    tol = 1e-10;
else
    tol = 1/(10^dp);
end

%% Solve Ax = b using Jacobi Iteration

% Make initial guess, let all x = 0
x = zeros(rows,1);

% At first, d was just a column matrix containing the diagonal of A.
% Now, we turn it into a diagonal matrix with the respective members that
% it holds.
% Equivalent to: d =  diag(diag(A));
d = diag(A);

%% Iteration

% set initial error = infinity
err = inf;
count = 0;

fprintf("\n######################################################################################################################################\n");
fprintf("\nAnswer script starts HERE:\n");

for i = 1:rows
    fprintf("\nx%d = [ %.2f ", i, b(i));
    for j = 1:rows
       if j ~= i
          fprintf("- %.2fx%d ", A(i,j), j); 
       end
    end
    fprintf("] / %.2f", d(i));
end

% Title of iteration table
fprintf("\n\nIteration\t");
for k = 1:rows
   fprintf("x%d\t\t\t", k); 
end
fprintf("error");

% Main computation algorithm
while err > tol
    % Display current condition
    fprintf("\n%d\t\t\t", count); % iteration
    for i = 1:rows
       fprintf("%.4f\t\t", x(i)); % x values
    end
    fprintf("%f", err); % current error
    
    x_old = x;
    for i = 1:rows
       numer = b(i);
       for j = 1:rows
           if j ~= i
               numer = numer - A(i,j)*x(j);
           end
       end
       x(i) = numer / d(i);
    end
    err = max(abs(x_old - x));
    count = count + 1;
end

% What do we get when iteration ends?
fprintf("\n%d\t\t\t", count); % iteration
for i = 1:rows
   fprintf("%.4f\t\t", x(i)); % x values
end
fprintf("%f", err);
fprintf("\n\nRelative error = %.11f\n", err);

fprintf("\nAns:\n\n");

for i = 1:rows-1
    fprintf("x%d = %.4f; ", i, x(i));
end
fprintf("x%d = %.4f\n\n", rows, x(rows));










