function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function

% init
[N, M] = size(Z);
% activation
switch Sigma
    case "sigmoid"
        A = ones(N, M) ./ (1 + exp(-Z));
    case "tanh"
        A = (exp(Z) - exp(-Z)) ./ (exp(Z) + exp(-Z));
    case "relu"
        A = max(0, Z);
    case "leakyrelu"
        k = 0.01;
        A = max(k*Z, Z);
    case "softmax"
        % different delta value for each of the M samples
        s = ones(1, ndims(Z)); s(1) = size(Z, 1);
        % delta = max(Z, [], 1);
        expz = exp(Z-repmat(max(Z), s));
        A = expz ./ repmat(sum(expz, 1), s);
end

end