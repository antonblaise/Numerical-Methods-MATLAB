% Cholesky and Doolittle methods

clc;

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    %% Input matrices
    % define dimensions

    fprintf("CHOLESKY and DOOLITTLE METHODS\n");
    fprintf("\nThis MATLAB code is used for solving 2D matrices problems and simultaneous equations.\n");
    fprintf("\nAx = b\n");
    fprintf("LUx = b\n");
    fprintf("Ux = y\n");
    fprintf("Ly = b\n");

    if exist('A','var') ~= 0 && nnz(A) ~= 0
        fprintf("\nSeems like you have defined matrix A.\n");
        fprintf("\nA = \n");
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
                fprintf("\nA = \n");
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
        fprintf("\nA = \n");
        disp(A);

        fprintf("\nConfirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
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

            fprintf("Current matrix A:\n");
            fprintf("\nA = \n");
            disp(A);
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
            fprintf("\nA = \n");
            disp(A);
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
            % Failsafe
            while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
                str = input("[y/n]> ", 's');
            end
        end
    end

    if exist('b','var') ~= 0
        fprintf("\nSeems like you have defined matrix b.\n");
        fprintf("\nb = \n");
        disp(b);
        fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change matrix b.\n");

        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end
    else
        str = 'n';
        b = zeros(rows,1);
    end

    %% input values for b

    if strcmpi(str,'N') || strcmpi(str,'n')
        fprintf("\nNext,\nmatrix b must be a column matrix with the same row number as matrix A.\n");
        b = zeros(rows,1);
        fprintf("Input values for matrix b:\n");
        for i = 1:rows
            fprintf("\nb = \n");
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
        fprintf("\nb = \n");
        disp(b);

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
            fprintf("Insert value:\n")
            fprintf("R%d,C1", val_rb);
            val_b = input("> ");
            b(val_rb,1) = val_b;
            fprintf("\nb = \n");
            disp(b)
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
        end
        % Ordinary method
        ans_ordinary = A\b;

        fprintf("\nMatrices:\n");
        fprintf("\nA = \n");
        disp(A)
        fprintf("\nb = \n");
        disp(b)
    end


    %% Choose a method, Cholesky or DooLittle

    fprintf("\nPlease choose a method:\n");
    fprintf("1. Cholesky method\n2. DooLittle method\n");
    prompt = input("> ");

    while prompt ~= 1 && prompt ~= 2
        fprintf("INVALID INPUT\n");
        prompt = input("> ");
    end

    %% Start solving

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");

    if prompt == 1
        fprintf("\nUsing Cholesky method\n");
        % A = LU
        fprintf("\nStep 1:\n");
        fprintf("\nLet A = LU\n");
        fprintf("\nUsing Cholesky Factorisation:\n")
        L = chol(A, 'lower');
        U = chol(A, 'upper');
        fprintf("\nL = \n");
        disp(L);
        fprintf("\nU = \n");
        disp(U);
    end

    if prompt == 2
        fprintf("\nUsing DooLittle method\n");
        fprintf("\nStep 1:\n");
        fprintf("\nLet A = LU\n");
        fprintf("\nUsing DooLittle Decomposition:\n")
        [m,n]=size(A);
        L=zeros(size(A));
        U=zeros(size(A));
        U(1,:)=A(1,:);
        L(:,1)=A(:,1)/U(1,1);
        L(1,1)=1;
        for k=2:m
            for i=2:m
                for j=i:m
                    U(i,j)=A(i,j)-dot(L(i,1:i-1),U(1:i-1,j));
                end
                L(i,k)=(A(i,k)-dot(L(i,1:k-1),U(1:k-1,k)))/U(k,k);
            end
        end
        fprintf("\nL = \n");
        disp(L);
        fprintf("\nU = \n");
        disp(U);
    end

    fprintf("\nStep 2: Ly = b\n");
    fprintf("\nBack substitution\n");
    y = zeros(3,1);
    y(1) = b(1)/L(1,1);
    y(2) = (b(2) - L(2,1)*y(1))/L(2,2);
    y(3) = (b(3) - L(3,1)*y(1) - L(3,2)*y(2))/L(3,3);
    fprintf("\ny = \n");
    disp(y);

    fprintf("\nStep 3: Ux = y\n");
    fprintf("\nBack substitution again\n");
    x = zeros(3,1);
    x(3) = y(3)/U(3,3);
    x(2) = (y(2) - U(2,3)*x(3))/U(2,2);
    x(1) = (y(1) - U(1,2)*x(2) - U(1,3)*x(3))/U(1,1);
    fprintf("\nx = \n");
    disp(x);

    fprintf("\nx = %.4f; y = %.4f; z = %.4f\n",x(1),x(2),x(3));

    fprintf("\n*** END ***\n\n");
    
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


