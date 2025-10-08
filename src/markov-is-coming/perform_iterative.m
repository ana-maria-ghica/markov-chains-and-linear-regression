function [x, err, steps] = perform_iterative (G, c, x0, tol, max_steps)
  % aplicarea efectiva a algoritmului Jacobi

  % pornesc cu aproximarea initiala
  x = x0;

  %setez eroarea initial pe inf
  err = inf;
  
  steps = 0;
  while (steps < max_steps) && (err > tol)
	x_prev = x;
    x = G*x + c;
    err = norm(x - x_prev);
    steps = steps + 1;
  endwhile
end
