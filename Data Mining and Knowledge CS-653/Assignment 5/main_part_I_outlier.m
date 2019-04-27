
%% starter codes for outline detections in HA6, CS653

load('redwine.mat','X','Y'); % X, feature matrix; Y: ratings of wine samples;  
% hist(Y, 0:10);
%% step 1: generating ground-truth for outliers; 

O=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O(Y>=8 | Y<=3)=1; %labeled as outliers

outlier = find(O==1);
%% step 2: Please use Nearest Neighbor methods to determine outliners. 

Distance = 40;
K_value = 25;
p = 12;
topN = 28;

%% approach A: Data points for which there are fewer than p neighboring points within a distance D
datapoint = 0;
p_fewer_pts = [];
for ind = 1:size(X,1)
    sub_x = (X - X(ind,:)); 
    dist_matrix = sqrt( sum( (sub_x').^2 ) )';
    % K_value+1 because it must contain itself. THe distance of itself is 0
    [k_dist,candidate_ind] = mink(dist_matrix,K_value+1);
        
    num_large_dist = find(k_dist <= Distance);

    if(size(num_large_dist,1) < p+1)
        p_fewer_pts = [p_fewer_pts;ind];
    end
    
end
%%

%% approach B: The top n data points whose distance to the k-th nearest neighbor is greatest
partial_dist = zeros(size(O,1),1);
for ind = 1:size(X,1)
    sub_x = (X - X(ind,:));
    dist_matrix = sqrt( sum( (sub_x').^2 ) )';
    [k_dist,k_candidate_ind] = mink(dist_matrix,K_value+1);
    [~,largest_ind] = maxk(k_dist,1);
    
    temp = k_dist(largest_ind);
    partial_dist(ind,:) = temp; 
end
[~,top_n_dist_ind] = maxk(partial_dist,topN);

%% approach C: The top n data points whose average distance to the k nearest neighbors is greatest
partial_dist= zeros(size(O,1),1);
for ind = 1:size(X,1)
    sub_x = (X - X(ind,:));
    dist_matrix = sqrt( sum( (sub_x').^2 ) )';
    [k_dist,k_candidate_ind] = mink(dist_matrix,K_value+1);
    k_dist(1,:) =[];
    temp = mean(k_dist);
    partial_dist(ind,:) = temp; 
end

[~,top_n_mean_ind] = maxk(partial_dist,topN);

%% step 3: Evaluate and compare the detection results of the above three methods usng confusion matrix and analyze which method works the best on this particular dataset. 


O_A=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O_A(p_fewer_pts)=1; %labeled as outliers
[CM_A, acc_A, ~, ~]=func_confusion_matrix(O,O_A);

O_B=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O_B(top_n_dist_ind)=1; %labeled as outliers
[CM_B, acc_B, ~, ~]=func_confusion_matrix(O,O_B);

O_C=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O_C(top_n_mean_ind)=1; %labeled as outliers
[CM_C, acc_C, ~, ~]=func_confusion_matrix(O,O_C);

clc;
fprintf("A: Fewer than p     : %s\n",acc_A);
fprintf("B: Distance greatest: %s\n",acc_B);
fprintf("c: Distance mean    : %s\n",acc_C);
 

