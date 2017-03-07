function [a, b] = clintersection(c, l)

    A = 1 + (l(1)/l(2))^2;
    B = 2*(l(1)/l(2) * (l(3)/l(2)+c(2)) - c(1));
    C = c(1)^2 + (c(2)+l(3)/l(2))^2 - c(3)^2;
    
    D = B^2 - 4*A*C;
    
    if (D < 0)
%         error('Brak punktu przeciecia miedzy linia i okregiem.');
    end
    
    a(1) = (-B - sqrt(D)) / (2*A);
    a(2) = -l(1)/l(2) * a(1) - l(3)/l(2);
    
    b(1) = (-B + sqrt(D)) / (2*A);
    b(2) = -l(1)/l(2) * b(1) - l(3)/l(2);
    
end
