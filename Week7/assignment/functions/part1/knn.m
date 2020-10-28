function [ y_est ] =  knn(X_train,  y_train, X_test, params)
%MY_KNN Implementation of the k-nearest neighbor algorithm
%   for classification.
%
%   input -----------------------------------------------------------------
%   
%       o X_train  : (N x M_train), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y_train  : (1 x M_train), a vector with labels y \in {1,2} corresponding to X_train.
%       o X_test   : (N x M_test), a data set with M_test samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o params : struct array containing the parameters of the KNN (k, d_type)
%
%   output ----------------------------------------------------------------
%
%       o y_est   : (1 x M_test), a vector with estimated labels y \in {1,2} 
%                   corresponding to X_test.
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
M_test = size(X_test, 2);
y_est = zeros(1, M_test);
X_train_cell = num2cell(X_train, 1);

% methodology
for ii = 1:M_test
    % Compute Pairwise Distances
    d = cell2mat(cellfun(@(X_train) compute_distance(X_test(:,ii), X_train, params), ...
        X_train_cell, 'UniformOutput', false));

    % Step2: Extract k-Nearest Neighbors
    [~,I] = sort(d);
    y_hat = y_train(I(1:params.k));

    % Step3: Majority Vote
    table = tabulate(y_hat);
    % if the number of two classes are equal => compare their index sum 
    if table(1,3) == 50
        if sum(find(y_hat==1)) < sum(find(y_hat==2))
            y_est(ii) = 1;
        else
            y_est(ii) = 2;
        end
    else
        y_est(ii) = table(table(:,3)>50,1);
    end
end

end