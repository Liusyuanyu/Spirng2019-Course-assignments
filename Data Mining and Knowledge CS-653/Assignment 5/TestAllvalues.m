%% starter codes for outline detections in HA6, CS653
clear;clc;

load('redwine.mat','X','Y'); % X, feature matrix; Y: ratings of wine samples;  
% hist(Y, 0:10);
%step 1: generating ground-truth for outliers; 

O=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
O(Y>=8 | Y<=3)=1; %labeled as outliers
Outlier = find(O==1);
%% Approach A Fix distance
count_inner =1;
count =1;
p_list = 2:2:36;
k_list = 5:5:35;
% distance = 27;
% distance = 20;
% distance = 35;
% distance = 15;
distance = 40;
% p_fewer_pts_num = zeros(size(p_list,2),size(k_list,2));
result_A_1 = zeros(size(p_list,2),size(k_list,2));

for K_value = k_list
    count_inner = 1;
    for p_value = p_list
        O_p=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
        p_fewer_pts=[];
        for ind = 1:size(X,1)
            sub_x = (X - X(ind,:)); 
            dist_matrix = sqrt( sum( (sub_x').^2 ) )';
            [k_dist,candidate_ind] = mink(dist_matrix,K_value+1);
            num_large_dist = find(k_dist <= distance);

            if(size(num_large_dist,1) < p_value+1)
                p_fewer_pts = [p_fewer_pts;ind];
            end
        end
        
        O_p(p_fewer_pts)=1; %labeled as outliers
        
        [CM, acc, ~, ~]=func_confusion_matrix(O,O_p);
%         p_fewer_pts_num(count_inner,count) = size(p_fewer_pts,1);
        result_A_1(count_inner,count) = acc;
        count_inner = count_inner+1;
    end
    count = count+1;    
end
result_A_1(end+1,:) = k_list;
% te,[ = p_list()'
result_A_1(1:end-1,end+1) = p_list';

% K = 20, P = 6 ==> 98.06%
% K = 20, P = 18 ==> 97.87%
% K = 20, P = 20 ==> 1.75%

%%  Approach A Fix K=20
count_inner =1;
count =1;
p_list = 4:2:24;
d_list = 10:5:80;
result_A_2 = zeros(size(d_list,2),size(p_list,2));
K_value = 25;
p_fewer_pts_num = zeros(size(d_list,2),size(p_list,2));
for p_value = p_list
    count_inner = 1;
    for distance = d_list
        O_p=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
        p_fewer_pts=[];
        for ind = 1:size(X,1)
            sub_x = (X - X(ind,:)); 
            dist_matrix = sqrt( sum( (sub_x').^2 ) )';
            [k_dist,candidate_ind] = mink(dist_matrix,K_value+1);
            num_large_dist = find(k_dist <= distance);

            if(size(num_large_dist,1) < p_value+1)
                p_fewer_pts = [p_fewer_pts;ind];
            end
        end
        
        O_p(p_fewer_pts)=1; %labeled as outliers
        
        [CM, acc, ~, ~]=func_confusion_matrix(O,O_p);
      
        result_A_2(count_inner,count) = acc;
        p_fewer_pts_num(count_inner,count) = size(p_fewer_pts,1);
        count_inner = count_inner+1;
    end
    count = count+1;    
end
result_A_2(end+1,:) = p_list;
result_A_2(1:end-1,end+1) = d_list';
% K = 20 , P = 12, Distance = 30 ==> 97.94%
% K = 20 , P = 12, Distance = 40 ==> 98.12%

%% Approach B
count_inner =1;
count =1;
% n_list = 5:1:40;
n_list = 0:2:40;
k_list = 14:2:30;
% d_list = 5:5:35;
% K_value = 10;
result_B = zeros(size(n_list,2),size(k_list,2));
all_dist = zeros(size(O,1),1);

for K_value = k_list
    for ind = 1:size(X,1)
        sub_x = (X - X(ind,:));
        dist_matrix = sqrt( sum( (sub_x').^2 ) )';
        [k_dist,k_candidate_ind] = mink(dist_matrix,K_value+1);
        [~,largest_ind] = maxk(k_dist,1);
        temp = k_dist(largest_ind);
        all_dist(ind,:) = temp; 
    end
    
    count_inner = 1;
    for topN = n_list
        O_B=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
        [~,top_n_dist_ind] = maxk(all_dist,topN);
        O_B(top_n_dist_ind)=1; %labeled as outliers
        [CM, acc, ~, ~]=func_confusion_matrix(O,O_B);
        result_B(count_inner,count) = acc;
        count_inner = count_inner+1;
    end
    count = count+1;   
end
result_B(end+1,:) = k_list;
result_B(1:end-1,end+1) = n_list';

% N goes up, and acc goes down

%%

O_test=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
[CM, acc, ~, ~]=func_confusion_matrix(O,O_test);

%% Approach C
count_inner =1;
count =1;
n_list = 0:2:40;
k_list = 2:2:20;
result_C = zeros(size(n_list,2),size(k_list,2));
all_dist = zeros(size(O,1),1);

for K_value = k_list    
    for ind = 1:size(X,1)
        sub_x = (X - X(ind,:));
        dist_matrix = sqrt( sum( (sub_x').^2 ) )';
        [k_dist,k_candidate_ind] = mink(dist_matrix,K_value+1);
        k_dist(1,:) =[];
        temp = mean(k_dist);
        all_dist(ind,:) = temp; 
    end
    
    count_inner = 1;
    for topN = n_list
        O_C=zeros(size(Y)); % outlier labels. 1: outliers; 0: normal; 
        [~,top_n_mean_ind] = maxk(all_dist,topN);
        O_C(top_n_mean_ind)=1; %labeled as outliers

        [CM, acc, ~, ~]=func_confusion_matrix(O,O_C);
        result_C(count_inner,count) = acc;
        count_inner = count_inner+1;
    end
    count = count+1;   
end
% N goes up, and acc goes down
result_C(end+1,:) = k_list;
result_C(1:end-1,end+1) = n_list';
%%
mean_value = zeros(size(X,1),1);
for ind = 1:size(X,1)
    sub_x = (X - X(ind,:));
    dist_matrix = sqrt( sum( (sub_x').^2 ) )';
    mean_value(ind,1) = mean(dist_matrix);
end
final_mean = mean(mean_value);
% sub_x = (X - X(2,:));
% dist_matrix = sqrt( sum( (sub_x').^2 ) )';
% dist_matrix(2,:) = [];
% 
% mean_value = mean(dist_matrix);
% 
% sub_x_two = norm(X(2,:) - X(1,:));

%%

[cIdx,cD] = knnsearch(X,X,'K',10);
