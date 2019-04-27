%% HA6, PART-II, Use PageRank Algorithm to Rank Websites

% This example shows how to use a PageRank algorithm to rank a collection
% of websites. Although the PageRank algorithm was originally designed to
% rank search engine results, it also can be more broadly applied to the
% nodes in many different types of graphs. The PageRank score gives an
% idea of the relative importance of each graph node based on how it is
% connected to the other nodes.
%
 
% PLEASE REPLACE the PLACEHOLDER LINES with your own codes. There are two
% placeholders. 
 

%%  Step 1 load the adjacent matrix; 
load('webpages.mat', 'A','U') ;
spy(A)
%  normalize this matrix
%% PLACEHOLDER-Start
matrix_A = zeros(100,100);
sum_col = sum(A')';
row_ind_list = find(sum_col ~=0)';

for ind = row_ind_list
    column_ind = find(A(ind,:) ~=0);
    matrix_A(ind,column_ind) = 1/sum_col(ind,1);  
end
normal_A = sparse(matrix_A);

A=normal_A; 
%PLACEHOLDER-End

% visualize the graph 
% Create a directed graph with the sparse adjacency matrix, |A|, using the
% URLs contained in |U| as node names.

G = digraph(A,U);
% Plot the graph using the force layout.
figure();
plot(G,'NodeLabel',{},'NodeColor',[0.93 0.78 0],'Layout','force');
title('Entire network of Websites'); 

%% step 2: Compute the PageRank scores for the graph, |G|, using 200 iterations and
% a damping factor of |0.85|. 
pr=ones(length(U),1); % initial ranks 

%% PLACEHOLDER-Start
% update ranks according to adjacent matrix; 
d =0.85;
constant_v = ones(length(U),1)*(1-d)';
for iter=1:200
    pr = constant_v + (A')*pr.*d;
end
%PLACEHOLDER-End

pr_cmp = centrality(G,'pagerank','MaxIterations',200,'FollowProbability',0.85);
% you might compare your results with this line: pr = centrality(G,'pagerank','MaxIterations',200,'FollowProbability',0.85);
 
%% step 3: visualize the webaites with higher rank. 

% Extract and plot a subgraph containing all nodes whose score is greater
% than half of the maximal rank value. Color the graph nodes based on their PageRank score.
H = subgraph(G,find(pr > 0.5*max(pr(:))));
figure, plot(H,'NodeLabel',{},'Layout','force');
title('high-ranked Websites')
colorbar