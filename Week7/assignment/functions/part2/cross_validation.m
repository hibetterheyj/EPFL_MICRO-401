function [avgTP, avgFP, stdTP, stdFP] =  cross_validation(X, y, F_fold, valid_ratio, params)
%CROSS_VALIDATION Implementation of F-fold cross-validation for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (1 x M), a vector with labels y \in {1,2} corresponding to X.
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Training/Testing Ratio.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------
%
%       o avgTP  : (1 x K), True Positive Rate computed for each value of k averaged over the number of folds.
%       o avgFP  : (1 x K), False Positive Rate computed for each value of k averaged over the number of folds.
%       o stdTP  : (1 x K), Standard Deviation of True Positive Rate computed for each value of k.
%       o stdFP  : (1 x K), Standard Deviation of False Positive Rate computed for each value of k.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
k_list = params.k_range;
allTP = zeros(F_fold, length(k_list));
allFP = zeros(F_fold, length(k_list));

% methodology
for ii = 1:F_fold
    [X_train, y_train, X_test, y_test] = split_data(X, y, valid_ratio);
    [TP_rate, FP_rate] = knn_ROC(X_train, y_train, X_test, y_test, params );
    allTP(ii,:) = TP_rate;
    allFP(ii,:) = FP_rate;
end

% output
avgTP = mean(allTP);
avgFP = mean(allFP);
stdTP = std(allTP);
stdFP = std(allFP);

end