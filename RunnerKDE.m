% Clear workspace and command window
clear; 
close all; 
clc;

% Set number of iterations and initialize random variable
n = 10^6;
xn = rand(1, n);

% Iterate map 10000 times
for i = 1:10000
    % Use previous xn if not first iteration
    if i ~= 1
        xn = xnp1;
    end
    % Update xn
    xnp1 = 3.999*xn.*(1-xn);
end

% Compute and plot KDE of xn
Kbin = 100;
xi = linspace(0.01, 0.99, Kbin);
bw1 = 10^(-3);
[f0, xi, ~] = ksdensity(xn, xi, 'Bandwidth', bw1);
tDeh = 1./(pi*sqrt(xi.*(1-xi)));
MSEcalKDE = (f0 - tDeh).^2;
semilogy(xi, MSEcalKDE, 'LineWidth', 1); 
xlabel('$x$','interpreter','latex');
ylabel('$MSE$','interpreter','latex');
set(gca, 'FontSize', 18);

% Compute and plot KDE of xn and xnp1
[DataXn, DataXnp1] = meshgrid(linspace(0, 1, Kbin), linspace(0, 1, Kbin));
xi1 = [DataXn(:) DataXnp1(:)];
[f1, ~] = ksdensity([xn' xnp1'], xi1, 'PlotFcn', 'contour', 'Bandwidth', bw1);
densityF = reshape(f1, Kbin, Kbin);
surf(DataXn, DataXnp1, densityF);
colorbar;
caxis([0, 1]);
xlabel('$x_n$','interpreter','latex');
ylabel('$x_{n+1}$','interpreter','latex');
zlabel('$\rho(x_n,x_{n+1})$','interpreter','latex');
shading interp;
set(gca, 'FontSize', 18);

% Compute and plot conditional probability P
P = zeros(Kbin);
for i = 1:Kbin
    P(i, :) = densityF(:, i)./f0(i);
end
surf(DataXnp1, DataXn, P);
shading interp;
colorbar;
caxis([0, 1]);
xlabel('$x_n$','interpreter','latex');
ylabel('$x_{n+1}$','interpreter','latex');
zlabel('$\rho(x_{n+1}|x_n)$','interpreter','latex');
set(gca, 'FontSize', 18);

% Compute and plot dominant eigenvector of P
[D, V] = eigs(P');
plot(linspace(0,1,Kbin), abs(real(D(:, 1))), '*');
set(gca, 'FontSize', 18);
xlabel('$x$','interpreter','latex');
ylabel('$v(x)$','interpreter','latex');

% Plot P as a color map
figure;
pcolor(linspace(0, 1, Kbin), linspace(0, 1, Kbin), P);
colormap(hot);
colorbar;
set(gca, 'FontSize', 18);
xlabel('$x$','interpreter','latex');
ylabel('$v(x)$','interpreter','latex');