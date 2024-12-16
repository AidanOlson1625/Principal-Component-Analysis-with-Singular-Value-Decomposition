function [A_mean, A_centered]=meancent(A)
% MEANCENT - mean-centering of arrays.
%      [A_mean, A_centered]=meancent(A)
% For an array of 2 or more dimensions, A, regarded as a 
% combination of several subsets concatenated along the highest
% dimension (2nd for column vectors, i.e., in the case of two-
% dimensional A), ruturns:
% A_mean, the mean subset (for a 2D-array, the averaged column);
% A_centered, the centered array.
%
% Example:
%    a=[1 1 1; 2 2 2];
%    a=cat(3, a, a*2);
%    [am, ac]=meancent(a)
% produces
%    am=[1.5 1.5 1.5
%        3   3   3]
%
%    ac(:,:,1)=[-0.5   -0.5   -0.5
%               -1     -1     -1]
%
%    ac(:,:,2)=[0.5  0.5  0.5
%               1    1    1]
n=size(A);
nn=size(n,2);
A_mean = permute((mean(permute(A, [nn:-1:1]))), [nn:-1:1]);
A_centered = A - reshape(reshape(A_mean, [prod(n(1:nn-1)) 1])*...
   ones(1, n(end)), n);