function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
  dimensions = size(FeatureMatrix);
  m = dimensions(1);
  cols = dimensions(2);
  Error = 0;

  % deter eroarea patratica pentru fiecare exemplu
  for i = 1:m
    h_theta = 0;
    for j = 1:cols
      h_theta += FeatureMatrix(i, j) * Theta(j+1);
      disp(h_theta);

    endfor
    Error += (h_theta - Y(i))^2;
  endfor

  % calc media erorilor
  Error /= (2*m);
  disp(Error);


  % acm adaug termenul de regularizare L2
  lambda_sum = 0;
  for j = 2:cols+1
    lambda_sum += Theta(j)^2;
  endfor
  lambda_sum *= lambda;

  Error += lambda_sum;
  disp(Error);
end
