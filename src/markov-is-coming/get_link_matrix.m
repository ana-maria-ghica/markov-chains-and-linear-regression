function [Link] = get_link_matrix (Labyrinth)
  dimensions = size(Labyrinth);
  rows = dimensions(1);
  cols = dimensions(2);
  disp(rows);
  disp(cols);

  % Link = zeros(rows*cols + 2, rows*cols + 2);
  Link = sparse(rows*cols + 2, rows*cols + 2);

  Adj = get_adjacency_matrix(Labyrinth);

  for i = 1:rows*cols + 2
    cnt = 0;

    %gaseste cati vecini are celula
    for j = 1:rows*cols + 2
      if Adj(i,j) == 1
        cnt = cnt + 1;
      endif
    endfor

    %scrie valorile probabilitatilor in matricea Link
    for j = 1:rows*cols + 2
      if Adj(i,j) == 1
        Link(i,j) = 1/cnt;
      endif
    endfor

  endfor

  disp(Link);

  % pun 1 pentru pozitiile corespunzatoare la WIN si LOSE
  Link(rows*cols + 1, rows*cols + 1) = 1;
  Link(rows*cols + 2, rows*cols + 2) = 1;  

  disp(Link);
end
