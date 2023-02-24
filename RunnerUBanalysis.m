% Initialize variables
clear Error UBK UBH;
Kvec = 800:1:1100;
xval = linspace(0.01, 0.99, 100);
C1 = max((2*xval - 1) ./ (2*pi*sqrt(xval.*(1 - xval)).^3));
fkmax = max(1 ./ (pi*sqrt(xval.*(1 - xval))));
sdfmax = abs(max((2*(xval - xval.^2).^(-3/2) + (3/2)*(2*xval - 1).^2.*(xval - xval.^2).^(-5/2)) ./ (2*pi)));

% Calculate upper bounds for different K values
for j = 1:length(Kvec)
    K = Kvec(j);
    h = 1/K;
    UBH(j) = C1^2 * h^2 + (1/h*fkmax + fkmax^2) / n;
    UBK(j) = (h^4 * sdfmax^2) / 4 + fkmax / (2*sqrt(pi)*h*n);
    j
end

% Plot results
figure;
plot(1./Kvec, UBK, 'o--');
xlabel('$\delta$','interpreter','latex')
ylabel('$UB$','interpreter','latex')
set(gca, 'FontSize', 18);

figure;
plot(Kvec, UBH, '.', Kvec, UBK, '.');
xlabel('$K$','interpreter','latex')
ylabel('$UB$','interpreter','latex')
set(gca, 'FontSize', 18);
legend('Hist', 'KDE', 'Location', 'Best');
