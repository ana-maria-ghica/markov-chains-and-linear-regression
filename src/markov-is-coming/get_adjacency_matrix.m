function [Adj] = get_adjacency_matrix (Labyrinth)

  % determin dimensiunile matricei cu care lucrez
  % consider o matrice auxiliara (de tip Cell), Encoded_Labyrinth
  % ca sa pot sa prelucrez mai usor codificarile fiecarei stari din labirint

  dimensions = size(Labyrinth);
  rows = dimensions(1);
  cols = dimensions(2);
  Encoded_Labyrinth = cell(rows, cols); % matrice auxiliara!!

  for i = 1:rows
    for j = 1:cols
      decimal_number = Labyrinth(i,j);
      binary_number = dec2bin(decimal_number);

      % consider un string sub forma a 4 biti, pentru a face prelucrari pe string
      % si a determina mai usor (si intuitiv) unde se poate deplasa robotul in labirint
      
      if length(binary_number) == 1
        Encoded_Labyrinth{i,j} = sprintf("000%s", binary_number);
      elseif length(binary_number) == 2
        Encoded_Labyrinth{i,j} = sprintf("00%s", binary_number);
      elseif length(binary_number) == 3
        Encoded_Labyrinth{i,j} = sprintf("0%s", binary_number);
      else
        Encoded_Labyrinth{i,j} = binary_number;
      end
    endfor
  endfor

  % Adj = zeros(rows*cols + 2, rows*cols + 2);
  Adj = sparse(rows*cols + 2, rows*cols + 2);

  for i = 1:rows
    for j = 1:cols
    number = Encoded_Labyrinth{i, j};

    %bitul 1 == merge spre NORD
    current_index = (i-1)*cols + j;
    if number(1) == '0'
      if i == 1
        Adj(current_index, rows*cols + 1) = 1;
      else
        Adj(current_index, current_index - cols) = 1;
      end
    endif

    %bitul 2 == merge spre SUD
    if number(2) == '0'
      if i == rows
        Adj(current_index, rows*cols + 1) = 1;
      else
        Adj(current_index, current_index + cols) = 1;
      end
    endif

    %bitul 3 == merge spre EST
    if number(3) == '0'
      if j == cols
        Adj(current_index, rows*cols + 2) = 1;
      else
        Adj(current_index, current_index+1) = 1;
      end
    endif

    %bitul 4 == merge spre VEST
    if number(4) == '0'
      if j == 1
        Adj(current_index, rows*cols + 2) = 1;
      else
        Adj(current_index, current_index-1) = 1;
      end
    endif

    endfor
  endfor

  Adj(rows*cols + 1, rows*cols + 1) = 1;
  Adj(rows*cols + 2, rows*cols + 2) = 1;
end
