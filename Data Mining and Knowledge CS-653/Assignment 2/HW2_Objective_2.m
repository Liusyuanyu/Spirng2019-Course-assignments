clear;
load iris;

% three categories: setosa, virginica and versicolor.
% 1. sepal length in cm  : VarName1
% 2. sepal width in cm   : VarName2
% 3. petal length in cm  : VarName3
% 4. petal width in cm   : VarName4
% 5. class: 
% -- Iris Setosa 
% -- Iris Versicolour 
% -- Iris Virginica

%% 2.1 partition samples into two even subset
% -------------------------------------------------------------------------------------
setosa_all  = iris( ismember(iris.Irissetosa, 'Iris-setosa' ),: );
versicolor_all  = iris( ismember(iris.Irissetosa, 'Iris-versicolor' ),: ); 
virginica_all  = iris( ismember(iris.Irissetosa, 'Iris-virginica' ),: );
%Rename the columns of data
setosa_all.Properties.VariableNames = {'sepal_length','sepal_width','petal_length','petal_width','Category'};
versicolor_all.Properties.VariableNames = {'sepal_length','sepal_width','petal_length','petal_width','Category'};
virginica_all.Properties.VariableNames = {'sepal_length','sepal_width','petal_length','petal_width','Category'};



rand_row_indices = randperm(size(setosa_all,1),size(setosa_all,1)/2);
setosa_train =setosa_all(rand_row_indices,:);
setosa_test =setosa_all(setdiff(1:end,rand_row_indices),:);

rand_row_indices = randperm(size(versicolor_all,1),size(versicolor_all,1)/2);
versicolour_train =versicolor_all(rand_row_indices,:);
versicolour_test =versicolor_all(setdiff(1:end,rand_row_indices),:);

rand_row_indices = randperm(size(virginica_all,1),size(virginica_all,1)/2);
virginica_train =virginica_all(rand_row_indices,:);
Virginica_test =virginica_all(setdiff(1:end,rand_row_indices),:);



% % 2.2 partition samples into two even subset
% -------------------------------------------------------------------------------------
all_train_x = vertcat(setosa_train(:,1:4),versicolour_train(:,1:4), virginica_train(:,1:4) );
all_train_y = vertcat(setosa_train(:,5),versicolour_train(:,5), virginica_train(:,5) );

tc = fitctree(all_train_x,all_train_y);
% view(tc,'Mode','graph');

% predict_result = predict(tc, all_test_x);
% size(find(ismember(all_test_y,predict_result) ==1),1);
% accuracy = size(find(ismember(all_test_y,predict_result) ==1),1)/size(all_test_y,1)*100;

tc_CrossVal = fitctree(all_train_x,all_train_y, 'CrossVal','on');
% view(tc_CrossVal.Trained{1},'Mode','graph');
% view(tc_CrossVal.Trained{2},'Mode','graph');
% view(tc_CrossVal.Trained{3},'Mode','graph');
% view(tc_CrossVal.Trained{4},'Mode','graph');

tc_MaxNumSplits = fitctree(all_train_x,all_train_y, 'MaxNumSplits',1);
% view(tc_MaxNumSplits,'Mode','graph');

tc_MaxNumCategories = fitctree(all_train_x,all_train_y, 'MaxNumCategories',1,'MinLeafSize',1);
% view(tc_MaxNumCategories,'Mode','graph');

tc_MinLeafSize = fitctree(all_train_x,all_train_y,'MinLeafSize',2);
% view(tc_MinLeafSize,'Mode','graph');

% tc_NumVariablesToSample = fitctree(all_train_x,all_train_y,'NumVariablesToSample','all');
tc_NumVariablesToSample = fitctree(all_train_x,all_train_y,'NumVariablesToSample',1);
% view(tc_NumVariablesToSample,'Mode','graph');

tc_MinParentSize = fitctree(all_train_x,all_train_y,'MinParentSize',1);
% view(tc_MinParentSize,'Mode','graph');

tc_MergeLeaves = fitctree(all_train_x,all_train_y,'MergeLeaves','off');%default is on
% view(tc_MergeLeaves,'Mode','graph');

% MaxNumCategories
% MergeLeaves
% MinParentSize
% CrossVal
% MaxNumSplits
% MinLeafSize
% NumVariablesToSample

% % 2.3 
% Apply the learned tree to predict the labels of testing samples. You might use the Matlab function predict().  
% In the report, including both 
% (i)   success cases ,i.e. images for which your model can correctly predict their classes; 
% (ii)  failure cases, i.e. images for which your model fail to predict the correct labels. 
all_test_x = vertcat(setosa_test(:,1:4),versicolour_test(:,1:4), Virginica_test(:,1:4) );
all_test_y = table2array( vertcat(setosa_train(:,5),versicolour_train(:,5), virginica_train(:,5)) );

predict_result = predict(tc_MaxNumSplits, all_test_x);

% predict_result = predict(tc, all_test_x);
% predict_result = predict(tc_MergeLeaves, all_test_x);
% predict_result = predict(tc_CrossVal.Trained{2}, all_test_x);
% view(tc_CrossVal.Trained{2},'Mode','graph');
% view(tc_MaxNumCategories,'Mode','graph');
% view(tc_MinLeafSize,'Mode','graph');
% view(tc_MaxNumSplits,'Mode','graph');
% view(tc,'Mode','graph');

% tc_MergeLeaves = fitctree(all_train_x,all_train_y,'MergeLeaves','on');%default is on
% view(tc_MergeLeaves,'Mode','graph');

% view(tc_CrossVal.Trained{1},'Mode','graph');
%tc_NumVariablesToSample
%tc_MinLeafSize
%tc_MaxNumSplits
%tc_MaxNumCategories
%tc
%tc_CrossVal.Trained{1}
%tc_MinParentSize
% tc_MergeLeaves

all_test_y_rename = strrep(all_test_y, 'Iris-setosa', '1');
all_test_y_rename = strrep(all_test_y_rename, 'Iris-versicolor', '2');
all_test_y_rename = strrep(all_test_y_rename, 'Iris-virginica', '3');

predict_result_rename = strrep(predict_result, 'Iris-setosa', '1');
predict_result_rename = strrep(predict_result_rename, 'Iris-versicolor', '2');
predict_result_rename = strrep(predict_result_rename, 'Iris-virginica', '3');
all_test_y_rename=cell2mat(all_test_y_rename);
predict_result_rename=cell2mat(predict_result_rename);

find(all_test_y_rename~=predict_result_rename);
accuracy = size(find(all_test_y_rename==predict_result_rename),1)/size(all_test_y,1)*100;

% display(predict_result);
display(accuracy);

%% Save sample data

% save Samples97 all_train_x all_train_y all_test_x all_test_y;

% save Samples88 all_train_x all_train_y all_test_x all_test_y;

% save Samples986 all_train_x all_train_y all_test_x all_test_y;

% save Samples893 all_train_x all_train_y all_test_x all_test_y;

save Samples667 all_train_x all_train_y all_test_x all_test_y;

%% Show samples

display([all_train_x all_train_y]);
writetable([all_train_x all_train_y],'sample.xlsx')

%% % Example code fitctree
% load ionosphere
% tc = fitctree(X,Y);
% view(tc,'Mode','graph');%????
%% backup code
% C=vertcat(setosa_train,setosa_train);
% setdiff(setosa_all,C)
% test_matrix = [1,2,3; 4,5,6;6,7,8];
% ind = [1 2 3];
% % find(test_matrix>4);
% % n = numel(test_matrix);
% test_matrix(setdiff(1:end,ind))

indices = randperm(10, 5);
list_a = [1,2,3,4,5,6,7,8,9,10];
in = list_a(indices);
% setdiff(1:10,indices);
display(indices);
% display(setdiff(1:10,indices));
in_non = list_a(setdiff(1:end,indices));
% in_non = list_a(setdiff(1:10,indices));
display(in_non);
% display(indices);
% display(list_a);
% display(in);
% display(in_non);
% % versicolour_test =list_a(setdiff(1:end,indices),:);
