function [F1_overall, P, R, F1] =  f1measure(cluster_labels, class_labels)
%MY_F1MEASURE Computes the f1-measure for semi-supervised clustering
%
%   input -----------------------------------------------------------------
%   
%       o class_labels     : (1 x M),  M-dimensional vector with true class
%                                       labels for each data point
%       o cluster_labels   : (1 x M),  M-dimensional vector with predicted 
%                                       cluster labels for each data point
%   output ----------------------------------------------------------------
%
%       o F1_overall      : (1 x 1)     f1-measure for the clustered labels
%       o P               : (nClusters x nClasses)  Precision values
%       o R               : (nClusters x nClasses)  Recall values
%       o F1              : (nClusters x nClasses)  F1 values
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
nClasses = numel(unique(class_labels));
nClusters = numel(unique(cluster_labels));
P = zeros(nClusters, nClasses);
R = zeros(nClusters, nClasses);
F1 = zeros(nClusters, nClasses);
classes = unique(class_labels);
clusters = unique(cluster_labels);
F1_overall = 0;

% constant
classDis = hist(class_labels,classes);
clusterDis = hist(cluster_labels,clusters);

% variable
for ii = 1:nClusters
    for jj = 1:nClasses
        class_cluster = sum((cluster_labels==clusters(ii)) .* (class_labels==classes(jj)));
        R(ii,jj) = class_cluster / classDis(jj);
        P(ii,jj) = class_cluster / clusterDis(ii);
        if R(ii,jj) + P(ii,jj)
            F1(ii,jj) = 2 * R(ii,jj) * P(ii,jj) / (R(ii,jj) + P(ii,jj));
        else
            F1(ii,jj) = 0;
        end
    end
end

for kk=1:nClasses   
    F1_overall = F1_overall+(sum(class_labels==kk)/numel(class_labels))*max(F1(:,kk));    
end


end
