function [C] =  confusion_matrix(y_test, y_est)
%CONFUSION_MATRIX Implementation of confusion matrix 
%   for classification results.
%   input -----------------------------------------------------------------
%
%       o y_test    : (1 x M), a vector with true labels y \in {1,2} 
%                        corresponding to X_test.
%       o y_est     : (1 x M), a vector with estimated labels y \in {1,2} 
%                        corresponding to X_test.
%
%   output ----------------------------------------------------------------
%       o C          : (2 x 2), 2x2 matrix of |TP & FN|
%                                             |FP & TN|.
%        
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1:positive; 2:negative
TP = sum((y_test==1).*(y_est==1));
TN = sum((y_test==2).*(y_est==2));
FP = sum((y_test==2).*(y_est==1));
FN = sum((y_test==1).*(y_est==2));

% output
C = [TP,FN;
     FP,TN];

end

