function [Theta] = normal_equation(FeaturesMatrix, Y, tol, iter)
  X = FeaturesMatrix;
  A = X' * X;
  b = X' * Y;
  n = size(X, 2);

  %injitializez
  Theta = zeros(n, 1);

  % implementare: gradient conjugat
  r = b - A * Theta;
  v = r;
  tol_patrat = tol^2;
  disp(tol_patrat);
  k = 1;

  % efectiv algoritmul prezentat, pas cu pas
  while (k <= iter) && ((r' * r) > tol_patrat)
    Av = A * v;
    t_k = (r' * r) / (v' * Av); % -> t_k

    Theta = Theta + t_k * v;% -> x_k
    disp(Theta);

    r_new = r - t_k * Av; % -> r_k
    s_k = (r_new' * r_new) / (r' * r); % -> s_k
    v = r_new + s_k * v; % -> v_k
    r = r_new;
    k += 1;
  end

  % adaug coef zero in fata ca sa treaca testul
  Theta = [0; Theta];
  disp(Theta);
end