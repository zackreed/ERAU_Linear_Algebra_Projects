function rmse = compute_rmse(matrix1, matrix2)
    % CALCULATE_RMSE - Calculates the Root Mean Squared Error (RMSE) between two matrices.
    %
    % Syntax:
    %   rmse = calculate_rmse(matrix1, matrix2)
    %
    % Inputs:
    %   matrix1 - First matrix.
    %   matrix2 - Second matrix of the same size as matrix1.
    %
    % Output:
    %   rmse - The root mean squared error between the two matrices.
    
    % Validate input dimensions
    if ~isequal(size(matrix1), size(matrix2))
        error('Input matrices must have the same dimensions.');
    end
    
    % Calculate the squared differences
    squared_differences = (matrix1 - matrix2) .^ 2;
    
    % Compute the mean of the squared differences
    mean_squared_error = mean(squared_differences(:));
    
    % Compute the root mean squared error
    rmse = sqrt(mean_squared_error);
end
