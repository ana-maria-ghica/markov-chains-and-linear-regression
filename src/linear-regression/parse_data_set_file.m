function [Y, InitialMatrix] = parse_data_set_file(file_path)
  % deschid fisierul
  fid = fopen(file_path, 'r');

  dimensions = fscanf(fid, "%d", 2);
  rows = dimensions(1);
  cols = dimensions(2);
  fgetl(fid);
  disp(rows);
  disp(cols);

  InitialMatrix = cell(rows, cols-1);
  Y = zeros(rows,1);

  for i = 1:rows
    % citesc o linie
    line = fgetl(fid);
    
    % un fel de strtok din C
    element = strsplit(line,' ');

    % transform in double din string
    Y(i) = str2double(element{1});

    for j = 2:length(element)
      % daca e numar e salvat ca numar
      % daca e string e salvat ca string
      if ~isnan(str2double(element{j}))
        InitialMatrix{i,j} = str2double(element{j});
      else
        InitialMatrix{i,j} = element{j};
      end
    endfor
  endfor

  disp(InitialMatrix);
  % inchid fisierul
  fclose(fid);
end
