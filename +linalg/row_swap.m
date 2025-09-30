function E = row_swap(row_1, row_2, dim)
    % row_swap generates an elementary matrix that swaps two rows in a matrix.
    % 
    % Inputs:
    %   row_1 - The first row to be swapped.
    %   row_2 - The second row to be swapped.
    %   dim   - The dimension of the square matrix.
    % 
    % Output:
    %   E     - The elementary matrix that swaps row_1 and row_2.
    
    % Check if the input rows are valid
    if row_1 > dim || row_2 > dim || row_1 < 1 || row_2 < 1
        error('Row indices must be within the range of the matrix dimension.');
    end

    % Create an identity matrix of the specified dimension
    E = eye(dim);

    % Swap the rows in the identity matrix
    E([row_1, row_2], :) = E([row_2, row_1], :);
end

% Example usage:
% To multiply matrices that swap rows:
% result = row_swap(1, 2, 3) * row_swap(2, 3, 3);
