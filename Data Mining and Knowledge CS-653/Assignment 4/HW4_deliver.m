% clear Data
clear;clc;
%% Generate an accident table.
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

%% Get frequent itemsets
allkeys = accidentData.Properties.VariableNames';
% minsup = 3: 7x3 ;;; 2: 1x5 ;
minsup = 2;
[freqitemsets,Itemsets] = getFreqItemsets(accidentData,allkeys,minsup);

%% Display all frequent itemsets.
for rowi = 1 : size(freqitemsets,1)
    str ="";
    str = str + allkeys( freqitemsets{rowi,1} );
    for coli= 2 : size(freqitemsets,2)
        str = str + ", "+allkeys( freqitemsets{rowi,coli} );
    end
    fprintf("%s\n",str);
end

%% Question 4: Generate rule
confidence = 0.8;
Rules = Apriori_Generate_rules(freqitemsets, Itemsets,confidence);

%% Display assocation rules
for ind = 1 : size(Rules,1)
    left = Rules{ind,1};
    right = Rules{ind,2};
    left_str = "( ";
    right_str = "( ";
    for cell_ind =1:size(left,2)
        if cell_ind ==1
            left_str = left_str + allkeys(left(cell_ind));
        else
            left_str = left_str + "," + allkeys(left(cell_ind));
        end
    end
    
    for cell_ind =1:size(right,2)
        if cell_ind ==1
            right_str = right_str + allkeys(right(cell_ind));
        else
            right_str = right_str + "," + allkeys(right(cell_ind));
        end
    end
    left_str = left_str + " )";
    right_str =right_str+ " )";
    
    fprintf("%s ==> %s\n",left_str,right_str);

end

%% My functions : frequent itemsets
function [freqitemsets,Itemsets] = getFreqItemsets(accidentData,allkeys, minsup)
    freqitemsets = {};
    Itemsets = {};
    maxitems = size(allkeys,1);
    column_ind = 1:maxitems;
    prune_itemsets = {-1};
    oneItemsets = {};
    com_result = nchoosek(column_ind,1);
    for ind = 1:size(com_result,1) 
        [TF,support] = checkNumber(accidentData, com_result(ind,:), minsup);
        if TF
            if isempty(Itemsets)
                oneItemsets = {com_result(ind,:)};
                Itemsets = {com_result(ind,:),support };
            else 
                oneItemsets{end+1,:} = com_result(ind,:);
                Itemsets = [Itemsets; {com_result(ind,:),support }];
            end
        else %The support is less than min support.
            prune_itemsets{end+1,:} = com_result(ind,:);
        end
    end
    if isempty(oneItemsets)
        return;
    end
    
    %%% get frequent itemsets K >=2
    k_num =2;
    K_itemsets = [];
    while true
        com_result = nchoosek(oneItemsets,k_num); 
        for ind = 1:size(com_result,1)
            [TF,support] = prunecandidate(accidentData,prune_itemsets,com_result(ind,:), minsup);
            if TF
                Itemsets = [Itemsets; {com_result(ind,:),support }];
                K_itemsets = [K_itemsets; com_result(ind,:)];
            else
                prune_itemsets{end+1,:} = com_result(ind,:);
            end
        end
        
        if ~isempty(K_itemsets)
            freqitemsets = K_itemsets;
            K_itemsets = [];
            k_num = k_num + 1;
        else
            break;
        end
    end
     
end

function [TF,support] = prunecandidate(accidentData,prune_itemsets,freqitem,minsup)
    num = size(prune_itemsets,1);
    freqitem = cell2mat(freqitem);
    for ind = 1:num
        if iscell(prune_itemsets{ind})
            a_itemset = cell2mat(prune_itemsets{ind});
        else
            a_itemset = prune_itemsets{ind};
        end
        zero_count = size(find(ismember(a_itemset,freqitem) ==0),2);
        if zero_count == 0
            TF = false;
            support = 0;
            return;
        end
    end
    [TF,support] = checkNumber(accidentData,freqitem, minsup);
end

function [TF,support] = checkNumber(accidentData,itemset, minsup)
    counter = 0;
    for t_row_ind = 1: size(accidentData,1)
        a_row = table2array( accidentData(t_row_ind,:));
        a_row_item_ind = find(a_row== 1);
        zero_count = size(find(ismember(itemset,a_row_item_ind) == 0),2);
        if zero_count == 0
            counter=counter+1;
        end
        
        support = counter;
        if minsup > counter
            TF = false;
        else
            TF = true;
        end
    end
end
%% My functions: Apriori algorithm for rule generation
function Rules = Apriori_Generate_rules(freqitemsets, Itemsets,confidence)
    Rules = [];
    for ind = 1:size(freqitemsets,1)      
        k_num  = size(freqitemsets(ind,:),2);
        if k_num >=2
            afreqitemset = freqitemsets(ind,:);
            
            for conseq_num = 1:k_num-1
                conseq = nchoosek(afreqitemset,conseq_num);
                Rules = Rulepruning(afreqitemset,conseq,Itemsets,confidence,Rules);
            end
        end
    end
end

function rules = Rulepruning(afreqitemset,conseqs,Itemsets,confidence,rules)
    if iscell(afreqitemset)
        afreqitemset = cell2mat(afreqitemset);
    end
    
    for ind = 1:size(conseqs,1)
        a_conseq = conseqs(ind,:);
        if iscell(a_conseq)
            a_conseq = cell2mat(a_conseq);
        end
        
        subitems = setdiff(afreqitemset, a_conseq);
        
        supfreq = 1;
        supsub = 1;
        subitemsfind = false;
        freqsetfind = false;
        
        for ii = 1:length(Itemsets)
            
            if isequal(Itemsets{ii,1}, subitems)
                supsub =Itemsets{ii,2};
                subitemsfind = true;
            end
            
            if isequal(Itemsets{ii,1}, afreqitemset)
                supfreq =Itemsets{ii,2};
                freqsetfind = true;
            end
            
            if subitemsfind && freqsetfind
                break;
            end
        end
        
        conf = supfreq / supsub;

        if conf >= confidence
            if isempty(rules)
                rules = {subitems,a_conseq };
            else
                rules = [rules; {subitems,a_conseq }];
            end             
        end
    end
end