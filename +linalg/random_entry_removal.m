function modified_matrix = random_entry_removal(input_matrix, numToZero)
    % RANDOM_ENTRY_REMOVAL Randomly sets a specified number of elements to 0 in a matrix.
    %
    % Inputs:
    %   input_matrix - The input matrix whose elements will be randomly set to 0.
    %   numToZero    - The number of elements to randomly set to 0.
    %
    % Output:
    %   modified_matrix - The resulting matrix with the specified number of elements set to 0.

    % Ensure numToZero is not greater than the total number of elements
    totalElements = numel(input_matrix);
    if numToZero > totalElements
        error('numToZero cannot exceed the total number of elements in the matrix.');
    end

    % Copy the input matrix to modify
    modified_matrix = input_matrix;

    % Randomly select indices to set to 0
    randomIndices = randperm(totalElements, numToZero);

    % Set the selected elements to 0
    modified_matrix(randomIndices) = 0;
end
