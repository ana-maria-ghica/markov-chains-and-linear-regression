function [Y, InitialMatrix] = parse_csv_file(file_path)
  fid = fopen(file_path, 'r');
  rows = 0;
  cols = 0;

  header = fgetl(fid);
  element = strsplit(header,',');
  cols = length(element);
  
  % numar cate linii sunt in fisier
  % ca sa determin nr de linii si coloane pt matrice
  linie = fgetl(fid);
  rows = 1;
  while ischar(linie)
    rows = rows + 1;
    linie = fgetl(fid);
  end
  rows = rows - 1;

  % dau frewind la fisier pt a reveni la inceput, ca sa prelucrez fiecare termen
  frewind(fid);
  header = fgetl(fid);

  InitialMatrix = cell(rows, cols-1);
  Y = zeros(rows,1);
  

  for i = 1:rows
    line = fgetl(fid);
    
    element = strsplit(line,',');

    Y(i) = str2double(element{1});

    for j = 2:length(element)
      if ~isnan(str2double(element{j}))
        InitialMatrix{i,j} = str2double(element{j});
      else
        InitialMatrix{i,j} = element{j};
      end
    endfor
  endfor
  fclose(fid);

end
