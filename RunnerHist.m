clear all; close all; clc

% Generate random data
n = 10^6;
xn = rand(1,n);

% Iterate function
for i = 1:10001
    if i ~= 1
        xn = xnp1;
    end
    xnp1 = 3.999*xn.*(1-xn);
end

% Plot histograms
K = 100;
figure(1)
histogram(xn, K, 'Normalization', 'count')
xlabel('$x$','interpreter','latex')
ylabel('count','interpreter','latex')
set(gca,'FontSize',18);

figure(2)
histogram2(xn, xnp1, [K,K], 'Normalization', 'count')
xlabel('$x$','interpreter','latex')
ylabel('$x''$','interpreter','latex')
zlabel('count','interpreter','latex')
set(gca,'FontSize',18);

% Calculate and plot joint probability distribution
P = zeros(K);
han1 = histogram(xn, K, 'Normalization', 'count');
han = histogram2(xn, xnp1, [K,K], 'Normalization', 'count');
for i = 1:K
    P(i,:) = han.BinCounts(i,:) ./ han1.BinCounts(i);
end

figure(3)
histogram2('XBinEdges',han.XBinEdges,'YBinEdges',han.YBinEdges,'BinCounts',P,'Normalization','count')
xlabel('$x$','interpreter','latex')
ylabel('$x''$','interpreter','latex')
zlabel('count','interpreter','latex')
set(gca,'FontSize',18);

% Plot eigenvector(Invariant density)
[V, D] = eigs(P');
figure(4)
plot(han1.BinEdges(1:end-1), real(V(:,1)), '*')
xlabel('$x$','interpreter','latex')
ylabel('$v(x)$','interpreter','latex')
set(gca,'FontSize',18);

% Plot P(FP estimator)
figure(7)
pcolor(han1.BinEdges(1:end-1),han1.BinEdges(1:end-1),P)
colormap(hot)
colorbar
set(gca,'FontSize',18);
xlabel('$x''$','interpreter','latex')
ylabel('$x$','interpreter','latex')
