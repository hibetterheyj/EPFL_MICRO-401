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
end

end