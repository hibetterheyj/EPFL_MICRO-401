function [dZ] = cost_derivative(Y, Yd, typeCost, typeLayer)
%COST_DERIVATIVE compute the derivative of the cost function w.r.t to the Z
%value of the last layer
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Yd
%       o Yd (PxM) Ground truth
%       o typeCost (string) type of the cost evaluation function
%       o typeLayer (string) type of the last layer
%   outputs:
%       o dZ (PxM) The derivative dE/dZL

% init
[P,M] = size(Y);
dZ = zeros(P,M);
% calculation
switch typeLayer
    case "sigmoid"
        dAL_dZL = Y .* (1-Y);
    case "softmax"
        dAL_dZL = cell(P,1);
        for ii = 1:P
            % -Yi*Yj
            dAL_dZL{ii} = - Y(ii,:).*Y; 
            % -Yi*Yi + Yi = (1-Yi)Yi
            dAL_dZL{ii}(ii,:) = dAL_dZL{ii}(ii,:) + Y(ii,:); 
        end
end
switch typeCost
    case "LogLoss"
        dE_dAL = - Yd./Y + (1-Yd)./(1-Y);
        % dE/dZL
        dZ = dE_dAL .* dAL_dZL;
    case "CrossEntropy"
        dE_dAL = - Yd./Y;
        % dE/dZL
        for ii = 1:P
            dZ = dZ + dE_dAL(ii,:).*dAL_dZL{ii};
        end
end

end