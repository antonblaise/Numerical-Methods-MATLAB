
clc;

%% Runge Kutta
repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    
    fprintf("INITIAL VALUE PROBLEM: RUNGE KUTTA METHOD\n");

    % declare x and y only if x does not exist yet
    if ~exist('x','var') || ~strcmpi(class(x), 'double') || nnz(x) == 0
        syms x y
    end

    % define function
    if ~exist('f','var') || isempty(f)
        % f(x)
        f(x,y) = input('\nf(x,y) = ');
    elseif exist('f','var')
        fprintf("\nSeems like you have defined f(x,y)\n\nf(x,y) = ");
        disp(f);
        fprintf("\nWould you like to keep it?\ny: Yes, please continue.\nn: No, I want to change f(x,y).\n");
        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end

        if strcmpi(str,'n') || strcmpi(str,'N')
            f(x,y) = input('\nf(x,y) = ');
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

    % y[0] = ?
    y_2 = zeros(size(x));

    fprintf("\ny[0] = y(x[0]) = ");
    y0 = input("");
    while ~strcmpi(class(y0), 'double') || isempty(y0)
        y0 = input("y[0] = y(x[0]) = ");
    end
    y_2(1) = y0;
    y_4 = y_2;

    % do which order? or do all?
    fprintf("\nCalculate for:\n1. 2nd order\n2. 4th order\n3. Both.\n");
    order = input("> ");
    % failsafe
    while order ~= 1 && order ~= 2 && order ~= 3
        order = input("> ");
    end


    %% Calculations

    fprintf("\n######################################################################################################################################\n");
    fprintf("\nAnswer script starts HERE:\n");

    % 2nd order
    if order == 1 || order == 3
        % display
        fprintf("\n### 2nd order Runge Kutta ###\n\nHeun's method\n");
        fprintf("\ny[i+1] = y[i] + ( 1/2 )( k[1] + k[2] )\n");
        fprintf("\nwhere\nk[1] = hf( x[i], y[i] )\nk[2] = hf( x[i]+h, y[i]+k[1] )\n");

        % calculations
        k1_2 = zeros(size(x));
        k2_2 = zeros(size(x));
        fprintf("\ni\tx[i]\t\ty[i]\t\tk1\t\t\tk2\n")
        for i = 1:num_x
            k1_2(i) = h.*f(x(i), y_2(i));
            k2_2(i) = h.*f(x(i)+h, y_2(i)+k1_2(i));
            y_2(i+1) = y_2(i) + (1/2).*(k1_2(i) + k2_2(i));
            if i == num_x
                fprintf("%d\t%.4f\t\t%.4f\n", i-1, x(i), y_2(i));
            else
                fprintf("%d\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n", i-1, x(i), y_2(i), k1_2(i), k2_2(i));
            end
        end

        % final answer
        for i = 2:num_x
            fprintf("\ny(%.4f) ≈ y[%d] = %.4f", x(i), i-1, y_2(i));
        end

        if order == 3
           fprintf("\n\n\n") 
        end

    end

    %% 4th order

    if order == 2 || order == 3
        % display
        fprintf("\n### 4th order Runge Kutta ###\n");
        fprintf("\ny[i+1] = y[i] + ( 1/6 )( k[1] + 2k[2] + 2k[3] + k[4] )\n");
        fprintf("\nwhere\n");
        fprintf("k[1] = hf( x[i], y[i] )\n");
        fprintf("k[2] = hf( x[i]+(h/2), y[i]+(k[1]/2) )\n");
        fprintf("k[3] = hf( x[i]+(h/2), y[i]+(k[2]/2) )\n");
        fprintf("k[4] = hf( x[i]+h, y[i]+k[3] )\n");

        % calculations
        k1_4 = zeros(size(x));
        k2_4 = zeros(size(x));
        k3_4 = zeros(size(x));
        k4_4 = zeros(size(x));

        fprintf("\ni\tx[i]\t\ty[i]\t\tk1\t\t\tk2\t\t\tk3\t\t\tk4\n")
        for i = 1:num_x
            k1_4(i) = h.*f(x(i), y_4(i));
            k2_4(i) = h.*f(x(i)+(h/2), y_4(i)+(k1_4(i)/2));
            k3_4(i) = h.*f(x(i)+(h/2), y_4(i)+(k2_4(i)/2));
            k4_4(i) = h.*f(x(i)+h, y_4(i)+k3_4(i));

            y_4(i+1) = y_4(i) + (1/6).*(k1_4(i) + 2.*k2_4(i) + 2.*k3_4(i) + k4_4(i));

            if i == num_x
                fprintf("%d\t%.4f\t\t%.4f\n", i-1, x(i), y_4(i));
            else
                fprintf("%d\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\t\t%.4f\n", i-1, x(i), y_4(i), k1_4(i), k2_4(i), k3_4(i), k4_4(i));
            end
        end

        % final answer
        for i = 2:num_x
            fprintf("\ny(%.4f) ≈ y[%d] = %.4f", x(i), i-1, y_4(i));
        end
    end

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








