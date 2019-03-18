% cs653, data mining, HA3. 
% This routine is used to apply the Support Vector machine (SVM)
% method to predict if a flower is 'setosa', i.e. label 1 in the matrix X(:,5). 

% 
CM=zeros(3,3); %confusion matrix; 
acc=0; % accuracy
arrR=zeros(1,3); % per-class recall rate; 
arrP=zeros(1,3); % per-class precision rate; 

%% Load data and split the samples into two subsets
%one for training, the other for testing. 
load('iris_matrix.mat','X');

D=randperm(150);
%training
trX=X(D(1:100), 1:4); %training samples
trY=X(D(1:100), 5); % training labels;
trY(find(trY~=1))=-1; % change any other class to be -1;    
% trY(find(trY~=1))=2; % change any other class to be 2; 

teX=X(D(101:end), 1:4); %teting samples; 
teY=X(D(101:end),5); %testing labels;
teY(find(teY~=1))=-1;% change any other class to be -1;    
% teY(find(teY~=1))= 2; % change any other class to be 2; 

%% Training & Testing	

% Please test linear SVM (default option of fitcsvm) and non-linear SVM with RBF kernel.  
% SVMModel = fitcsvm(X,Y, 'KernelFunction','RBF','KernelScale','auto');

hatY=zeros(50,1); % predicted classes

%Call fitcsvm() to train a linear SVM  or kernel SVM
SVMModel = fitcsvm(trX,trY);

%Call predict() to test every test sample
% [~,score] = predict(SVMModel,teX);
hatY = predict(SVMModel,teX);


%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 

[CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY);
%Input: 
%testY, ground-truth lables;
%hatY, predicted labels; 
%output 
%confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 
