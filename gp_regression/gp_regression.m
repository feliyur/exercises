function gp_regression()
    close all
    %%
    xrange = linspace(-200, 200, 1000); 
    xmin = min(xrange); xmax = max(xrange); 
       
    Sn = 1; 
    l = 0.2*(xmax-xmin)/2; 
    Ks = gaussian_kernel(xrange', xrange', l); 

    mean_f = zeros(size(xrange)); 
    cov_f = diag(Ks); 

    ylim([-50, 50]); xlim([xmin, xmax]); 
    hold on;     

    hcov = patch([xrange'; fliplr(xrange)'], 2*[sqrt(cov_f); -sqrt(cov_f)], 'y', 'facealpha', 0.5, 'edgecolor', 'none', 'DisplayName', 'std'); 
    hf = plot(xrange, mean_f, 'DisplayName', 'mean'); 
    legend show
    %%
    training = zeros(0, 2); 
    while true
        pt = ginput(1);
        if isempty(pt)
            break; 
        end        
        training(end+1,:) = pt; 
        h = plot(training(end,1),training(end,2),'ro'); 
        h.Annotation.LegendInformation.IconDisplayStyle = 'off'; 
    
        K = gaussian_kernel(training(:, 1), training(:, 1), l); 
        Kinv = inv(K+Sn*eye(size(training, 1))); 
        k = gaussian_kernel(xrange', training(:, 1), l);         
        mean_f = k*Kinv*training(:, 2); 
        cov_f = diag(Ks - k*Kinv*k'); 
        
        set(hf, 'ydata', mean_f); 
        set(hcov, 'ydata', [mean_f; flipud(mean_f)] + 2*[sqrt(cov_f); -sqrt(flipud(cov_f))]);         
    end

end

function K = gaussian_kernel(X, Y, l)
    d = pdist2(X, Y)/l; 
%     K = squareform(exp((d.^2)/2));
    K = exp(-(d.^2)/2)*500; 
end
