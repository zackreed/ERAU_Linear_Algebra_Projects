function result = split_vector(A, k)
    % A: Input column vector
    % k: Desired size of each sub-vector
    
    % Get the length of the input vector
    n = numel(A);
    
    % Calculate the number of rows required for the final output
    rows = ceil(n / k);
    
    % Pad the vector with zeros if necessary to make its length a multiple of k
    paddedA = [A; zeros(rows * k - n, 1)];
    
    % Reshape the padded vector into a k x rows matrix
    reshaped = reshape(paddedA, k, rows);
    
    % Transpose to get the desired output as k x 1 vectors
    result = reshaped;
end