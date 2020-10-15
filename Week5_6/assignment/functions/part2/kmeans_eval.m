function [RSS_curve, AIC_curve, BIC_curve] =  kmeans_eval(X, K_range,  repeats, init, type, MaxIter)
%KMEANS_EVAL Implementation of the k-means evaluation with clustering
%metrics.
%
%   input -----------------------------------------------------------------
%
%       o X           : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o repeats     : (1 X 1), # times to repeat k-means
%       o K_range     : (1 X K_range), Range of k-values to evaluate
%       o init        : (string), type of initialization {'sample','range'}
%       o type        : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter     : (int), maximum number of iterations
%
%   output ----------------------------------------------------------------
%       o RSS_curve  : (1 X K_range), RSS values for each value of K in K_range
%       o AIC_curve  : (1 X K_range), AIC values for each value of K in K_range
%       o BIC_curve  : (1 X K_range), BIC values for each value of K in K_range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we should run K-Means for repeats times, generally 10, and take the **mean**
% or best of those runs as the result

% initialization
RSS_curve = zeros(size(K_range));
AIC_curve = zeros(size(K_range));
BIC_curve = zeros(size(K_range));

% repetitive evaluations
for j = 1:size(K_range,2)
    for i = 1: repeats
        [labels, Mu, ~] =  kmeans(X, K_range(j), init, type, MaxIter, []);
        [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu);

        RSS_curve(j) = RSS_curve(j) + RSS;
        AIC_curve(j) = AIC_curve(j) + AIC;
        BIC_curve(j) = BIC_curve(j) + BIC;

        if i == repeats
            RSS_curve(j) = RSS_curve(j)/repeats;
            AIC_curve(j) = AIC_curve(j)/repeats;
            BIC_curve(j) = BIC_curve(j)/repeats;
        end
    end
end

end