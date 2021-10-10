function [L U]=LU_DooLittle(A)

clc
[m n]=size(A);
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
