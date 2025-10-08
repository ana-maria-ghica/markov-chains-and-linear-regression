function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
  dimensions = size(FeatureMatrix);
  m = dimensions(1);
  cols = dimensions(2);
  Error = 0;
  disp(Theta);
  disp(size(Theta));

  for i = 1:m
    h_theta = 0;
    for j = 1:cols
      h_theta = h_theta + FeatureMatrix(i, j) * Theta(j+1);
      disp(h_theta); % verific valoarea
    endfor
    Error = Error + (h_theta - Y(i))^2;;
    disp(Error); % verif
  endfor
  Error /= (2*m);

  % pentru debug:
  fprintf("%.6f", Error);
  disp(size(Y));
  disp(size(FeatureMatrix));
end
