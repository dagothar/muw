function p = pbetween(p1, p2, t)

    p(1) = (1-t)*p1(1) + t*p2(1);
    p(2) = (1-t)*p1(2) + t*p2(2);
    
end