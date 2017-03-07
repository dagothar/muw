function l = makeline(p1, p2)

    dx = p2(1) - p1(1);
    dy = p2(2) - p1(2);
    
    if (abs(dy) < abs(dx))
        l(1) = dy / dx;
        l(2) = -1;
        l(3) = p1(2) - l(1) * p1(1);
    else
        l(1) = -1;
        l(2) = dx / dy;
        l(3) = p1(1) - l(2) * p1(2);
    end

    

end
