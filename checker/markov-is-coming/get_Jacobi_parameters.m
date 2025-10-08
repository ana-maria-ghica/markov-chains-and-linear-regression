function [G, c] = get_Jacobi_parameters (Link)

  dimensions = size(Link);
  rows = dimensions(1) - 2;
  cols = dimensions(2) - 2;
  % G = zeros(rows, cols);
  % c = zeros(cols, 1);

  G = sparse(rows, cols);
  c = sparse(cols, 1);

  % atribui valorile corespunzatoare
  for i = 1:rows
    for j = 1:cols
      G(i,j) = Link(i,j);
    endfor
  endfor

  disp(G);

  % si pt vector atribui valorile corespunzatoare
  for j = 1:rows
    c(j) = Link(j, cols+1);
  endfor

  disp(c);

end
