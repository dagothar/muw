function d = lpdistance(l, p)

    d = abs(l(1)*p(1) + l(2)*p(2) + l(3)) / sqrt(l(1)^2 + l(2)^2);

end