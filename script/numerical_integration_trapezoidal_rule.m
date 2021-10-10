%% Numerical Integration (Trapezoidal Rule)

clc;

repeat = 'y';

while strcmpi(repeat,'Y') || strcmpi(str,'y')
    fprintf("NUMERICAL INTEGRATION (Trapezoidal Rule)\n");
%% Input f(x), lower limit, upper limit and interval
    
    syms x

    if exist('f','var') == 0
        % f(x)
        f = input('\nf(x) = ');
    elseif exist('f','var') ~= 0
        fprintf("\nSeems like you have defined f(x)\n");
        display(f);
        fprintf("\nWould you like to keep it?\ny: Yes, please continue.\nn: No, I want to change f(x).\n");
        str = input("> ", 's');
        % Failsafe
        while ~strcmpi(str,'y') && ~strcmpi(str,'Y') && ~strcmpi(str,'N') && ~strcmpi(str,'n')
            str = input("[y/n]> ", 's');
        end

        if strcmpi(str,'n') || strcmpi(str,'N')
            f = input('\nf(x) = ');
        end
    end

    % lower limit, a
    a = input("Lower limit = ");
    % failsafe
    while ~strcmpi(class(a),'double') || isempty(a) == 1
        a = input("Lower limit = ");
    end


    % upper limit, a
    b = input("Upper limit = ");
    % failsafe
    while ~strcmpi(class(b),'double') || isempty(b) == 1
        a = input("Upper limit = ");
    end

    % interval, n
    n = input("Intervals = ");
    % failsafe
    while ~strcmpi(class(n),'double') || isempty(n) == 1
        n = input("Intervals = ");
    end

    fprintf("\nConfirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n");
    str = input("> ", 's');
    % failsafe
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

    %% Edit values before proceeding if wanted

    while strcmpi(str,'n') || strcmpi(str,'N')
        fprintf("\nWhich one do you want to change?\n");
        fprintf("\n1. ");
        display(f);
        fprintf("2. Lower limit = %d\n3. Upper limit = %d\n4. Intervals = %d\n", a, b, n);
        choice = input("> ");
        % failsafe
        while choice ~= 1 && choice ~= 2 && choice ~= 3 && choice ~= 4
            fprintf("INVALID INPUT\n");
            choice = input("> ");
        end

        % Start editing
        if choice == 1
            % f(x)
            f = input('f(x) = ');
            f(x) = f;
        end
        if choice == 2
            % lower limit, a
            a = input("Lower limit = ");
            % failsafe
            while ~strcmpi(class(a),'double') || isempty(a) == 1
                a = input("Lower limit = ");
            end
        end
        if choice == 3
            % upper limit, a
            b = input("Upper limit = ");
            % failsafe
            while ~strcmpi(class(b),'double') || isempty(b) == 1
                a = input("Upper limit = ");
            end
        end
        if choice == 4
            % interval, n
            n = input("Intervals = ");
            % failsafe
            while ~strcmpi(class(n),'double') || isempty(n) == 1
                n = input("Intervals = ");
            end
        end

        fprintf("\nDone? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n");
        str = input("> ", 's');
        % failsafe
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

    %% Solving

    % fprintf("\n######################################################################################################################################\n");
    % fprintf("\nAnswer script starts HERE:\n");
    
    f(x) = f;
    
    step = (b-a)/n;
    x = zeros(n+1,1);
    y = zeros(n+1,1);
    
    % Coefficients here
    coeff = ones(n+1,1);
    for i = 1:size(coeff,1)
        if i ~= 1 && i ~= size(coeff,1)
            coeff(i) = coeff(i)*2;
        end
    end
    
    % Display integration
    fprintf("\nf(x) = ");
    disp(f);
    fprintf("\n\x222B");
    fprintf(" f(x) dx = ");
    disp(int(f));
    
    % Start of table
    fprintf("\nx\t\t\t\tf(x)\n");

    x(1) = a;
    y(1) = f(x(1));

    fprintf("x0 = %.4f\t\tf0 = %.4f\n", x(1), y(1));

    for i = 2:n+1
        x(i) = x(i-1) + step;
        y(i) = f(x(i));
        fprintf("x%d = %.4f\t\tf%d = %.4f\n", i-1, x(i), i-1, y(i));
    end

    sol = (step/2) * (sum(y.*coeff));
    
    fprintf("\n\x222B");
    fprintf(" f(x) dx = \n");
    fprintf("( %.4f/2 )", step);
    fprintf("[ %.4f", y(1));
    for i = 2:n
       fprintf("\n + 2(%.4f)", y(i)); 
    end
    fprintf("\n + %.4f ]\n", y(n+1));
    
    fprintf("\nAnswer = %f\n", sol);

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



