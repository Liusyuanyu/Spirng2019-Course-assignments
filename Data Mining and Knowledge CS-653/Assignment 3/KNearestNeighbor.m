function predict=KNearestNeighbor_old(train_data,train_labels, test_data,K_value)

% cIdx = knnsearch(train_data,test_data,'K',K_value);
% 
% sub_all_train = (train_data - test_data(10,:));
% distances = sqrt( sum( (sub_all_train').^2 ) )';
% [M,cIdx2] = mink(distances,K_value);
% 
% 
% predict =[];
% for ind =1 : size(cIdx,1)
%     candidate_ind = cIdx(ind,:)';
%     candidate = train_labels(candidate_ind);
%     candidate_count = [0;0;0];
%     candidate_count(1) = size(find(candidate == 1),1);
%     candidate_count(2) = size(find(candidate == 2),1);
%     candidate_count(3) = size(find(candidate == 3),1);
%     [M,I] = max(candidate_count);
%     predict(end+1,:) = I;
% end

predict = zeros(size(test_data,1),1);
for ind = 1:size(test_data,1)
    sub_all_train = (train_data - test_data(ind,:));
    distances = sqrt( sum( (sub_all_train').^2 ) )';
    [M,candidate_ind] = mink(distances,K_value);
    
    candidate = train_labels(candidate_ind);
    candidate_count = [0;0;0];
    candidate_count(1) = size(find(candidate == 1),1);
    candidate_count(2) = size(find(candidate == 2),1);
    candidate_count(3) = size(find(candidate == 3),1);
    
    [M,I] = max(candidate_count);
    predict(ind,:) = I;
end