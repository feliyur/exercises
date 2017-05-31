% mean_velocity = [0.2574, 0.1225, 0.1787]; % mean velocity
% std_velocity = [0.3314, 0.2278, 0.2836];  % standard deviation of velocity
% 
% figure
% hold on
% bar(1:3,mean_velocity)
% errorbar(1:3,mean_velocity,std_velocity,'.')


%% Plot+subplots
close all; 
subplot(3, 4, [1:3 5:7 9:11]); 
hold on; 

mean_entropy  = zeros(1, 3); 
n = 2000; 

theta = [2, 10, 50]; 

alpha = [theta(1), 1, 1]; 
X1 = dirrnd(alpha, n); 
hp1 = plot(X1(:, 2), X1(:, 1), '.'); 

mean_X1 = mean(X1); 
mean_entropy(1) = -sum(mean_X1.*log(mean_X1), 2); 


alpha = [1, theta(2), 1]; 
X2 = dirrnd(alpha, n); 
hp2 = plot(X2(:, 2), X2(:, 1), '.');
mean_X2 = mean(X2); 
mean_entropy(2) = -sum(mean_X2.*log(mean_X2), 2); 


alpha = [1, 1, theta(3)]; 
X3 = dirrnd(alpha, n); 
hp3 = plot(X3(:, 2), X3(:, 1), '.');
mean_X3 = mean(X3); 
mean_entropy(3) = -sum(mean_X3.*log(mean_X3), 2); 

line([0, 1], [1 0], 'color', [0.7 0.7 0.7]); 

hl = legend('class 1', 'class 2', 'class 3'); 
title(['Dirichlet with  \theta = (' num2str(theta) ')']); 
% print('-djpeg', 'dirichlet_dist')
% axis equal tight

subplot(3, 4, 4); 
% figure; 
% subplot(3, 1, 1); 
bar(mean(X1)); hold on; 
errorbar(mean(X1), std(X1), '.')
title('class 1')

subplot(3, 4, 8); 
% subplot(3, 1, 2); 
bar(mean(X2)); hold on; 
errorbar(mean(X2), std(X1), '.')
title('class 2')

subplot(3, 4, 12); 
% subplot(3, 1, 3); 
bar(mean(X3)); hold on; 
errorbar(mean(X3), std(X3), '.')
title('class 3')
print('-djpeg', 'dirichlet_dist')

%%
% delete(hl); 
% set(hp1, 'color', 'k'); 
% set(hp2, 'color', 'k'); 
% set(hp3, 'color', 'k'); 
% print('-djpeg', 'dirichlet_nocolor')

%% x^\alpha
x = linspace(0, 1, 1000); 

xlim([0, 1]); hold on; 

alpha=0.25; 
for ii=1:4
    p = alpha*2^ii; 
    plot(x, x.^p, 'DisplayName', ['\alpha=' num2str(p)]);     
end

title('x^\alpha'); 
legend('show'); 

%%
alpha = [0.5 3 1]; 

% \chi^2_{(n)} \sim Gamma(n/2, 1/2)

y = gamrnd(alpha, 1); 
y = y/sum(y); 