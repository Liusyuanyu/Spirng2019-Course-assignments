% cs653, data mining, HA3. 
% This routine is used to implement the K Nearest Neighbor (KNN) method and
% use it to classify flower samples in the Iris dataset. 

%There are 3 major steps. 

% 
K= 7;  %number of nearest neighbors used for voting. 
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

%% 2.	for each testing sample, calculate its distances to every training sample; 
hatY=zeros(50,1); % predicted classes

% a.	find the top K nearest samples; 
cIdx = [];
for ind = 1:size(teX,1)
    sub_all_train = (trX - teX(ind,:));
    distances = sqrt( sum( (sub_all_train').^2 ) )';
    [M,candidate_ind] = mink(distances,K);
    cIdx = [cIdx;candidate_ind'];
end

% b.	vote to predict the class of the testing sample
for ind =1 : size(cIdx,1)
    candidate_ind = cIdx(ind,:)';
    candidate = trY(candidate_ind);
    candidate_count = [0;0;0];
    candidate_count(1) = size(find(candidate == 1),1);
    candidate_count(2) = size(find(candidate == 2),1);
    candidate_count(3) = size(find(candidate == 3),1);
    [M,I] = max(candidate_count);
    hatY(ind,:) = I;
end

%% 3.	Compute confusion matrix and various metrics
% including accuracy, and per-class recall/precision rates. 
% please implement the following functions
%testY, ground-truth lables;
%hatY, predicted labels; 
%output arguments: confuction matrix, accuracy, per-class recall rate,
%per-class prediction rate. 
[CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY);
