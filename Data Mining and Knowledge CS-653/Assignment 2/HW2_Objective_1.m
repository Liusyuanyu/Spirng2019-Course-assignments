% three categories: setosa, virginica and versicolor.
% 1. sepal length in cm  : VarName1
% 2. sepal width in cm   : VarName2
% 3. petal length in cm  : VarName3
% 4. petal width in cm   : VarName4
% 5. class: 
% -- Iris Setosa 
% -- Iris Versicolour 
% -- Iris Virginica


%% %% Objective-1: Data Exploration and Visualization 
%% 1.1
load iris;
setosa  = iris( ismember(iris.Irissetosa, 'Iris-setosa' ),: );
virginica  = iris( ismember(iris.Irissetosa, 'Iris-virginica' ),: );
versicolor  = iris( ismember(iris.Irissetosa, 'Iris-versicolor' ),: ); 

histogram(setosa.VarName4,10);
title('setosa');
xlabel('petal width');
ylabel('Count');

figure; 
histogram(virginica.VarName4,10);
title('virginica');
xlabel('petal width');
ylabel('Count');

figure; 
histogram(versicolor.VarName4,10);
title('versicolor');
xlabel('petal width');
ylabel('Count');

%% 1.2 2D hist
%------------------------------------------------------------------------------------------------

figure;
hist3([setosa.VarName3,setosa.VarName4]);
title('setosa');
xlabel("petal length");
ylabel('petal width');

figure;
hist3([versicolor.VarName3,versicolor.VarName4]);
title('versicolor');
xlabel("petal length");
ylabel('petal width');

figure;
hist3([virginica.VarName3,virginica.VarName4]);
title('virginica');
xlabel("petal length");
ylabel('petal width');

%% % 1.2 2D hist OLD
% %------------------------------------------------------------------------------------------------
% column_name = versicolor.Properties.VariableNames(1:4);
% combination_names = nchoosek(column_name,2);
% [row_n,~]=size(combination_names);
% % versicolor
% for row_index=1:row_n
%     Arow = combination_names(row_index,:); 
%     if Arow(1,1) == "VarName1"
%       x_label = "sepal length";
%     elseif Arow(1,1) == "VarName2"
%       x_label = "sepal width";
%     elseif Arow(1,1) == "VarName3"
%       x_label = "petal length";
%     else%VarName4
%       x_label = "petal width";
%     end
%     %Y label
%     if Arow(1,2) == "VarName1"
%       y_label = "sepal length";
%     elseif Arow(1,2) == "VarName2"
%       y_label = "sepal width";
%     elseif Arow(1,2) == "VarName3"
%       y_label = "petal length";
%     else%VarName4
%       y_label = "petal width";
%     end
%     
%     x_values = table2array(versicolor(:,Arow(1,1)));
%     y_values = table2array(versicolor(:,Arow(1,2)));
%     
%     figure;
%     hist3([x_values,y_values]);
%     title('versicolor');
%     xlabel(x_label);
%     ylabel(y_label);
% end
% 
% % setosa
% for row_index=1:row_n
%     Arow = combination_names(row_index,:); 
%     if Arow(1,1) == "VarName1"
%       x_label = "sepal length";
%     elseif Arow(1,1) == "VarName2"
%       x_label = "sepal width";
%     elseif Arow(1,1) == "VarName3"
%       x_label = "petal length";
%     else%VarName4
%       x_label = "petal width";
%     end
%     %Y label
%     if Arow(1,2) == "VarName1"
%       y_label = "sepal length";
%     elseif Arow(1,2) == "VarName2"
%       y_label = "sepal width";
%     elseif Arow(1,2) == "VarName3"
%       y_label = "petal length";
%     else%VarName4
%       y_label = "petal width";
%     end
%     
%     x_values = table2array(setosa(:,Arow(1,1)));
%     y_values = table2array(setosa(:,Arow(1,2)));
%     
%     figure;
%     hist3([x_values,y_values]);
%     title('setosa');
%     xlabel(x_label);
%     ylabel(y_label);
% end
% 
% % virginica
% for row_index=1:row_n
%     Arow = combination_names(row_index,:); 
%     if Arow(1,1) == "VarName1"
%       x_label = "sepal length";
%     elseif Arow(1,1) == "VarName2"
%       x_label = "sepal width";
%     elseif Arow(1,1) == "VarName3"
%       x_label = "petal length";
%     else%VarName4
%       x_label = "petal width";
%     end
%     %Y label
%     if Arow(1,2) == "VarName1"
%       y_label = "sepal length";
%     elseif Arow(1,2) == "VarName2"
%       y_label = "sepal width";
%     elseif Arow(1,2) == "VarName3"
%       y_label = "petal length";
%     else%VarName4
%       y_label = "petal width";
%     end
%     
%     x_values = table2array(setosa(:,Arow(1,1)));
%     y_values = table2array(setosa(:,Arow(1,2)));
%     
%     figure;
%     hist3([x_values,y_values]);
%     title('virginica');
%     xlabel(x_label);
%     ylabel(y_label);
% end
% 
%% 1.3 Box plot
showboxplot(setosa,'setosa');
showboxplot(versicolor,'versicolor');
showboxplot(virginica,'virginica');

%% 1.4 gplotmatrix
%----------------------------------------------------------------------
rand_row_indices = randperm(size(iris,1),size(iris,1)/2);
selected_row =iris(rand_row_indices,:);  % output matrix
iris_matrix = table2array(selected_row(:,5));
data_matrix = table2array(selected_row(:,1:4));

[fig,ax] = gplotmatrix(data_matrix,[],iris_matrix,'brg','x+o',[],'on','none');

ylabel(ax(1,1),'sepal length');
ylabel(ax(2,1),'sepal width');
ylabel(ax(3,1),'petal length');
ylabel(ax(4,1),'petal width');

xlabel(ax(4,1),'sepal length');
xlabel(ax(4,2),'sepal width');
xlabel(ax(4,3),'petal length');
xlabel(ax(4,4),'petal width');

leg = findobj('Tag','legend');
set(leg, 'Position',[0.18, 0.78, 0.1, 0.12]);
set(gcf, 'Position', [300,400,650,520]);


%% 1.5 Euclidean distance 
% ------------------------------------------------------------------------------------------------
all_sample = table2array(iris(:,1:4));
all_similarity = pdist(all_sample);
Z = squareform(all_similarity);
img = imagesc(Z);
xticks([50 100 150]);
xticklabels([50 100 150]);
yticks([50 100 150]);
yticklabels([50 100 150]);
colorbar
xlabel(['setosa', '                             versicolor                          ' , 'virginica']);
ylabel(['virginica', '                             versicolor                          ' , 'setosa']);
set(gcf, 'Position', [300,400,710,575]);

%% clear
clear;