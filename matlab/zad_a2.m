clc; clear all; close all;

%% Dane
    a = 0;
    w = 1;
    n = 24;

    AB = 10;
    AC = 1;
    BD = 7;
    CD = 15;
    DE = 4;
    EF = 5;
    
    r = (BD+DE)/BD;
    
    nD = 1;
    nF = 0;

%% Obliczenia
A = [ 0, 0, AC/AC ];
B = [ AB/AC, 0, BD/AC ];

F1 = [0 0];

M1 = [ 0 0 ];

i = 1; j = 1;
dt = 0.05; %2*pi/(w*n);
t0 = (90-a) * pi/180;
t = 0;
while 1
    C(1) = AC/AC * sin(w*t+t0);
    C(2) = AC/AC * cos(w*t+t0);
    C(3) = CD/AC;
    
    [D1, D2] = ccintersection(C, B);
    
    E1 = pbetween(B, D1, r);
    E1(3) = EF/AC;
    E2 = pbetween(B, D2, r);
    E2(3) = EF/AC;
    
    l1 = makeline(C, D1);
    [F11, F12] = clintersection(E1, l1);
    l2 = makeline(C, D2);
    [F21, F22] = clintersection(E2, l2);
    
%     if t < (2*pi+dt)/w
        Fs11(i, :) = F11;
        Fs12(i, :) = F12;
        Fs21(i, :) = F21;
        Fs22(i, :) = F22;
        i = i + 1;
%     end
    
%     if (t >= 2*pi/w) && (t < 4*pi/w)
%         print(gcf, ['pics/pic' num2str(j) '.png'], '-dpng');
%         j = j + 1;
%     end
    
    t = t + dt;
    
    figure(1);
    plot([A(1) C(1)], [A(2) C(2)], 'color', 'k', 'linewidth', 3); hold on; %AC
    plot([B(1) E1(1)], [B(2) E1(2)], 'color', 'r', 'linewidth', 3); %BE1
    plot([B(1) E2(1)], [B(2) E2(2)], 'color', 'g', 'linewidth', 3); %BE2
    plot([C(1) D1(1)], [C(2) D1(2)], 'color', 'r', 'linewidth', 3); %CD1
    plot([C(1) D2(1)], [C(2) D2(2)], 'color', 'g', 'linewidth', 3); %CD2
    plot([C(1) F11(1)], [C(2) F11(2)], 'color', 'r', 'linewidth', 3); %CF11
    plot([C(1) F12(1)], [C(2) F12(2)], 'color', 'r', 'linewidth', 3); %CF12
    plot([C(1) F21(1)], [C(2) F21(2)], 'color', 'g', 'linewidth', 3); %CF21
    plot([C(1) F22(1)], [C(2) F22(2)], 'color', 'g', 'linewidth', 3); %CF22
    plot([E1(1) F11(1)], [E1(2) F11(2)], 'r--', 'linewidth', 3); %E1F11
    plot([E1(1) F12(1)], [E1(2) F12(2)], 'r:', 'linewidth', 3); %E1F12
    plot([E2(1) F21(1)], [E2(2) F21(2)], 'g--', 'linewidth', 3); %E2F21
    plot([E2(1) F22(1)], [E2(2) F22(2)], 'g:', 'linewidth', 3); %E2F22
    plot(F11(1), F11(2), 'bo'); plot(F12(1), F12(2), 'bo');
    plot(F21(1), F21(2), 'bo'); plot(F22(1), F22(2), 'bo');
    plot(Fs11(:, 1), Fs11(:, 2), 'b-', 'linewidth', 2);
    plot(Fs12(:, 1), Fs12(:, 2), 'b--', 'linewidth', 2);
    plot(Fs21(:, 1), Fs21(:, 2), 'b-.', 'linewidth', 2);
    plot(Fs22(:, 1), Fs22(:, 2), 'b:', 'linewidth', 2);
    hold off;
    text(A(1), A(2), 'A', 'color', 'k');
    text(B(1), B(2), 'B', 'color', 'k');
    text(C(1), C(2), 'C', 'color', 'k');
    text(D1(1), D1(2), 'D1', 'color', 'k');
    text(D2(1), D2(2), 'D2', 'color', 'k');
    text(E1(1), E1(2), 'E1', 'color', 'k');
    text(E2(1), E2(2), 'E2', 'color', 'k');
    text(F11(1), F11(2), 'F11', 'color', 'k');
    text(F12(1), F12(2), 'F12', 'color', 'k');
    text(F21(1), F21(2), 'F21', 'color', 'k');
    text(F22(1), F22(2), 'F22', 'color', 'k');
    
    axis equal;
    s = xlim; h = ylim;
    axis([-2 25 -15 15]);
    axis square;
    
    pause(dt);
end

