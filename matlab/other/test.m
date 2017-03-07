clc; clear all; close all;

%% Dane
    AB = 15;
    AC = 5;
    BD = 7;
    CD = 16;
    r = 0.5;

%% Obliczenia
A = [ 0, 0, AC ];
B = [ AB, 0, BD ];

D1 = [0 0];

M1 = [ 0 0 ];

i = 1;
dt = 2*pi/100;
for t = 0 : dt : 2*pi
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
    
    M1(i, :) = pbetween(C, D1, r);
    M2(i, :) = pbetween(C, D2, r);
    
    i = i + 1;
end

%% Wykres
figure(1); hold on;
line([A(1) C(1)], [A(2) C(2)], 'color', 'k', 'linewidth', 3); %AC1
line([B(1) D1(1)], [B(2) D1(2)], 'color', 'k', 'linewidth', 3); %BD1
line([C(1) D1(1)], [C(2) D1(2)], 'color', 'k', 'linewidth', 3); %CD1
line([B(1) D2(1)], [B(2) D2(2)], 'color', [0.5 0.5 0.5], 'linewidth', 3); %BD2
line([C(1) D2(1)], [C(2) D2(2)], 'color', [0.5 0.5 0.5], 'linewidth', 3); %CD2
plot(M1(:, 1), M1(:, 2), 'r');
plot(M2(:, 1), M2(:, 2), 'b');
axis equal; hold off;