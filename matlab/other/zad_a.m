clc; clear all; close all;

%% Dane
    a = 225;
    w = 1;
    n = 24;

    AB = 10;
    AC = 1;
    BD = 7;
    CD = 15;
    DE = 4;
    EF = 5;
    
    r = (BD+DE)/BD;
    
    nD = 0;
    nF = 0;

%% Obliczenia
A = [ 0, 0, AC ];
 B = [ AB, 0, BD ];

D1 = [0 0];
F1 = [0 0];

M1 = [ 0 0 ];

i = 1;
dt = 2*pi/(w*n);
t0 = (90-a) * pi/180;
for t = t0 : 2*pi/n : t0+2*pi
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

for i = 1 : length(Fs)-1
    text(Fs(i, 1), Fs(i, 2), num2str(i-1), 'color', 'k');
end

axis equal;
s = xlim; h = ylim;
axis([s(1)-1 s(2)+1 h(1)-1 h(2)+1]);
hold off;
title('Tor ruchu punktu F');

%% Hodograf prêdkoœci
vs = [Fs(2, 1)-Fs(length(Fs)-1, 1) Fs(2, 2)-Fs(length(Fs)-1, 2)];
for i = 2 : length(Fs)-1
    v = [Fs(i+1, 1)-Fs(i-1, 1) Fs(i+1, 2)-Fs(i-1, 2)];
    vs = [vs; v];
end
v = [Fs(2, 1)-Fs(length(Fs)-1, 1) Fs(2, 2)-Fs(length(Fs)-1, 2)];
vs = [vs; v];

% vs = vs / (2*dt);

figure(2);
plot(vs(:, 1), vs(:, 2), 'linesmoothing', 'on'); hold on;

for i = 1 : length(vs)-1
    text(vs(i, 1), vs(i, 2), num2str(i-1), 'color', 'k');
end

%% Hodograf przyspieszeñ
as = [vs(2, 1)-vs(length(vs)-1, 1) vs(2, 2)-vs(length(vs)-1, 2)];
for i = 2 : length(vs)-1
    a = [vs(i+1, 1)-vs(i-1, 1) vs(i+1, 2)-vs(i-1, 2)];
    as = [as; a];
end
a = [vs(2, 1)-vs(length(vs)-1, 1) vs(2, 2)-vs(length(vs)-1, 2)];
as = [as; a];

% as = as / (2*dt);

plot(as(:, 1), as(:, 2), 'r', 'linesmoothing', 'on');
plot(0, 0, 'kx'); hold off;

for i = 1 : length(vs)-1
    text(as(i, 1), as(i, 2), num2str(i-1), 'color', 'k');
end

axis equal;
title('Hodografy');
legend('predkosci', 'przyspieszen');
grid on;

%% Plan prêdkoœci
% va = [0; 0];
% vb = [0; 0];
% 
% vc = cross([C(1)-A(1) C(2)-A(2) 0], [0 0 w]);
% 
% cd = makeline(C, D); 
% cd(3) = cd(3) - cd(1)*vc(1) - cd(2)*vc(2);
% bd = makeline(B, D);
% 
% vd = [[-bd(2) bd(1); -cd(2) cd(1)]\[bd(3); cd(3)]; 0]';
% % vd = [vdt(2) -vdt(1) 0];
% % vd = cd;
% 
% figure(1);
% line([C(1) C(1)+vc(1)], [C(2) C(2)+vc(2)], 'color', 'r');
% text(C(1)+vc(1), C(2)+vc(2), 'vc');
% line([D(1) D(1)+vd(1)], [D(2) D(2)+vd(2)], 'color', 'r');
% text(D(1)+vd(1), D(2)+vd(2), 'vd');