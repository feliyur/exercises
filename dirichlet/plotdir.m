function [f, hSurf] = plotdir(hAxes, alpha, n)


if nargin<3
    n = 100; 
end

%%
coords = unique([linspace(0, 1, n), 1]); 
[x, y] = meshgrid(coords, coords); 

% simplex
select_legal = y+x<1; 
z = 1-x-y; 

f = (x.^alpha(1)).*(y.^alpha(2)).*(z.^alpha(3)); 
f = real(f);
f = f./max(f(:)); 
f(~select_legal) = NaN; 

if ~isempty(hAxes)
    hSurf = surf(hAxes, x, y, f); 
else
    hSurf = []; 
end

