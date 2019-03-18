% %a.
% a=[1 2 3; 4 5 6];
% a
% size(a)
% b=zeros(size(a)); 
% b
% 
% clear
% 
% c= [  1   2  3  4 ...
%     ; 6   7  8  9 ...
%     ; 10 11 12 13]
% 
% d= c(:)
% d
% 
% %b.
% x=round([1.5 2; 2.2 3.1])
% a=find(x(:)>2);
% x
% a=find(x(:)>1);
% a
% 
% %c.
% a = [1 2; 3 4; 5 6]; 
% b=a(:);
% c=reshape(b, 6,1);

% % 
% % d.
% a=rand(1, 100);
% b=randperm(100);
% dd= b(1:5);
% c=a(b(1:5));

clear
% %e.
% a=[100:200];
% b=[100 101 102]
% b=find(a>120);
% c=a(b); 

% x = [0 1 2 3 4];             % Basic plotting
% plot(x, 2*x);  

% x=1:10;
% y=exp(-x);
% plot(x, y);

% constant = 0.4* ones(length(x),1);
% y = y+constant;

% %1.3.1 •Straight line 
% x=0:21;
% y = x*20;
% y = y+.4;
% plot(x,y);
% xlabel('X');
% ylabel('Y');
% axis([0 20 0 400]);
% title('Straight Line');

% %1.3.2  •Quadratic function
% x=0:19;
% y = (x-20).^2 + 15;
% plot(x,y);
% xlabel('X');
% ylabel('Y');
% axis([0 20 0 430]);
% title('Quadratic');


% %1.3.3 •Log function
% % y=-log(x) and y=-log(1-x)
% x=0:0.1:0.9;
% y = -log(x);
% plot(x,y);
% hold on;   
% y = -log(1-x);
% plot(x,y);
% legend('X', 'X-1','Location','NorthWest');
% hold off;   
% xlabel('X');
% ylabel('Y');
% axis([-0.2 1.2 0 2.5]);
% title('Log');

% %1.3.4 •sigmoid function, y=1/(1+e^(-x))
% % x=0:19;
% x=0:10;
% y = 1./(1 + exp(-x));
% plot(x,y);
% xlabel('X');
% ylabel('Y');
% axis([0 12 0.5 1.1]);
% title('Sigmoid');



%%1.4
% 1.4. Given a matrix A=rand(100,100), write a few lines of code to do each of the following. 
%       Try to avoid using loops.
% a.	Sort all the elements in A, put the result in a single 10,000-dimensional vector x, 
%       and plot the values in x.
% b.	Create a 64-bin histogram bar chart of the elements in A. Use hist();
% c.	Create a new matrix with the same size as A, which is 255 wherever the element in A is greater than a threshold t (e.g., 0.5), and 0 everywhere else; call imagesc() to visualize this matrix as an grayscale image; 
% d.	Create a matrix to store the elements in the bottom right quadrant of A.
% e.	Create a new matrix that is a duplicate of A; Subtract A’s mean value from every element of B; Set any negative element in B to be 0.
% f.	Create a new matrix to include all rows of A whose first column is larger than 0.5 and second column is smaller than 0.8; 
% g.	Create a new matrix by randomly selecting 20 rows from A. 

A = rand(100,100);

% %%A
% % A = rand(100,100);
% x = sort(A(:));
% x = reshape(x, 1, 10000);  
% plot(x);

%%B
hist(A,64);

% %%C
% ind = find (A > 0.5);
% threshold = zeros(size(A));
% TwoFiveFive = 255*ones(size(A));
% threshold(ind) = TwoFiveFive(ind);
% imagesc(threshold);
% colormap gray;
% 
%%D
BotRight = A(end/2+1:end, end/2+1:end); %d
% imagesc(A);

% %%E
% B = A;
% meanA = mean(A(:));    
% B = B - meanA;
% ind = find(B <0);
% ZeroMatrix = zeros(size(B));
% B(ind) = ZeroMatrix(ind);

% %%F
% ind = A(:,1) > 0.5 & A(:,2) < 0.8;
% fmatrix = A(ind,:);

% %G
% ind = randi(100,[1 20]);
% RandMatrix = A(ind,:);

% %%1.5
% rrr = rollsixsidedie();