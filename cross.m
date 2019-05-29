n=50; %Cross Width
numEvals=200;

dx=1/(n+1);
c=1/dx^2;

A=zeros(5*n^2);

%Fill out 5 squares unconnected (bottom, left, middle, right, top)
for i=0:4
    A(n^2*i+1:n^2*(i+1),n^2*i+1:n^2*(i+1))=fdSquare(n);
end

%Connect bottom square to middle square
for i=1:n
    %A(top row of bottom square, bottom row of middle square)
    A(n^2-n+i,2*n^2+i)=c;
    A(2*n^2+i,n^2-n+i)=c;
end

%Connect left square to middle square
for i=1:n
    %A(right column of left square, left column of middle square)
    A(n^2+n*i,2*n^2+n*(i-1)+1)=c;
    A(2*n^2+n*(i-1)+1,n^2+n*i)=c;
end

%Connect right square to middle square
for i=1:n
    %A(left column of right square, left column of middle square)
    A(3*n^2+n*(i-1)+1,2*n^2+n*i)=c;
    A(2*n^2+n*i,3*n^2+n*(i-1)+1)=c;
end

%Connect top square to middle square
for i=1:n
    %A(bottom row of top square, top row of middle square)
    A(4*n^2+i,3*n^2-n+i)=c;
    A(3*n^2-n+i,4*n^2+i)=c;
end

%disp(A)
%disp(issymmetric(A));


spA=sparse(A);
[V,D]=eigs(spA,numEvals,'smallestabs');


h=figure();
axis tight manual;
filename = 'eigenCross.gif';

for i = 1:numEvals
    displayMatrix=zeros(3*n); %5 squares on cross plus 4 on corners
    eVect=V(:,i);
    
    for j=1:n
        for k=1:n
         displayMatrix(j,n+k)=eVect((j-1)*n+k); %Fill in bottom square
         displayMatrix(n+j,k)=eVect(n^2+(j-1)*n+k); %Fill in left square
         displayMatrix(n+j,n+k)=eVect(2*n^2+(j-1)*n+k); %Fill in middle square
         displayMatrix(n+j,2*n+k)=eVect(3*n^2+(j-1)*n+k); %Fill in right square
         displayMatrix(2*n+j,n+k)=eVect(4*n^2+(j-1)*n+k); %Fill in top square
        end
    end
    pcolor(displayMatrix)
    colormap(gray);
    shading interp;
    colorbar;
    title(strcat('Eigenfunction #: ',num2str(i)));
    drawnow;
    %disp(eVect)
    %disp(displayMatrix)
    
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    if i == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 
end



























