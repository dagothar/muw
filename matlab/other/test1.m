clc; clear all; close all;

%% Dane
    AB = 15;
    AC = 5;
    BD = 7;
    r = 1.5;
    CD = sqrt(227);
    EF = 7;
    
    nD = 1;
    nF = 1;

%% Obliczenia
A = [ 0, 0, AC ];
B = [ AB, 0, BD ];

D1 = [0 0];
F1 = [0 0];

M1 = [ 0 0 ];

i = 1;
dt = 2*pi/100;
t0 = 0 * pi/180;
for t = t0 : dt : t0+2*pi
    C(1) = AC * sin(t);
    C(2) = AC * cos(t);
    C(3) = CD;
    
    [Dt1, Dt2] = ccintersection(C, B);
    
    if (ppdistance(D1, Dt1) < ppdistance(D1, Dt2))
        D1 = Dt1;
        D2 = Dt2;
    else
        D1 = Dt2;
        D2 = Dt1;
    end
    
    if nD
        D = D2;
    else
        D = D1;
    end
    
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
    
    if nF
        F = F2;
    else
        F = F1;
    end
    
    Fs(i, :) = F;
    
    i = i + 1;
end

%% Wykres
figure(1); hold on;
line([A(1) C(1)], [A(2) C(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %AC
line([B(1) E(1)], [B(2) E(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %BE
line([C(1) D(1)], [C(2) D(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %CD
line([C(1) F(1)], [C(2) F(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %CF
line([E(1) F(1)], [E(2) F(2)], 'color', 'k', 'linewidth', 3, 'linesmoothing', 'on'); %EF
plot(F(1), F(2), 'ro');
plot(Fs(:, 1), Fs(:, 2), 'r', 'linewidth', 2, 'linesmoothing', 'on');
text(A(1), A(2), 'A', 'color', 'b');
text(B(1), B(2), 'B', 'color', 'b');
text(C(1), C(2), 'C', 'color', 'b');
text(D(1), D(2), 'D', 'color', 'b');
text(E(1), E(2), 'E', 'color', 'b');
text(F(1), F(2), 'F', 'color', 'b');
axis equal;
w = xlim; h = ylim;
axis([w(1)-1 w(2)+1 h(1)-1 h(2)+1]);
hold off;