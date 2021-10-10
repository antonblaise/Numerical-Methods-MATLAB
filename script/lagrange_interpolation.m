%% Lagrange Interpolation

clc;

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')

    fprintf("LAGRANGE INTERPOLATION\n");

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

    xp = input("x value to interpolate = ");
    while ~strcmpi(class(xp),'double') || isempty(xp) == 1
         xp = input("= ");
    end

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");

    n = length - 1;

    summ = 0;

    for i = 1:length
       prod = 1;
       if i == 1
           fprintf("\nf(x) = (%.4f) * [ ", fx(i));
       else
           fprintf("\n + (%.4f) * [ ", fx(i));
       end
       for j = 1:length
          if j ~= i
             prod = prod * (xp - x(j))/(x(i) - x(j));
             fprintf("(x - %.4f)", x(j));
          end
       end
       fprintf(" / ");
       for k = 1:length
          if k ~= i
              fprintf("(%.4f - %.4f)", x(i), x(k));
          end
       end
       fprintf(" ] ");
       summ = summ + fx(i) * prod;
    end

    yp = summ;

    fprintf("\n\nAns:\n");
    fprintf("\nf(%.4f) = %.4f\n\n", xp, yp);

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


