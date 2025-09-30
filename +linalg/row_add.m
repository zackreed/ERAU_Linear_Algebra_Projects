function E = row_add(row_1, row_2, scalar, dim)
    % row_add generates an elementary matrix that adds a scaled version of one row to another.
    % 
    % Inputs:
    %   row_1  - The row to be scaled and added.
    %   row_2  - The row to which the scaled row_1 is added.
    %   scalar - The scalar by which row_1 is multiplied before being added to row_2.
    %   dim    - The dimension of the square matrix.
    % 
    % Output:
    %   E      - The elementary matrix that adds the scaled row_1 to row_2.
    
    % Check if the input rows are valid
    if row_1 > dim || row_2 > dim || row_1 < 1 || row_2 < 1
        error('Row indices must be within the range of the matrix dimension.');
    end

    % Create an identity matrix of the specified dimension
    E = eye(dim);

    % Add the scaled version of row_1 to row_2
    E(row_1, row_2) = scalar;
end

% Example usage:
% To multiply matrices that perform row additions:
% result = row_add(1, 2, 3, 3) * row_add(2, 3, -1, 3);
