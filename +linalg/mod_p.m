function result = mod_p(A, p)
    % MODP performs modular arithmetic on a matrix, handling both integers and fractions.
    % Each element of the matrix is converted to its modular equivalent under mod p.
    % Fractions are converted appropriately.
    %
    % Inputs:
    %   A  - The input matrix.
    %   p  - The modulus.
    %
    % Output:
    %   result - Matrix with each element mod p (including fractions).
    
    [rows, cols] = size(A);
    result = zeros(rows, cols);  % Initialize the result matrix
    
    for i = 1:rows
        for j = 1:cols
            value = A(i,j);
            if mod(value, 1) == 0
                % Handle integer values directly
                result(i,j) = mod(value, p);
            else
                % Handle fractional values
                [num, denom] = rat(value);  % Convert the value to a fraction (numerator/denominator)
                
                % Take mod of numerator and denominator separately
                num_mod = mod(num, p);
                denom_mod = mod(denom, p);
                
                % Find the modular inverse of the denominator
                denom_inv = mod_inverse(denom_mod, p);
                
                if denom_inv == -1
                    error('Denominator %d has no modular inverse mod %d.', denom_mod, p);
                end
                
                % Compute the modular equivalent of the fraction
                result(i,j) = mod(num_mod * denom_inv, p);
            end
        end
    end
end

function inv = mod_inverse(b, m)
    % MOD_INVERSE Compute the modular inverse of b mod m using the extended Euclidean algorithm.
    [g, x, ~] = gcd(round(b), m); % Round input to ensure it's an integer
    if g ~= 1
        inv = -1; % No modular inverse exists
    else
        inv = mod(x, m); % Modular inverse exists
    end
end
