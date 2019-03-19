function [CM, acc, arrR, arrP]=func_confusion_matrix(teY, hatY)
% this function is used to calculate the confusion matrix and a set of
% metrics. 
% INPUT: 
%testY, ground-truth lables;
%hatY, predicted labels; 
%OUTPUT
%CM, confuction matrix
%acc, accuracy
%arrR[], per-class recall rate,
%arrP[], per-class prediction rate. 

%% your codes for creating confusion matrix; 
label = unique(teY);
if ~isempty(find(label<0))
    label = sort(label,'descend');
end
CM = zeros( size(unique(teY),1));

for ind = 1:size(teY,1)    
    predit = find(ismember(label,hatY(ind)) );
    actual = find(ismember(label,teY(ind)) );
    CM(actual,predit) = CM(actual,predit) +1;
end

%% your codes for calcuating acc;
Correct_num = sum(diag(CM));
total = sum(CM(:));
acc = Correct_num/total;

%% your codes for calcualting arrR and arrP; 
arrR = []; %    per-class recall rate,
arrP = []; %	per-class prediction rate,

for ind = 1:size(CM,1)    
    %Recall (horizontal)
    total = sum(CM(ind,:)');
    recall = CM(ind,ind) / total;
    
    %Precision (Vertical)
    total = sum(CM(:,ind)');
    precision = CM(ind,ind) / total;
    
    arrR = [arrR;recall];
    arrP = [arrP;precision];

end
