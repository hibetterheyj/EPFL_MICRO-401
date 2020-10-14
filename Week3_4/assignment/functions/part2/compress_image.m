function [cimg, ApList, muList] = compress_image(img, p)
%COMPRESS_IMAGE Compress the image by applying the PCA over each channels 
% independently
%
%   input -----------------------------------------------------------------
%   
%       o img : (width x height x 3), an image of size width x height over RGB channels
%       o p : The number of components to keep during projection 
%
%   output ----------------------------------------------------------------
%
%       o cimg : (p x height x 3) The projection of the image on the eigenvectors
%       o ApList : (p x width x 3) The projection matrices for each channels
%       o muList : (width x 3) The mean vector for each channels

%% Convert to cell
% img_cell = squeeze(num2cell(img,[1 2]));
img_cell = num2cell(img,[1 2]);
%% PCA
[Mu, ~, EigenVectors, ~] = cellfun(@compute_pca, img_cell, 'UniformOutput', false);
%% Projection to Lower Dimensional Space
[Y, Ap] = cellfun(@(img, Mu, V) project_pca(img, Mu, V, p), img_cell, Mu, EigenVectors, 'UniformOutput', false);
%% Result
cimg = cell2mat(Y);
ApList = cell2mat(Ap);
muList = squeeze(cell2mat(Mu));

end

