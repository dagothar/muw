    clc; clear all; close all;

%% Data
    % lengths of links
    AB = 2;
    AC = 1;
    BD = 3;
    CD = 3;
    DE = 5;
    
    % id of solutions for D and E joints
    nD = 1;
    nE = 1;
    
    w = 1;

%% Calculating...
figure(1);

A = [ 0, 0, AC ];
B = [ AB, 0, BD ];

D1 = [0 0];
E1 = [0 0];

i = 1;
dt = 0.1;
t = 0;

while 1
    % calculate the positon of C
    C(1) = AC * sin(w*t);
    C(2) = AC * cos(w*t);
    C(3) = CD;
    
     % calculate the positon of D
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
    
    D(3) = DE;
    l = makeline(A, B);
    
     % calculate the positon of E
    [Et1, Et2] = clintersection(D, l);
    
    if (ppdistance(E1, Et1) < ppdistance(E1, Et2))
        E1 = Et1;
        E2 = Et2;
    else
        E1 = Et2;
        E2 = Et1;
    end
    
    if nE
        E = E2;
    else
        E = E1;
    end
    
    Es(i, :) = E;
    
    t = t + dt;
    
    plot([0 C(1)], [0 C(2)], 'color', 'k', 'linewidth', 2);  hold on;
    plot([B(1) D(1)], [B(2) D(2)], 'color', 'k', 'linewidth', 2);
    plot([C(1) D(1)], [C(2) D(2)], 'color', 'k', 'linewidth', 2);
    plot([D(1) E(1)], [D(2) E(2)], 'color', 'k', 'linewidth', 2);
    plot([E(1)], [E(2)], 'ro');
    drawcircle(A, 'y', 100);
    drawcircle(C, 'r', 100);
    drawcircle(D, 'g', 100);
    drawcircle(B, 'b', 100);
    plot([-AB-BD-DE AB+BD+DE], [0 0], 'k--');
    text(A(1), A(2), 'A');
    text(B(1), B(2), 'B');
    text(C(1), C(2), 'C');
    text(D(1), D(2), 'D');
    text(E(1), E(2), 'E');
    hold off;
    
    if abs(AC) > abs(BD)
        a1 = -AC;
    else
        a1 = -BD;
    end
    
    if abs(AB+BD+DE) > max([AC, BD])
        a2 = AB+BD+DE;
    else
        a2 = max([AC, BD]);
    end

    axis([-6 9 -6 9]);
    axis square;
    
%     if w*t < 2*pi
%         print(gcf, ['dod' num2str(i) '.png'], '-dpng');
%     end
    i = i + 1;
    
    pause(0.01);
end
