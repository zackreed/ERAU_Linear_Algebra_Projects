function difference_list = compute_difference_at_indices(index_matrix, value_matrix)
    % COMPUTE_DIFFERENCE_AT_INDICES
    % This function computes the differences between corresponding values
    % in `value_matrix` at the nonzero indices of `index_matrix`.
    %
    % Inputs:
    %   index_matrix - A matrix whose only nonzero values are at desired indices.
    %   value_matrix - A matrix of the same size as `index_matrix`.
    %
    % Output:
    %   difference_list - A list of differences between the values in
    %   `value_matrix` and the values at the same indices in `index_matrix`.

    % Validate input dimensions
    if ~isequal(size(index_matrix), size(value_matrix))
        error('The input matrices must have the same dimensions.');
    end

    % Find the row and column indices of the nonzero entries in index_matrix
    [row_indices, col_indices] = find(index_matrix ~= 0);

    % Extract the values from index_matrix at these indices
    index_values = index_matrix(sub2ind(size(index_matrix), row_indices, col_indices));

    % Extract the corresponding values from value_matrix at these indices
    value_values = value_matrix(sub2ind(size(value_matrix), row_indices, col_indices));

    % Compute the differences
    difference_list = value_values - index_values;
end