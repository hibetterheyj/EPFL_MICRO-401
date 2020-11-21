function [XNew] = sample_from_gmmModels(models, nbSamplesPerClass, desiredClass)
%SAMPLE_FROM_GMMMODELS Generate new samples from a set of GMM
%   input------------------------------------------------------------------
%       o models : (structure array), Contains the following fields
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o nbSamplesPerClass    : (int) Number of samples per class to generate.
%       o desiredClass : [optional] (int) Desired class to generate samples for
%   output ----------------------------------------------------------------
%       o XNew  :  (N x nbSamples), Newly generated set of samples.
%       nbSamples depends if the optional argument is provided or not. If
%       not nbSamples = nbSamplesPerClass * nbClasses, if yes nbSamples = nbSamplesPerClass
%%

% init
N = size(models(1).Mu, 1);
% calculation
switch nargin
    case 2
        % compute with `desiredClass`
        N_class = numel(models);
        nbSamples = nbSamplesPerClass * N_class;
        XNew = zeros(N, nbSamples);
        for ii = 1:N_class
            XNew_c = sample_from_gmm(models(ii), nbSamplesPerClass);
            XNew(:,nbSamplesPerClass*(ii-1)+1:nbSamplesPerClass*ii) = XNew_c;
        end
    case 3
        % compute w/o `desiredClass`; class 4 is the 4-th class
        XNew = sample_from_gmm(models(desiredClass+1), nbSamplesPerClass);
end

end