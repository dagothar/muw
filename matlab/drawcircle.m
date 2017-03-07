function drawcircle(c, attr, n)

    xs = [];
    ys = [];
    
    for t = 0:2*pi/n:2*pi
        x = c(1) + c(3)*cos(t);
        y = c(2) + c(3)*sin(t);
        
        xs = [xs x];
        ys = [ys y];
    end
    
    plot(xs, ys, attr, 'LineSmoothing', 'on');

end