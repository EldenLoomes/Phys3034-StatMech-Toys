function g = thermalDoS(E, A, B)
    g = [];
    for eachE = E
        if (eachE < A)
            g = [g, sqrt(A-eachE)];
        elseif (eachE > B)
            g = [g, sqrt(eachE-B)];
        else
            g = [g, 0];
        end
    end
return