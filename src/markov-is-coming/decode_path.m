function [decoded_path] = decode_path (path, lines, cols)
    n = length(path);
    decoded_path = zeros(n-1, 2);
    % decoded_path = sparse(n-1, 2); OBS: nu merge cu sparse!!! da eroare checkerul

    for i = 1:(n-1)
        position = path(i);
                
        % nr de randuri parcurse (coord pe OX) se deter scazand succesiv cate o coloana completa
        % pana ajung aproape de pozitia initiala si nu mai pot scade
        x = 1;
        dif = position;
        while dif > cols
            dif = dif - cols;
            x = x + 1;
        end
        disp(x);

        % ce ramane reprezinta coordonata pe OY
        y = dif;
        disp(y);

        decoded_path(i, 1) = x;
        decoded_path(i, 2) = y;
    end
    %disp(decode_path);
end