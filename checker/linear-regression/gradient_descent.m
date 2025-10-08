function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
  disp(size(FeatureMatrix)); % -> 545 13
  disp(size(Y)); % -> 545 1
  disp(n); % -> 13
  disp(m); % -> 545
  disp(alpha); % -> 1.0000e-16
  disp(iter); % -> 125
  
  Theta = zeros(n+1, 1);
  for i = 1:iter
    error = zeros(m, 1);

    % algoritmul din enuntul temei
    for k = 1:m
      h_theta = 0;
      for j = 1:n
        h_theta += FeatureMatrix(k, j) * Theta(j);
      endfor
      error(k) = h_theta - Y(k);
    endfor

    for j = 1:n
      gradient_sum = 0;
      for k = 1:m
        gradient_sum += error(k) * FeatureMatrix(k, j);
      endfor
      gradient = gradient_sum / m;
      
      Theta(j+1) = Theta(j+1) - alpha * gradient;
    endfor
    Theta(1) = 0;
  endfor
end