% cs653, data mining, HA3. 
% This routine is used to apply the Adaboost
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

teX=X(D(101:end), 1:4); %teting samples; 
teY=X(D(101:end),5); %testing labels;
teY(find(teY~=1))=-1;% change any other class to be -1;    

%% Training & Testing	
% You can use the provided function adaboost.m or any other implementation
% available. 

hatY=zeros(50,1); % predicted classes

%Call adaboost('train',datafeatures,dataclass,...) to train an adaboost
%classifier

[~,model]=adaboost('train',trX,trY,80);

%Call [testclass]=adaboost('apply',testdata,model) to predict the classes of
%testing samples. 

[hatY,~]=adaboost('apply',teX,model,80);


%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 


[CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY);
%Input: 
%testY, ground-truth lables;
%hatY, predicted labels; 
%output 
%confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 

