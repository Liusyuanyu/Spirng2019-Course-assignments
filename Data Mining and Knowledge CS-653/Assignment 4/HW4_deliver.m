% clear Data
clear;clc;
%%
weather_good = [1; 0; 1; 1; 0; 1; 0; 1; 1; 0; 1; 0];
weather_bad  = [0; 1; 0; 0; 1; 0; 1; 0; 0; 1; 0; 1];
driver_sober    = [0; 1; 1; 1; 1; 0; 0; 1; 0; 1; 0; 1];
driver_alcohol  = [1; 0; 0; 0; 0; 1; 1; 0; 1; 0; 1; 0];

violation_none      = [0; 1; 0; 0; 0; 0; 1; 0; 1; 0; 0; 0];
violation_speed     = [1; 0; 0; 1; 0; 0; 0; 0; 0; 0; 1; 0];
violation_stop      = [0; 0; 1; 0; 0; 1; 0; 0; 0; 0; 0; 1];
violation_traffic   = [0; 0; 0; 0; 1; 0; 0; 1; 0; 1; 0; 0];

belt_no    = [1; 0; 0; 0; 1; 0; 0; 0; 1; 1; 0; 0];
belt_yes   = [0; 1; 1; 1; 0; 1; 1; 1; 0; 0; 1; 1];

severity_major   = [1; 0; 0; 1; 1; 0; 1; 1; 1; 1; 1; 0];
severity_minor   = [0; 1; 1; 0; 0; 1; 0; 0; 0; 0; 0; 1];

accidentData = table(weather_good, weather_bad, driver_sober, driver_alcohol, violation_none, violation_speed, violation_stop, violation_traffic, ...
    belt_no, belt_yes, severity_major, severity_minor);

% disp(accidentData.Keys)


% C1 = accidentData.Properties.VariableNames;
%% Get frequent set
accidentTable =accidentData;
allkeys = accidentData.Properties.VariableNames';

result = getFreqItemsets(accidentTable,allkeys,2);

%% My functions

function Itemsets = getFreqItemsets(accidentData,allkeys, minsup)
    Itemsets = {};
%     Itemsets_ind = {};
    maxitems = size(allkeys,1);
    column_ind = 1:maxitems;
    
%     com = combnk(column_ind,item_count);
    for k_num = 1:maxitems
        a_com = combnk(column_ind,k_num);
        for ind = 1:size(a_com,1) 
%             a_row = table2array( a_com(ind,:));
            TF = checkNumber(accidentData, a_com(ind,:), minsup);
            if TF
                if isempty(Itemsets)
                    items_str = ConvertToName(a_com(ind,:), allkeys);
                    Itemsets = {items_str};
                else 
                    items_str = ConvertToName(a_com(ind,:), allkeys);
                    Itemsets{end+1,:} = items_str;
                end
%                 if isempty(Itemsets)
%                     Itemsets = {a_com(ind,:)};
%                 else
%                     Itemsets{end+1,:} = a_com(ind,:);
%                 end
            end
        end
    end
end

function TF = checkNumber(accidentData,itemset, minsup)
    counter = 0;
    for t_row_ind = 1: size(accidentData,1)
        a_row = table2array( accidentData(t_row_ind,:));
        a_row_item_ind = find(a_row== 1);
        zero_count = size(find(ismember(itemset,a_row_item_ind) == 0),2);
        if zero_count == 0
            counter=counter+1;
        end
    end
    
    if minsup > counter
        TF = false;
    else
        TF = true;
    end
end

function representitems = ConvertToName(Itemsets, allkeys)
    representitems =[];
    for ind = 1: size(Itemsets,2)
        representitems = [representitems, allkeys(Itemsets(ind))];
    end
end