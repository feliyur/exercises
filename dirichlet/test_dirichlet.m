%%
[x, y] = meshgrid(0:0.01:1, 0:0.01:1); 

% simplex
select_legal = y+x<=1; 
% s_x = x(y+x<=1); 
% s_y = y(y+x<=1); 
% s_z = 1-s_x-s_y; 
z = 1-x-y; 

alpha = [1 1 1]; 
%%
f = (x.^alpha(1)).*(y.^alpha(2)).*(z.^alpha(3)); 
f(~select_legal) = NaN; 
surf(x, y, f); 