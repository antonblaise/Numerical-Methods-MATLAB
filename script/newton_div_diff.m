%% Newton's Division Difference Interpolation

clc;

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')

    fprintf("NEWTON'S DIVISION DIFFERENCE INTERPOLATION\n");

    % Create the table
    fprintf("\n-------------------------------\n");
    fprintf("|  x   |    |    |  ...  |    |\n");
    fprintf("| f(x) |    |    |  ...  |    |\n");
    fprintf("-------------------------------\n");

    %% Check if x is already defined

    if exist('x','var') ~= 0
        fprintf("\nSeems like you have defined x values.\n");
        disp(x);
        fprintf("Would you like to keep it?\ny: Yes, continue to f(x).\nn: No, I want to change x values.\n");

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

        % Top
        fprintf("\n--------");
        for i = 1:prompt
           fprintf("------"); 
        end
        % x
        fprintf("\n|  x   |");
        for i = 1:prompt
           fprintf("     |");
        end
        % f(x)
        fprintf("\n| f(x) |");
        for i = 1:prompt
           fprintf("     |"); 
        end
        % Bottom
        fprintf("\n--------");
        for i = 1:prompt
           fprintf("------"); 
        end
        fprintf("\n\n");

        length = prompt;

        %% Insert values for x
        fprintf("x = ");
        disp(x);
        fprintf("Insert values for x\n");

        % x
        for i = 1:length
            fprintf("x%d", i);
            val_x = input("> ");
            while ~strcmpi(class(val_x),'double') || isempty(val_x) == 1
                val_x = input("> ");
            end
            x(1,i) = val_x;
            fprintf("\nx = ");
            disp(x);
        end

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
            disp(x)
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
        end
    end

    %% Check if f(x) is already defined

    if exist('fx','var') == 1 && nnz(fx) ~= 0
        fprintf("\nSeems like you have defined f(x) values.\n");
        disp(fx);
        fprintf("Would you like to keep it?\ny: Yes, continue to solving.\nn: No, I want to change f(x) values.\n");

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

        % Make sure f(x) is also a horizontal array or a 1-row matrix.
        if size(fx,1) ~= 1
           fx = transpose(fx); 
        end

    else
        str = 'n';
    end

    %% Insert sizes for f(x)

    while exist('fx','var') == 0 || strcmpi(str,'n') || strcmpi(str,'N')

        fx = zeros(1,length);

        % Top
        fprintf("\n--------");
        for i = 1:length
           fprintf("------------"); 
        end
        % x
        fprintf("\n|  x   |");
        for i = 1:length
           fprintf("  %.4f  |", x(i));
        end
        % f(x)
        fprintf("\n| f(x) |");
        for i = 1:length
           fprintf("           |"); 
        end
        % Bottom
        fprintf("\n--------");
        for i = 1:length
           fprintf("------------"); 
        end
        fprintf("\n\n");

        fprintf("f(x) = ");
        disp(fx);
        fprintf("Insert values for f(x)\n");

        % fx
        for i = 1:length
            fprintf("y%d", i);
            val_y = input("> ");
            while ~strcmpi(class(val_y),'double') || isempty(val_y) == 1
                val_y = input("> ");
            end
            fx(1,i) = val_y;
            fprintf("\nf(x) = ");
            disp(fx);
        end

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

            fprintf("Current f(x) values:\n")
            disp(fx);
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
            fx(1, val_w) = val_y;
            disp(fx)
            fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
            str = input("> ", 's');
        end
    end

    %% Display everything

    % Top
    fprintf("\n--------");
    for i = 1:length
       fprintf("------------"); 
    end
    % x
    fprintf("\n|  x   |");
    for i = 1:length
       fprintf("  %.4f  |", x(i));
    end
    % f(x)
    fprintf("\n| f(x) |");
    for i = 1:length
       fprintf("  %.4f  |", fx(i)); 
    end
    % Bottom
    fprintf("\n--------");
    for i = 1:length
       fprintf("------------"); 
    end
    fprintf("\n\n");

    %% Solving

    A = zeros(length, length-1);
    y = transpose(fx);
    a = [y A];
    A = a;
    
    count = 1;

    for j = 2:length
        for i = 1:length-count
            A(i,j) = (A(i+1,j-1) - A(i,j-1)) / (x(i+j-1) - x(i));
        end
        count = count + 1;
    end

    %% Ask if client wants to insert an x value for interpolation

    fprintf("\nWe will get an interpolating polynomial function p%d(x) in the end.\n", length-1);
    fprintf("\nWould you like to enter an x value into p%d(x) for interpolation?\n[y/n]\n", length-1);
    str = input("> ", 's');
    % Failsafe
    while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
        str = input("[y/n]> ", 's');
    end

    if strcmpi(str,'y') || strcmpi(str,'Y')
        fprintf(" \n");
        prompt = input("x = ");
        % Failsave
        while ~strcmpi(class(prompt),'double') || isempty(prompt) == 1
            prompt = input("x = ");
        end
        xp = prompt;
    else
        xp = 0;
    end
    %% Display answer in a proper table

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");

    fprintf("\ni\tx\t\t\tf(x)\t\t\t");
    for i = 1:length-1
        if i == length - 1
            fprintf("Round %d\t\t\t\n", i);
        else
            fprintf("Round %d\t\t\t", i);
        end
    end

    [r,c] = size(A);

    count = 0;
    for i = 1:r
        fprintf("%d\t%.4f\t\t",i,x(i));
        for k = 1:length-count
           if k == length - count
               fprintf("%.7f\n",A(i,k));
           else
               fprintf("%.7f\t\t",A(i,k)); 
           end
        end
        count = count + 1;
    end

    poly = A(1,:);

    sum = 0;

    fprintf("\np%d(x) = \n", length-1);
    for i = 1:length
        prod = poly(i);
        if poly(i) ~= 0
            if i == 1
                fprintf("\n%.7f", poly(i));
            else
                fprintf("\n + %.7f", poly(i));
                for j = 1:i-1
                    fprintf("( x - %.4f )", x(j));
                    prod = prod * (xp - x(j));
                end
            end
        end
        sum = sum + prod;
    end

    px = sum;
    
    % if an x value is given
    if strcmpi(str,'y') || strcmpi(str,'Y')
        fprintf("\n\nGiven by you, x = %.4f\n", xp)
        fprintf("p%d(%.4f) = %.7f", length-1, xp, px); 
    end

    fprintf("\n\n*** END ***\n\n");

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







