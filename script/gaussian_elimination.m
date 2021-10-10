clc;

% Gaussian Elimination

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    %% Input matrices
    % define dimensions
    fprintf("GAUSSIAN ELIMINATION METHOD\n");
    fprintf("\nThis MATLAB code is used for solving 3x3 matrices problems and 3-variable simultaneous equations.\n");
    fprintf("\nAx = b\n");

    if exist('A','var') ~= 0 && nnz(A) ~= 0
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
        fprintf("Input matrices A and b to solve for x.\n\nMatrix A:\n");
        rows = 3;
        colms = 3;

        A = zeros(rows, colms);

        % input values for A
        fprintf("\nInput values for matrix A:\n\n")
        for i = 1:rows
            for j = 1:colms
                disp(A)
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
        disp(A)

        fprintf("\nConfirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n");
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
                quit
            end

            fprintf("Current matrix A:\n")
            disp(A)
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
            disp(A)
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
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
        b = zeros(rows,1);
    end

    while exist('b','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')
        
        b = zeros(rows,1);
        
        fprintf("\nNext,\nmatrix b must be a column matrix with the same row number as matrix A.\n")
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

            fprintf("Current matrix b:\n")
            disp(b)
            fprintf("Where to change?\n")
            val_rb = input("Row: ");
            % failsafe
            while ~strcmpi(class(val_rb),'double') || isempty(val_rb) == 1
                val_rb = input("Row: ");
            end
            fprintf("Insert value:\n")
            fprintf("R%d,C1", val_rb);
            val_b = input("> ");
            % failsafe
            while ~strcmpi(class(val_b),'double') || isempty(val_b) == 1
                fprintf("R%d,C1", val_rb);
                val_b = input("> ");
            end
            b(val_rb,1) = val_b;
            disp(b)
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


    %%

    % Ordinary method
    ans_ordinary = A\b;
    
    fprintf("\nAx = b\n");
    fprintf("\nMatrices:\n");
    fprintf("\nA =\n");
    disp(A)
    fprintf("\nb =\n");
    disp(b)

    %% Get augmented matrix

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");
    Ab = [A b];
    fprintf("\nAugmented matrix:\n");
    disp(Ab)

    % We want to get Row Echelon Form
    % 1 * *
    % 0 1 *
    % 0 0 1

    %% A(1,1) as pivot element
    
    step = 1;
    
    % First, change A(2,1) and A(3,1) into 0 if needed.
    if Ab(2,1) ~= 0
        fprintf("\nStep %d:\n", step);
        fprintf("\nLet Ab(1,1) = %.4f be the pivot element.\n", Ab(1,1));
        fprintf("Row2 --> Row2 - (%.4f/%.4f)*Row1\n",Ab(2,1),Ab(1,1));
        alpha = Ab(2,1)/Ab(1,1); % alpha is the coefficient that needs to be multiplied to row 1
        Ab(2,:) = Ab(2,:) - alpha*Ab(1,:); % R2 = R2 - alpha*R1;
        disp(Ab);
        step = step + 1;
    end
    
    if Ab(3,1) ~= 0
        fprintf("\nStep %d:\n", step);
        fprintf("\nRow3 --> Row3 - (%.4f/%.4f)*Row1\n",Ab(3,1),Ab(1,1));
        alpha = Ab(3,1)/Ab(1,1);
        Ab(3,:) = Ab(3,:) - alpha*Ab(1,:); % R3 = R3 - alpha*R1;
        disp(Ab);
        step = step + 1;
    end

    if Ab(1,1) ~= 1
        fprintf("\nStep %d:\n", step);
        fprintf("\nMaking sure that Ab(1,1) = 1\n");
        fprintf("R1 --> R1/%.4f\n", Ab(1,1));
        Ab(1,:) = Ab(1,:)/Ab(1,1);
        disp(Ab);
        step = step + 1;
    end
    
    %% A(2,2) as pivot element
    
    if Ab(3,2) ~= 0
        fprintf("\nStep %d:\n", step);
        fprintf("\nLet Ab(2,2) = %.4f be the pivot element.\n", Ab(2,2));
        fprintf("Row3 --> Row3 - (%.4f/%.4f)*Row2\n",Ab(3,2),Ab(2,2));
        alpha = Ab(3,2)/Ab(2,2);
        Ab(3,:) = Ab(3,:) - alpha*Ab(2,:); % R3 = R3 - alpha*R2
        disp(Ab);
        step = step + 1;
    end
    
    if Ab(2,2) ~= 1
        fprintf("\nStep %d:\n", step);
        fprintf("\nMaking sure that Ab(2,2) = 1\n");
        fprintf("R2 --> R2/%.4f\n", Ab(2,2));
        Ab(2,:) = Ab(2,:)/Ab(2,2);
        disp(Ab);
        step = step + 1;
    end

    %% A(3,3) as pivot element
    
    if Ab(3,3) ~= 1
        fprintf("\nStep %d:\n", step);
        fprintf("R3 --> R3/%.4f\n", Ab(3,3));
        Ab(3,:) = Ab(3,:)/Ab(3,3);
        disp(Ab);
        step = step + 1;
    end

    %% Back substitution

    fprintf("\nStep %d: Back substitution\n", step);
    fprintf("\n%.4fx + %.4fy + %.4fz = %.4f\n", Ab(1,1), Ab(1,2), Ab(1,3), Ab(1,4));
    fprintf("\n\t\t%.4fy + %.4fz = %.4f\n", Ab(2,2), Ab(2,3), Ab(2,4));
    fprintf("\n\t\t\t\t%.4fz = %.4f\n", Ab(3,3), Ab(3,4));

    %%
    x = zeros(3,1); % Define and empty matrix to store answers
    x(3) = Ab(3,4)/Ab(3,3); % z = Ab(3,4)/Ab(3,3), can also be Ab(3,end)/Ab(3,3)
    x(2) = (Ab(2,4) - x(3)*Ab(2,3)) / Ab(2,2);
    x(1) = (Ab(1,4) - x(2)*Ab(1,2) - x(3)*Ab(1,3)) / Ab(1,1);

    fprintf("\nAns:\n")
    disp(x)

    fprintf("\nx = %.4f; y = %.4f; z = %.4f\n",x(1),x(2),x(3));

    fprintf("\n *** END ***\n\n");
    
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
