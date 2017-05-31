function x = dirrnd(alpha, n)
% function x = dirrnd(alpha, n)
%
% generates n dirichlet - distributed vectors. Distribution parametrized by
% alpha. 

x = gamrnd(repmat(alpha(:)', n, 1), 1);
x = x./repmat(sum(x, 2), 1, length(alpha)); 

