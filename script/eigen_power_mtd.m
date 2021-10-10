clc;

% Eigenvalues - Power Method

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    %% Input matrices

    fprintf("EIGENVALUES: POWER METHOD\n");
    fprintf("\nThis program is used to approximate the eigenvalue (\x03BB) of a 3x3 matrix.\n");
    fprintf("\nAx = \x03BBx\n");
    
    % Define matrix A

    if exist('A','var') ~= 0 && nnz(A) ~= 0
        fprintf("\nSeems like you have defined matrix A.\n");
        disp(A);
        fprintf("Would you like to keep it?\ny: Yes, continue to matrix x.\nn: No, I want to change matrix A.\n");

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
        fprintf("Input matrix A.\n\nMatrix A:\n");
        rows = 3;
        colms = 3;

        A = zeros(rows, colms);

        % input values for A
        fprintf("\nInput values for matrix A:\n")
        for i = 1:rows
            for j = 1:colms
                fprintf("\n");
                disp(A);
                fprintf("R%d,C%d", i, j)
                val_a = input("> ");
                % failsafe
                while ~strcmpi(class(val_a),'double') || isempty(val_a) == 1
                    fprintf("R%d,C%d", i, j);
                    val_a = input("> ");
                end
                A(i,j) = val_a;
            end
        end
        fprintf("\n");
        disp(A);

        fprintf("\nConfirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
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
            fprintf("\nCurrent matrix A:\n")
            disp(A);
            fprintf("Where to change?\n")
            val_r = input("Row: ");
            % failsafe
            while ~strcmpi(class(val_r),'double') || isempty(val_r) == 1
                val_r = input("Row: ");
            end
            val_c = input("Column: ");
            % failsafe
            while ~strcmpi(class(val_c),'double') || isempty(val_c) == 1
                val_c = input("Row: ");
            end
            fprintf("Insert value:\n")
            fprintf("R%d,C%d", val_r, val_c);
            val_a = input("> ");
            % failsafe
            while ~strcmpi(class(val_a),'double') || isempty(val_a) == 1
                fprintf("R%d,C%d", val_r, val_c);
                val_a = input("> ");
            end
            A(val_r,val_c) = val_a;
            fprintf("\n");
            disp(A);
            fprintf("\nDone? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
        end
    end
    
    % input values for x

    if exist('x','var') == 1 && nnz(x) ~= 0
        fprintf("\nSeems like you have defined matrix x.\n");
        disp(x);
        fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change matrix x.\n");

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
    else
        str = 'n';
        x = zeros(rows,1);
    end

    while exist('x','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
        
        x = zeros(rows,1);
        
        fprintf("\nNext,\nmatrix x must be a column matrix with the same row number as matrix A.\n")
        fprintf("Input values for matrix x:\n")
        for i = 1:rows
            fprintf("\n");
            disp(x);
            fprintf("R%d,C1", i)
            val_x = input("> ");
            % failsafe
            while ~strcmpi(class(val_x),'double') || isempty(val_x) == 1
                fprintf("R%d,C%d", i, j);
                val_x = input("> ");
            end
            x(i,1) = val_x;
        end
        fprintf("\n");
        disp(x);

        fprintf("\nConfirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
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
            fprintf("Which one do you want to edit?\n1: Dimension\n2: Value\n");
            prompt = input("> ");
            while prompt ~= 1 && prompt ~= 2
                fprintf("INVALID INPUT\n");
                prompt = input("> ");
            end

            if prompt == 1
                fprintf("Please press Ctrl+C to restart. Thank you!\n");
                return
            end

            fprintf("Current matrix x:\n");
            fprintf("\n");
            disp(x);
            fprintf("Where to change?\n");
            val_rx = input("Row: ");
            % failsafe
            while ~strcmpi(class(val_rx),'double') || isempty(val_rx) == 1
                val_rx = input("Row: ");
            end
            fprintf("Insert value:\n")
            fprintf("R%d,C1", val_rx);
            val_x = input("> ");
            % failsafe
            while ~strcmpi(class(val_x),'double') || isempty(val_x) == 1
                fprintf("R%d,C1", val_rb);
                val_x = input("> ");
            end
            x(val_rx,1) = val_x;
            disp(x);
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
            %failsafe
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
        end
    end
    
    %% Choose a stopping condition
    fprintf("\nSince this program is an iteration, please choose a stopping condition.\n");
    fprintf("\n1. Set a fixed number of iterations.\n2. Stop when the change of \x03BB is less than a certain value.\n");
    choice = input("> ");
    % failsafe
    while ~strcmpi(class(choice),'double') || isempty(choice) == 1
        choice = input("> ");
    end
    
    while choice ~= 1 && choice ~= 2
        choice = input("> ");
    end
    
    % How many iterations?
    if choice == 1
        fprintf("\nHow many iterations?\n");
        iter = input("> ");
        % failsafe
        while ~strcmpi(class(iter),'double') || isempty(iter) == 1
            iter = input("> ");
        end
    end
    
    % Stopping condition?
    if choice == 2
        fprintf("\nStop when the change of \x03BB is less than ______.\n");
        limit = input("> ");
        % failsafe
        while ~strcmpi(class(limit),'double') || isempty(limit) == 1
            limit = input("> ");
        end
        limit = abs(limit);
    end
    
    %% Calculations
    
    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");
    
    if choice == 1
        for i = 1:iter
            fprintf("\n--------------------------------------------------------------------------------------------------------------------------------------\n");
            fprintf("\nITERATION %d\n", i);
            fprintf("\nA = \n");
            disp(A);
            fprintf("\nx = \n");
            disp(x);
            
            % 1. A*x
            prod = A*x;
            fprintf("\nAx = \n");
            disp(prod);
            
            % 2. Find the number with the greatest magnitude in lhs
            lambda = max(abs(prod));
            fprintf("\nExtract \x03BB ");
            fprintf("from Ax.\n");
            fprintf("\n\x03BB = %.4f\n\n\x03BB [ ", lambda);
            disp(prod./lambda);
            fprintf(" ]\n");
            
            % 3. Divide prod with the lambda
            new_x = prod./lambda;
            x = new_x;
        end
    end
    
    if choice == 2
        change = inf;
        i = 1;
        while change > limit
            fprintf("\n--------------------------------------------------------------------------------------------------------------------------------------\n");
            fprintf("\nITERATION %d\n", i);
            fprintf("\nA = \n");
            disp(A);
            fprintf("\nx = \n");
            disp(x);
            
            % 1. A*x
            prod = A*x;
            fprintf("\nAx = \n");
            disp(prod);
            
            % 2. Find the number with the greatest magnitude in lhs
            lambda = max(abs(prod));
            fprintf("\nExtract \x03BB ");
            fprintf("from Ax.\n");
            fprintf("\n\x03BB = %.4f\n\n\x03BB [ ", lambda);
            disp(prod./lambda);
            fprintf(" ]\n");
            
            % Compute the change in lambda
            if i ~= 1
                change = abs(lambda - old_lambda);
            end
            old_lambda = lambda;
            
            % 3. Divide prod with the lambda
            new_x = prod./lambda;
            x = new_x;
            
            i = i + 1;
        end
        fprintf("\n--------------------------------------------------------------------------------------------------------------------------------------\n");
    end
    
    fprintf("\n\x03BB = %.4f\n", lambda);
    fprintf("\nvector u = \n");
    disp(x);
    
    fprintf("\n\n *** END ***\n\n");
    
    fprintf("\nWould you like to do another one? [y/n]\n");
    repeat = input("> ", 's');
    % Failsafe
    while ~strcmpi(repeat,'y') && ~strcmpi(repeat,'Y') && ~strcmpi(repeat,'N') && ~strcmpi(repeat,'n')
        repeat = input("[y/n]> ", 's');
    end
    
    if strcmpi(repeat,'y') || strcmpi(repeat,'Y')
        fprintf("\n\n____________________________________________________________________________________________________________________________________\n\n");
    else
        break
    end
end

fprintf("\n\nTHANK YOU and ALL THE BEST\n\n");

while 1
    
end
