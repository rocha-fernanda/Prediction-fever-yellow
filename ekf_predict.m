clc;  close all; clear;

load('dados.mat')
populacao_humana = Dados;
populacao_humana(:,2) = 10^6 * populacao_humana(:,2);
populacao_humana(:,3) = 10^6 * populacao_humana(:,3);


% Parâmetros do modelo epidemiológico
betah = 0.0009;      % Taxa de suscetíveis que se tornam infectados
muh = 0.006;         % Taxa de mortalidade
alphah = 0.33;       % Taxa de mortes de infectados
deltah = 0.67;       % Taxa de infectados que se tornam recuperados
mui = 0.35;          % Taxa de morte natural dos mosquitos
mun = 0.04;          % Taxa de morte induzida dos mosquitos
betai = 0.00000015;  % Taxa de infecção quando mosquito não portador pica um infectado
lambdai = 0.37;      % Taxa de natalidade dos mosquitos
lambdah = 0.006;     % Taxa de natalidade dos humanos
H = 0.0000000001;

x(:,1) = [118562500 25*10e6 3*10e6  44000000 22000000];

f_mosquito = @(x)[-betah*H*x(5)*x(1) - muh*H*x(1) + lambdah*H*sum(x(1:3)) + x(1);
                   x(2) - muh*H*x(2) - alphah*H*x(2) + betah*H*x(1)*x(5) - deltah*H*x(2);
                   deltah*H*x(2) + x(3) - muh*H*x(3);
                   x(4) - betai*H*x(2)*x(4) + lambdai*H*x(4) - mui*H*x(4) - mun*H*x(4);
                   x(5) + betai*H*x(2)*x(4) + lambdai*H*x(5) - mui*H*x(5) - mun*H*x(5)];

J_mosquito = @(x)[(-betah*x(5) + lambdah - muh)*H + 1, lambdah*H, lambdah*H, 0, -betah*H*x(1);
                  betah*H*x(5), 1 - (deltah + muh + alphah)*H, 0, 0, betah*H*x(1);
                  0, deltah*H, 1 - muh*H, 0, 0;
                  0, -betai*H*x(4), 0, 1 - (betai*x(2) - lambdai + mui + mun)*H, 0;
                  0, betai*H*x(4), 0, betai*H*x(2), 1 + (lambdai - mui - mun)*H];



H_1 = [1 0 0 0 0;
        0 1 0 0 0;
        0 0 1 0 0];


C = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0];

P(:,:,1) = 1e3*eye(5);


 Q = [15 0 0 0 0;
      0 33 0 0 0;
      0 0 45 0 0;
      0 0 0 35 0;
      0 0 0 0 20];

 R = [.9 0 0;
      0 .4 0 ;
      0 0 .6];

 I = eye(5);

steps = 38;
for k = 2:steps
    % Predição
    x(:,k) = f_mosquito(x(:,k-1));
    P(:,:,k) = J_mosquito(x(:,k-1)) * P(:,:,k-1) * J_mosquito(x(:,k-1))' + Q;
    x_prediction(:,k) = x(:,k);

    % Atualização
    K = P(:,:,k) * H_1' / (H_1 * P(:,:,k) * H_1' + R);
    x(:,k) = x(:,k) + K * (populacao_humana(k,:)' - C * x(:,k));
    P(:,:,k) = (I - K * H_1) * P(k);
end

% Plotar gráficos
figure(1)
plot(x(1,:))
hold on
plot(populacao_humana(:,1),'*')
title({'População de suscetíveis'},'FontSize',27,'FontName','Times New Roman')
legend({'População de suscetíveis (estimativas)','População de suscetíveis (valor real)'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

figure(2)
plot(x(2,:)/10e5)
hold on
plot(populacao_humana(:,2)/10e5,'*')
title({'População de infectados'},'FontSize',27,'FontName', 'Times New Roman')
legend({'População de infectados (estimativas)','População de infectados (valor real)'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

figure(3)
plot(x(3,:)/10e5)
hold on
plot(populacao_humana(:,3)/10e5,'*')
title({'População de recuperados'},'FontSize',27,'FontName', 'Times New Roman')
legend({'População de recuperados (estimativas)','População de recuperados (valor real)'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

figure(4)
plot(x(4,:),'bo-')
title({'Estimativas das populações de mosquitos'},'FontSize',27,'FontName', 'Times New Roman')
legend({'Mosquitos não portadores'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

figure(5)
plot(x(5,:),'bo-')
title({'Estimativas das populações de mosquitos'},'FontSize',27,'FontName', 'Times New Roman')
legend({'Mosquitos portadores'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

figure(6)
subplot(2,1,1)
plot(x(2,:)/10e5)
hold on
plot(populacao_humana(:,2)/10e5,'*')
title({'População de infectados'},'FontSize',27,'FontName', 'Times New Roman')
legend({'População de infectados (estimativas)','População de infectados (valor real)'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')

subplot(2,1,2)
plot(x(5,:),'bo-')
title({'Estimativas das populações de mosquitos'},'FontSize',27,'FontName', 'Times New Roman')
legend({'Mosquitos portadores'},'FontSize',27,'FontName', 'Times New Roman')
ylabel({'População'},'FontSize',27,'FontName', 'Times New Roman')
xlabel({'Período (anual)'},'FontSize',27,'FontName', 'Times New Roman')
xticklabels({'1979','1984','1989','1994','1999','2004','2009','2014','2018'})
set(gca,'FontSize',27,'FontName', 'Times New Roman')


