function E = row_scale(row, scalar, dim)
    % row_scale generates an elementary matrix that scales a specific row by a scalar.
    % 
    % Inputs:
    %   row    - The row to be scaled.
    %   scalar - The scalar value to scale the row by.
    %   dim    - The dimension of the square matrix.
    % 
    % Output:
    %   E      - The elementary matrix that scales the specified row.
    
    % Check if the input row is valid
    if row > dim || row < 1
        error('Row index must be within the range of the matrix dimension.');
    end

    % Create an identity matrix of the specified dimension
    E = eye(dim);

    % Scale the specified row
    E(row, row) = scalar;
end

% Example usage:
% To multiply matrices that scale rows:
% result = row_scale(1, 2, 3) * row_scale(2, 0.5, 3);
