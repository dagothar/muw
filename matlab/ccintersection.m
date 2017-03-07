function [a, b] = ccintersection(c1, c2)

    dx = c2(1) - c1(1);
    dy = c2(2) - c1(2);
    
    th = atan2(dy, dx);
    
    d = ppdistance(c1, c2);
    x = (c1(3)^2 - c2(3)^2 + d^2) / (2*d);
    y = sqrt(c1(3)^2 - x^2);
    
    a(1) = c1(1) + x*cos(th) - y*sin(th);
    a(2) = c1(2) + x*sin(th) + y*cos(th);
    
    b(1) = c1(1) + x*cos(th) + y*sin(th);
    b(2) = c1(2) + x*sin(th) - y*cos(th);
    
end