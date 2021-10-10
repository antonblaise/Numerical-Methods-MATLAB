clc;

% Eigenvalues - Gershgorin Theorem

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    %% Input matrices

    fprintf("EIGENVALUES: GERSHGORIN THEOREM\n");
    fprintf("\nThis program is used to find the range of eigenvalues of a 3x3 matrix.\n");

    % Define matrix A

    if exist('A','var') ~= 0 && nnz(A) ~= 0
        fprintf("\nSeems like you have defined matrix A.\n");
        disp(A);
        fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change matrix A.\n");

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

    %% Calculations

    diagA = diag(A);
    tempA = A;

    % Change the diagonal of matrix A into 0
    for i = 1:rows
       for j = 1:colms
          if j == i
              tempA(i,j) = 0;
          end
       end
    end

    % absolute sum of each row excluding the diagonal
    summ = transpose(sum(abs(transpose(tempA))));

    % We are making circles.

    centers = zeros(rows,2);
    radii = zeros(rows,1);

    for i = 1:rows
        centers(i,:) = [diagA(i) 0];
        radii(i) = summ(i);
    end

    % Determine the upper and lower limits
    upper = diagA + radii;
    lower = diagA - radii;
    range = [lower upper];
    
    %% newtempA
    
    newtempA = tempA;
    
    newtempA(1:size(newtempA,1)+1:end) = [];
    newtempA = reshape(newtempA, size(tempA,1)-1, []);
    newtempA = transpose(newtempA);
    
    %% Visualise the circles
    
    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");
    
    % Statements
    for i = 1:rows
       fprintf("\nDisc C%d: Center = (%d,0) and radius r%d = |%d|", i, diagA(i), i, newtempA(i,1));
       for j = 2:size(newtempA,2)
           fprintf(" + |%d|", newtempA(i,j));
       end
       fprintf(" = %d.\n", radii(i));
    end

    colors = {'b','r','g','y','k','b','r','g','y','k','b','r','g','y','k','b','r','g','y','k','b','r','g','y','k'};

    hold on
    grid on

    xline(0, '--r', 'Linewidth', 1, 'Color', 'black');
    yline(0, '--r', 'Linewidth', 1, 'Color', 'black');

    for k = 1:rows
        scatter(centers(k,1), centers(k,2), 'filled', colors{k});
        viscircles(centers(k,:), radii(k), 'Color', colors{k});
    end
    
    

    %% Display answer

    fprintf("\nThe union of the discs is\n");
    fprintf("\nD = [%d,%d]", range(1,1), range(1,2));
    for i = 2:rows
       fprintf("U[%d,%d]", range(i,1), range(i,2)); 
    end
    
    fprintf("\n\nTherefore, the eigenvalues must lie within D.\n");
    
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



