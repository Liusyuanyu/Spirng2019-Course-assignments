% cs653, data mining, HA3. 
% This routine is used to implement the naive bayes method and
% use it to classify flower samples in the Iris dataset. 

%There are 4 major steps. 

% 
CM=zeros(3,3); %confusion matrix; 
acc=0; % accuracy
arrR=zeros(1,3); % per-class recall rate; 
arrP=zeros(1,3); % per-class precision rate; 

%% Step 1.	Load data and split the samples into two subsets
%one for training, the other for testing. 
load('iris_matrix.mat','X');

D=randperm(150);
%training
trX=X(D(1:100), 1:4); %training samples
trY=X(D(1:100), 5); % training labels;
teX=X(D(101:end), 1:4); %teting samples; 
teY=X(D(101:end),5); %testing labels;

%% 2. Training and Predicting

% Each flower sample is described with four continuous variables: X=(x1, x2,
% x3, x4). There are three possible classes: 1, 2,3, representing 'Iris-setosa',     'Iris-versicolor' and    'Iris-virginica', respectively. 
%  
% Given a test sample, X, we will need to calculate the posterior probability P(class=1|X),P(class=2|X), and P(class=3|X), and find the class tht maximizes a probability. This method is also called MAP method. 
%  
% While it is intractable to get P(class=k|X), according to Bayes we can 
% find a class that maximizes P(X|class=k)p(class=k), instead; we further assume independences among the variables x1, x2, x3, and x4, then, P(X|class=k)=P(x1|class=k)P(x2|class=k)P(x3|class=k)P(x4|class=k). k=1,2,3. 
%  
%  
% Note that x1, x2, x3, and x4 are all continuous values, we introduce a Gaussian distribution to model each variable. 
%  
% In the following,  we will calculate the Gaussian distribution for each variable. 

%a. computes the mean&variance of each variable per class (3)
arrM=zeros(3,4); % 
arrV=zeros(3,4); % variance; 

setosa = trX(  trY ==1 ,: ); % 1 = setosa
versicolor = trX(  trY ==2 ,: ); % 1 = versicolor
virginica = trX(  trY ==3 ,: ); % 1 = virginica

arrM(1,:) = mean(setosa);
arrV(1,:) = var(setosa);

arrM(2,:) = mean(versicolor);
arrV(2,:) = var(versicolor);

arrM(3,:) = mean(virginica);
arrV(3,:) = var(virginica);

%b. calculate the prior distributions P(class=k), k=1,2,3
p_class1 = size(setosa,1)/size(trX,1);
p_class2 = size(versicolor,1)/size(trX,1);
p_class3 = size(virginica,1)/size(trX,1);

%c. with Mean& variance, calculate the product of P(x1|class=k), k=1,2,3
% p_x1_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,1)))*exp(-(sample_X(1,1)-arrM(1,1))^2/(2*arrV(1,1)));
% p_x1_class2 = 1/(sqrt(2*pi)*sqrt(arrV(2,1)))*exp(-(sample_X(1,1)-arrM(2,1))^2/(2*arrV(2,1)));
% p_x1_class3 = 1/(sqrt(2*pi)*sqrt(arrV(3,1)))*exp(-(sample_X(1,1)-arrM(3,1))^2/(2*arrV(3,1)));
sample_X = teX(1,:);
p_x1_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,1)))*exp(-(sample_X(1)-arrM(1,1))^2/(2*arrV(1,1)));
p_x2_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,2)))*exp(-(sample_X(2)-arrM(1,2))^2/(2*arrV(1,2)));
p_x3_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,3)))*exp(-(sample_X(3)-arrM(1,3))^2/(2*arrV(1,3)));
p_x4_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,4)))*exp(-(sample_X(4)-arrM(1,4))^2/(2*arrV(1,4)));
  

% Taking x1 for instance, we have P(x1|class=1)=1/(sqrt(2*pi)*sqrt(Sigma))*exp(-(x1-mu)^2/(2*Sigma)),
%where mu and Sigma are mean and variables, respectively. 
 
%d. Apply the MAP method to select the class that achieves the maximal
%posterior probability, e.g., \arg \max_k, P(X|class=k)P(class=k)

hatY=zeros(50,1); % predicted classes
for ind = 1: 50
    sample_X = teX(ind,:);
    candidate = zeros(3,1);
    p_x1_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,1)))*exp(-(sample_X(1)-arrM(1,1))^2/(2*arrV(1,1)));
    p_x2_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,2)))*exp(-(sample_X(2)-arrM(1,2))^2/(2*arrV(1,2)));
    p_x3_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,3)))*exp(-(sample_X(3)-arrM(1,3))^2/(2*arrV(1,3)));
    p_x4_class1 = 1/(sqrt(2*pi)*sqrt(arrV(1,4)))*exp(-(sample_X(4)-arrM(1,4))^2/(2*arrV(1,4)));
    
    p_x1_class2 = 1/(sqrt(2*pi)*sqrt(arrV(2,1)))*exp(-(sample_X(1)-arrM(2,1))^2/(2*arrV(2,1)));
    p_x2_class2 = 1/(sqrt(2*pi)*sqrt(arrV(2,2)))*exp(-(sample_X(2)-arrM(2,2))^2/(2*arrV(2,2)));
    p_x3_class2 = 1/(sqrt(2*pi)*sqrt(arrV(2,3)))*exp(-(sample_X(3)-arrM(2,3))^2/(2*arrV(2,3)));
    p_x4_class2 = 1/(sqrt(2*pi)*sqrt(arrV(2,4)))*exp(-(sample_X(4)-arrM(2,4))^2/(2*arrV(2,4)));
    
    p_x1_class3 = 1/(sqrt(2*pi)*sqrt(arrV(3,1)))*exp(-(sample_X(1)-arrM(3,1))^2/(2*arrV(3,1)));
    p_x2_class3 = 1/(sqrt(2*pi)*sqrt(arrV(3,2)))*exp(-(sample_X(2)-arrM(3,2))^2/(2*arrV(3,2)));
    p_x3_class3 = 1/(sqrt(2*pi)*sqrt(arrV(3,3)))*exp(-(sample_X(3)-arrM(3,3))^2/(2*arrV(3,3)));
    p_x4_class3 = 1/(sqrt(2*pi)*sqrt(arrV(3,4)))*exp(-(sample_X(4)-arrM(3,4))^2/(2*arrV(3,4)));
    
    one = p_x1_class1*p_x2_class1*p_x3_class1*p_x4_class1*p_x4_class1*p_class1;
    two = p_x1_class2*p_x2_class2*p_x3_class2*p_x4_class2*p_x4_class2*p_class2;
    three = p_x1_class3*p_x2_class3*p_x3_class3*p_x4_class3*p_x4_class3*p_class3;
    
    candidate(1) = p_x1_class1*p_x2_class1*p_x3_class1*p_x4_class1*p_x4_class1*p_class1;
    candidate(2) = p_x1_class2*p_x2_class2*p_x3_class2*p_x4_class2*p_x4_class2*p_class2;
    candidate(3) = p_x1_class3*p_x2_class3*p_x3_class3*p_x4_class3*p_x4_class3*p_class3;
    [~,I] = max(candidate);
    
    hatY(ind) = I;
end

%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 
% please implement the following functions
%testY, ground-truth lables;
%hatY, predicted labels; 
%output arguments: confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 

[CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY);


