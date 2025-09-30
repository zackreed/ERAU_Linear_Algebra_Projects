function modified_matrix = random_nonzero_entry_removal(input_matrix, numToZero)
    % RANDOM_NONZERO_ENTRY_REMOVAL Randomly sets a specified number of nonzero elements to 0 in a matrix.
    %
    % Inputs:
    %   input_matrix - The input matrix whose nonzero elements will be randomly set to 0.
    %   numToZero    - The number of nonzero elements to randomly set to 0.
    %
    % Output:
    %   modified_matrix - The resulting matrix with the specified number of nonzero elements set to 0.

    % Find indices of nonzero elements
    nonzeroIndices = find(input_matrix ~= 0);

    % Ensure numToZero is not greater than the number of nonzero elements
    totalNonzero = numel(nonzeroIndices);
    if numToZero > totalNonzero
        error('numToZero cannot exceed the total number of nonzero elements in the matrix.');
    end

    % Randomly select indices of nonzero elements to set to 0
    randomIndices = nonzeroIndices(randperm(totalNonzero, numToZero));

    % Copy the input matrix to modify
    modified_matrix = input_matrix;

    % Set the selected nonzero elements to 0
    modified_matrix(randomIndices) = 0;
end