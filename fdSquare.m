function T=fdSquare(n)
    A=zeros(n);
    dx=1/(n+1);
    
    %Bottom row
    A(1,1)=-4; A(1,2)=1;

    %Top row
    A(n,n)=4; A(n,n-1)=1;

    for i=2:n-1
        A(i,i+1)=1;
        A(i,i)=-4;
        A(i,i-1)=1;
    end
    
    T1=kron(eye(n),A)+diag(ones(n*(n-1),1),n)+diag(ones(n*(n-1),1),-n);
    T=T1/dx^2;
end