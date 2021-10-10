
clc;

%% Taylor Series
repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    
    fprintf("INITIAL VALUE PROBLEM: TAYLOR SERIES\n");

    % declare x and y only if x does not exist yet
    if ~exist('x','var') || ~strcmpi(class(x), 'double') || nnz(x) == 0
        syms x y
    end

    % define function
    if ~exist('f','var') || isempty(f)
        % f(x)
        f(x,y) = input("\ndy/dx = f'(x,y) = y' = ");
    elseif exist('f','var')
        fprintf("\nSeems like you have defined f'(x,y)\n\nf'(x,y) = ");
        disp(f);
        fprintf("\nWould you like to keep it?\ny: Yes, please continue.\nn: No, I want to change f'(x,y).\n");
        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end

        if strcmpi(str,'n') || strcmpi(str,'N')
            f(x,y) = input("\ndy/dx = f'(x,y) = y' = ");
        end
    end

    %% insert values of x

    if ~exist('x','var') || ~strcmpi(class(x), 'double') || nnz(x) == 0
        % array size
        fprintf("\nHow many values of x are given? **Including the one in y(x)**\n");
        num_x = input("> ");
        % failsafe
        while ~strcmpi(class(num_x),'double') || isempty(num_x) == 1
            num_x = input("> ");
        end

        x = zeros(1, num_x);

        % Choose an option
        fprintf("\nPlease choose an option below.\n");
        fprintf("1. Define values of x with the first value (x[0]) and the step size (h).\n");
        fprintf("2. Key in the values one by one.\n");
        option = input("> ",'s');
        % failsafe
        while ~strcmpi(option,'1') && ~strcmpi(option,'2')
            option = input("> ");
        end

        % values
        if strcmpi(option,'1')
            fprintf("\nx[0] = ");
            x0 = input("");
            % failsafe
            while ~strcmpi(class(x0),'double') || isempty(x0) == 1
               x0 = input("> ");
            end
            x(1) = x0;
            fprintf("\nStep size, h = ");
            h = input("");
            % failsafe
            while ~strcmpi(class(h),'double') || isempty(h) == 1
                h = input("> ");
            end

            % put in the values
            for i = 2:num_x
                x(i) = x(i-1) + h;
            end
        end

        if strcmpi(option,'2')
            for i = 1:num_x
                fprintf("\nx = ");
                disp(x);
                fprintf("\nx%d = ", i-1);
                x(i) = input("");
            end
        end
        
        % confirm
        fprintf("\nx = ");
        disp(x);
        if strcmpi(option,'2')
            h = abs(x(1)-x(2));
            fprintf("\n(Auto detected) h = %.4f\n", h);
        end
        fprintf("\nConfirm? [y/n]\n");
        confirm = input("> ",'s');
        % failsafe
        while ~strcmpi(confirm,'y') && ~strcmpi(confirm,'Y') && ~strcmpi(confirm,'N') && ~strcmpi(confirm,'n')
            confirm = input("[y/n]> ",'s');
        end

        % if not confirmed, proceed to edit
        if confirm == 'N' || confirm == 'n'
            to_edit = true;
        else
            to_edit = false;
        end
    else
        fprintf("\nSeems like you have given me the x values.\nx = ");
        disp(x);
        fprintf("\nWould you like to keep them?\ny. Yes.\nn. No. I want to edit them.\n");
        choice = input("> ",'s');
        % failsafe
        while ~strcmpi(choice,'y') && ~strcmpi(choice,'Y') && ~strcmpi(choice,'N') && ~strcmpi(choice,'n')
            choice = input("> ");
        end

        % if wanna edit, proceed to edit
        if strcmpi(choice, 'n') || strcmpi(choice, 'N')
           to_edit = true; 
        else
           to_edit = false;
        end
    end

    %% If to_edit == true, then let's edit x values

    if to_edit == true
        done = false; % we are not done with editing
        fprintf("\nThese are the values of x from x0 to x%d.\n", num_x-1);
        while done == false
            fprintf("\nx = ");
            disp(x);
            fprintf("\nWhich x do you want to change?\n");
            index_x = input("x?> ");
            % failsafe
            while ~strcmpi(class(index_x),'double') || isempty(index_x) == 1 || index_x < 0 || index_x > num_x-1
                index_x = input("x?> ");
            end

            fprintf("\nx%d = ", index_x)
            x(index_x+1) = input("");
            fprintf("\nx = ");
            disp(x);
            fprintf("\nDone? [y/n]\n");
            isdone = input("> ",'s');
            % failsafe
            while ~strcmpi(isdone,'y') && ~strcmpi(isdone,'Y') && ~strcmpi(isdone,'N') && ~strcmpi(isdone,'n')
                isdone = input("[y/n]> ");
            end

            if strcmpi(isdone,'y') || strcmpi(isdone,'Y')
                done = true;
            end
        end
    end

    %% Some more settings

    % which order?
    fprintf("\nOrder = ");
    order = input("");
    % failsafe
    while ~strcmpi(class(order), 'double') || isempty(order)
        order = input("Order = ");
    end
    
    if ~exist('yx','var') || isempty(yx)
        % is y(x) given?
        fprintf("\nIs y(x) given? [y/n]\n");
        prompt = input("> ", 's');
        while ~strcmpi(prompt,'y') && ~strcmpi(prompt,'Y') && ~strcmpi(prompt,'N') && ~strcmpi(prompt,'n')
            prompt = input("[y/n]> ", 's');
        end
        % if yes, ...
        if strcmpi(prompt, 'y') || strcmpi(prompt, 'Y')
            yx = input("y(x) = ");
        end
    elseif exist('yx','var')
        fprintf("\nSeems like you have defined y(x)\n\ny(x) = ");
        disp(yx);
        fprintf("\nWould you like to keep it?\ny: Yes, please continue.\nn: No, I want to change y(x).\n");
        str2 = input("> ", 's');
        % Failsafe
        while ~strcmpi(str2,'y') && ~strcmpi(str2,'Y') && ~strcmpi(str2,'N') && ~strcmpi(str2,'n')
            str2 = input("[y/n]> ", 's');
        end

        if strcmpi(str2,'n') || strcmpi(str2,'N')
            yx = input("\ny(x) = ");
        end
    end
    
    %% Display
    
    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");
    
    % display
    fprintf("\nTaylor Series order of %d\n", order);
    fprintf("\ny[i+1] = \ny[i] ");
    for i = 1:order
        if i == 1
            fprintf("\n+ hy");
            for j = 1:i
               fprintf("'");
            end
            fprintf("x[i]");
        else
            fprintf("\n+ { (h^%d)/%d! }y", i, i);
            for j = 1:i
               fprintf("'");
            end
            fprintf("x[i]");
        end
    end
    
    % derivatives
    ori_f = f;
    for i = 1:order
        if i == 1
            fprintf("\n\ny' = ");
            disp(f);
        else
            fprintf("\ny");
            for j = 1:i
               fprintf("'"); 
            end
            fprintf(" = y");
            for k = 1:i-1
                fprintf("'"); 
            end
            fprintf(" + ");
            disp(f);
        end
        f = diff(f);
    end
    
    f = ori_f;
    
    %% Calculations
    
    power = zeros(1, order);
    for i = 1:order
       power(i) = i; 
    end
    
    fact = factorial(power);
    h = h.*ones(1, order);
    numer_h = h.^power;
    coeff = numer_h./fact;
    
    %%
    
    clc;
    
    fprintf("\ni\t\tx[i]\t\ty[i]");
    for i = 1:order
       fprintf("\t\t\ty[i]");
       for j = 1:i
           fprintf("'");
       end
    end

    for i = 1:num_x
        
    end
    
    f = ori_f;
    
    %% Ending
    
    fprintf("\n\n\n *** END ***\n\n");
    
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








