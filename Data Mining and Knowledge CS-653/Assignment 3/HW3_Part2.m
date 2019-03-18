% Part II Classification
clear;

%%% 2.1 Nearest neighbor method 
% setosa  = iris( iris(:,5) ==1,:);
% versicolor  = iris( iris(:,5) ==2,:);
% virginica  = iris( iris(:,5) ==3,:); 
[CM_K7, acc_K7, arrR_K7, arrP_K7]=func_KNN(7);
[CM_K13, acc_K13, arrR_K13, arrP_K13]=func_KNN(13);
[CM_K21, acc_K21, arrR_K21, arrP_K21]=func_KNN(21);