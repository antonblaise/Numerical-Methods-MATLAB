% Thomas Algorithm

clc;

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    %% Input matrices
    % define dimensions
    fprintf("THOSMAS ALGORITHM or TRIDIAGONAL MATRIX ALGORITHM\n");
    fprintf("\nAx = d\n");

    if exist('A','var') ~= 0
        fprintf("\nSeems like you have defined matrix A.\n");
        disp(A);
        fprintf("Would you like to keep it?\ny: Yes, continue to matrix d.\nn: No, I want to change matrix A.\n");

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
        fprintf("\nInput matrices A and d to solve for x.\n\nMatrix A:\n");
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


    %% input values for b

    if exist('b','var') == 1 && nnz(b) ~= 0
        fprintf("\nSeems like you have defined matrix d.\n");
        disp(b);
        fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change matrix d.\n");

        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end
    else
        str = 'n';
    end

    % input values for d
    while exist('b','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
        fprintf("\nNext,\nmatrix d must be a column matrix with the same row number as matrix A.\n")

        b = zeros(rows,1);

        fprintf("Input values for matrix d:\n")
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

            fprintf("Current matrix d:\n")
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

    %% Reshape A into new_A

    new_A = zeros(size(A,1), 3);

    for i = 1:rows
        % Column 1: b
        if i ~= 1
            new_A(i,1) = A(i,i-1);
        end
        % Column 2: a
        new_A(i,2) = A(i,i);
        % Column 3: c
        if i ~= rows
            new_A(i,3) = A(i,i+1);
        end
    end

    %% Solving: Step 1 - alpha and beta

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");

    alpha = zeros(1, rows);
    beta = zeros(1, rows);

    fprintf("\n\n===== Step 1 - alpha and beta =====\n");

    fprintf("\nalpha[i] = a[i] - c[i-1]*beta[i]\nbeta[i] = b[i] / alpha[k-1]\n")

    for i = 1:rows
        fprintf("\n### i = %d ###\n", i);

        if i == 1
           beta(i) = 0;
           alpha(i) = new_A(i,2);
           fprintf("alpha[%d] = a[1] - 0 = %f\n", i, alpha(i));
           fprintf("beta[%d] = 0\n", i);
        else
           beta(i) = new_A(i,1) ./ alpha(i-1);
           alpha(i) = new_A(i,2) - (new_A(i-1,3).*beta(i));
           fprintf("beta[%d] = b[%d]/alpha[%d] = %f\n", i, i, i-1, beta(i));
           fprintf("alpha[%d] = a[%d] - c[%d]*beta[%d] = %f\n", i, i, i-1, i, alpha(i));
        end
    end

    %% Solving: Step 2 - v

    v = zeros(1, rows);

    fprintf("\n\n===== Step 2 - v =====\n")

    fprintf("\nv[i] = d[i] - beta[i]*v[i-1]\n");

    for i = 1:rows
        fprintf("\n### i = %d ###\n", i);

        if i == 1
           v(i) = b(i);
           fprintf("v[%d] = d[%d] - 0 = %f\n",i, i, v(i))
        else
           v(i) = b(i) - (beta(i).*v(i-1));
           fprintf("v[%d] = d[%d] - beta[%d]*v[%d] = %f\n",i, i, i, i-1, v(i))
        end
    end

    %% Solving: Step 3 - x

    x = zeros(1, rows);

    fprintf("\n\n===== Step 3 - x =====\n")

    fprintf("\nx[i] = ( v[i] - c[i]*x[i+1] ) / alpha[i]\n\n");

    for i = 1:rows
        k = rows + 1 - i;
        if i == 1
            x(k) = v(k) ./ alpha(k);
            fprintf("x[%d] = ( v[%d] - 0 ) / alpha[%d] = %f\n", k, k, k, x(k));
        else
            x(k) = (v(k) - (new_A(k,3).*x(k+1))) ./ alpha(k);
            fprintf("x[%d] = ( v[%d] - c[%d]*x[%d] ) / alpha[%d] = %f\n", k, k, k, k+1, k, x(k));
        end
    end
    
    fprintf("\nTherefore,\n\n");
    for i = 1:rows
        fprintf("x%d = %f\n", i, x(i));
    end
    
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


