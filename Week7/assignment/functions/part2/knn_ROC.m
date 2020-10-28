function [ TP_rate, FP_rate ] = knn_ROC( X_train, y_train, X_test, y_test,  params )
%KNN_ROC Implementation of ROC curve for kNN algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_test   : (1 x M_test), a vector with labels y \in {1,2} corresponding to X_test.
%       o params : struct array containing the parameters of the KNN (k,
%                  d_type and k_range)
%
%   output ----------------------------------------------------------------

%       o TP_rate  : (1 x K), True Positive Rate computed for each value of k.
%       o FP_rate  : (1 x K), False Positive Rate computed for each value of k.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
k_list = params.k_range;
TP_rate = zeros(1, length(k_list));
FP_rate = zeros(1, length(k_list));

% calculate the TP_rate and FP_rate one by one
for ii = 1:length(k_list)
    params.k = k_list(ii);
    [y_est] =  knn(X_train,  y_train, X_test, params);
    [C] =  confusion_matrix(y_test, y_est);
    % C = [TP,FN;FP,TN];
    TP_rate(ii) = C(1,1)/sum(C(1,:));
    FP_rate(ii) = C(2,1)/sum(C(2,:));
end

end