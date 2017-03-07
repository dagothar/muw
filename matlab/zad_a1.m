clc; clear all; close all;

%% Dane
    a = 90;
    w = 2;
    n = 24;

    AB = 15;
    AC = 3;
    BD = 3;
    CD = 10;
    DE = 3;
    EF = 5;
    
    r = (BD+DE)/BD;
    
    nD = 1;
    nF = 0;

%% Obliczenia
A = [ 0, 0, AC ];
B = [ AB, 0, BD ];

D1 = [0 0];
Dp = D1;
dD = [0 0];
F1 = [0 0];

M1 = [ 0 0 ];

i = 1;
dt = 0.01; %2*pi/(w*n);
t = (90-a) * pi/180;
while 1
    C(1) = AC * sin(w*t);
    C(2) = AC * cos(w*t);
    C(3) = CD;
    
    [Dt1, Dt2] = ccintersection(C, B);
    
    dD1 = Dt1 - Dp;
    dD2 = Dt2 - Dp;
    
    m = 1.0; n = 1.0;
    
%     if (ppdistance(D1, Dt1) < ppdistance(D1, Dt2))
    if m*norm(dD1-dD)+n*ppdistance(D1, Dt1) < m*norm(dD2-dD)+n*ppdistance(D1, Dt2)
        D1 = Dt1;
        D2 = Dt2;
    else
        D1 = Dt2;
        D2 = Dt1;
    end
    
    if nD
        dD = D2 - Dp;
        D = D2;
    else
        dD = D1 - Dp;
        D = D1;
    end
    
    Dp = D;
    
    E = pbetween(B, D, r);
    E(3) = EF;
    
    l = makeline(C, D);
    [Ft1, Ft2] = clintersection(E, l);
    
    if (ppdistance(F1, Ft1) < ppdistance(F1, Ft2))
        F1 = Ft1;
        F2 = Ft2;
    else
        F1 = Ft2;
        F2 = Ft1;
    end
%     F1 = Ft1;
%     F2 = Ft2;
    
    if nF
        F = F2;
    else
        F = F1;
    end
    
    Fs(i, :) = F;
    
    i = i + 1;
    
    t = t + dt;
    
    figure(1);
    plot([A(1) C(1)], [A(2) C(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); hold on; %AC
    plot([B(1) E(1)], [B(2) E(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %BE
    plot([C(1) D(1)], [C(2) D(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %CD
    plot([C(1) F(1)], [C(2) F(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %CF
    plot([E(1) F(1)], [E(2) F(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %EF
    plot(F(1), F(2), 'ro');
    plot(Fs(:, 1), Fs(:, 2), 'r', 'linewidth', 2, 'linesmoothing', 'on'); hold off;
    text(A(1), A(2), 'A', 'color', 'b');
    text(B(1), B(2), 'B', 'color', 'b');
    text(C(1), C(2), 'C', 'color', 'b');
    text(D(1), D(2), 'D', 'color', 'b');
    text(E(1), E(2), 'E', 'color', 'b');
    text(F(1), F(2), 'F', 'color', 'b');
    
    axis equal;
    s = xlim; h = ylim;
    axis([-10 20 -10 20]);
    
    pause(dt);
end

