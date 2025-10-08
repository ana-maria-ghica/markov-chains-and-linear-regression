function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
  dimensions = size(InitialMatrix);
  rows = dimensions(1);
  cols = dimensions(2);
  FeatureMatrix = sparse(rows, cols);

  for i = 1:rows
    FeatureMatrix(i,1) = InitialMatrix{i,2};
  endfor

  for i = 1:rows
    for j = 3:cols

      if isnumeric(InitialMatrix{i,j})
        if j == cols
          FeatureMatrix(i,cols) = InitialMatrix{i,j};
        else
          FeatureMatrix(i,j-1) = InitialMatrix{i,j};
        endif
      elseif ~isempty(strfind(InitialMatrix{i,j}, "yes"))
        FeatureMatrix(i,j-1) = 1;
      elseif ~isempty(strfind(InitialMatrix{i,j}, "no"))
        FeatureMatrix(i,j-1) = 0;
      elseif ~isempty(strfind(InitialMatrix{i,j}, "semi-furnished"))
        FeatureMatrix(i,j-1) = 1;
        FeatureMatrix(i,j) = 0;
        j = j + 1;
      elseif ~isempty(strfind(InitialMatrix{i,j}, "unfurnished"))
        FeatureMatrix(i,j-1) = 0;
        FeatureMatrix(i,j) = 1;
        j = j + 1;
      elseif ~isempty(strfind(InitialMatrix{i,j}, "furnished"))
        FeatureMatrix(i,j-1) = 0;
        FeatureMatrix(i,j) = 0;
        j = j + 1;
      endif

    endfor
  endfor

% afisare ca sa vad daca e bine ce am facut <33
for i = 1:size(FeatureMatrix, 1)
    for j = 1:size(FeatureMatrix, 2)
        fprintf('%.2f ', FeatureMatrix(i, j));
    end
    fprintf('\n');
end

end

