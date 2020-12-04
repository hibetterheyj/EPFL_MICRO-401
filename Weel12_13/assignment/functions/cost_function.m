function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Y
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error

M = size(Y,2);
switch type
    case "LogLoss"
        E = (sum(sum(-log(Y(Yd==1)))) + sum(sum(-log(1-Y(Yd==0))))) / M;
end

end