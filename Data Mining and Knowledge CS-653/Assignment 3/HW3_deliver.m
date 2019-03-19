% Data mining HW3
% Hsuan Yu Liu 823327369

% Part 1: Confusion Matrix and ROC curve.

clear;
True_class = { 'Y'; 'Y'; 'Y'; 'Y'; 'Y' ; 'Y'; 'N' ; 'N'; 'N'; 'N'; 'N'; 'N'};
confidence = [0.95; 0.803; 0.78; 0.53; 0.9; 0.2; 0.6; 0.8; 0.7; 0.5; 0.9;0.2];
instance_table = table(True_class, confidence, 'VariableNames', {'True_class' ;'Confidence'});

% 1.1 Given threshold T,.."Y"
Threshold = 0.6;
ground_truth_y = instance_table.True_class;

predict_y ={};
for ind = 1:1:size(instance_table.Confidence,1)
    if(instance_table.Confidence(ind) >= Threshold)
        predict_y = [predict_y ,{'Y'}];
    else
        predict_y = [predict_y,{'N'}];
    end
end
predict_y = predict_y';

%%% Calculate Confusion matrix
True_Positive = 0;
False_Positive = 0;
True_Negative = 0;
False_Negative = 0;

for ind = 1:size(ground_truth_y,1)
    if strcmp(predict_y(ind),"Y")==1
        % Positive
        if strcmp(ground_truth_y(ind),"Y")==1
            % True
            True_Positive = True_Positive+1;
        else
            %False
            False_Positive = False_Positive+1;
        end
    else
        % Negative
        if strcmp(ground_truth_y(ind),"N")==1
            % True
            True_Negative = True_Negative+1;
        else
            %False
            False_Negative = False_Negative+1;
        end
    end
end

confusion_matrix = [True_Positive, False_Negative; ...
     False_Positive, True_Negative];

%%%% 1.2 To calculate the ROC curve, you will need to do the following. 

f=figure();
ax=axes('Parent',f);
line = animatedline('Marker','o','Parent',ax);
title('ROC Curve');
xlabel('False Positive Rate');
ylabel('True Positive Rate');

for Threshold=0:0.05:1
    predict_y =[];
    for ind = 1:1:size(instance_table.Confidence,1)
        if(instance_table.Confidence(ind) >= Threshold)
            predict_y = [predict_y ,{'Y'}];
        else
            predict_y = [predict_y,{'N'}];
        end
    end
    predict_y = predict_y';

    True_Positive = 0;
    False_Positive = 0;
    True_Negative = 0;
    False_Negative = 0;
    
    for ind = 1:size(ground_truth_y,1)
        if strcmp(predict_y(ind),"Y")==1
            % Positive
            if strcmp(ground_truth_y(ind),"Y")==1
                % True
                True_Positive = True_Positive+1;
            else
                %False
                False_Positive = False_Positive+1;
            end
        else
            % Negative
            if strcmp(ground_truth_y(ind),"N")==1
                % True
                True_Negative = True_Negative+1;
            else
                %False
                False_Negative = False_Negative+1;
            end
        end
    end
    
    x_FPR = (False_Positive)/(False_Positive+True_Negative);
    y_TPR = (True_Positive)/(True_Positive+False_Negative);
    
    addpoints(line,x_FPR,y_TPR);
end

%% Part 2 Classification 
clear;
[CM_K7, acc_K7, arrR_K7, arrP_K7]=func_KNN(7);
[CM_K13, acc_K13, arrR_K13, arrP_K13]=func_KNN(13);
[CM_K21, acc_K21, arrR_K21, arrP_K21]=func_KNN(21);

