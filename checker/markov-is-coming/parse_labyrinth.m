function [Labyrinth] = parse_labyrinth(file_path)

  % deschid fisierul
  fid = fopen(file_path, "r");

  dimensions = [];
  dimensions = fscanf(fid, "%d", 2);
  rows = dimensions(1);
  cols = dimensions(2);

  %Labyrinth = zeros(rows, cols);
  Labyrinth = sparse(rows, cols);

  for i = 1:rows
    for j = 1:cols
      number = fscanf(fid, "%d", 1);
      Labyrinth(i,j) = number;
      disp(Labyrinth(i,j));
    endfor
  endfor

  % inchid fisierul
  fclose(fid);
  
end