% Determinant of 3x3 matrix, step-by-step

clc;

%% Input the matrix

fprintf("DETERMINANT FINDER OF 3x3 MATRICES (with steps)\n");

A = zeros(rows, rows);

% input values for A
fprintf("\nInput values for matrix A:\n")
for i = 1:rows
    for j = 1:colms
        A
        fprintf("R%d,C%d", i, j)
        val_a = input("> ");
        A(i,j) = val_a;
    end
end
A

fprintf("Confirm? [y/n]\ny: Yes. Please continue.\tn: No. I want to make changes.\n")
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
    A
    fprintf("Where to change?\n")
    val_r = input("Row: ");
    val_c = input("Column: ");
    fprintf("Insert value:\n")
    fprintf("R%d,C%d", val_r, val_c);
    val_a = input("> ");
    A(val_r,val_c) = val_a;
    A
    fprintf("Done? [y/n]\ny: Yes. Please continue.\tn: No. I still need to make changes.\n")
    str = input("> ", 's');
end

%% Answer starts

fprintf("\n######################################################################################################################################\n");
fprintf("\nAnswer script starts HERE:\n");
fprintf("\nUsing Row 1 as reference\n")

mat1 = [A(2,2) A(2,3); A(3,2) A(3,3)];
mat2 = [A(2,1) A(2,3); A(3,1) A(3,3)];
mat3 = [A(2,1) A(2,2); A(3,1) A(3,2)];

mat1
mat2
mat3

fprintf("Substitute the above matrices into their respective places below:\n");

fprintf("\n|A| = %.4f|mat1| - %.4f|mat2| + %.4f|mat3|\n", A(1,1), A(1,2), A(1,3));

fprintf("\n|A| = %.4f*%.4f - %.4f*%.4f + %.4f*%.4f\n", A(1,1), det(mat1), A(1,2), det(mat2), A(1,3), det(mat3));

fprintf("\n|A| = %.4f\n", (A(1,1)*det(mat1)) - (A(1,2)*det(mat2)) + (A(1,3)*det(mat3)));







