function E = row_mod_scale(row, scalar, dim, p)
    % ROW_MOD_SCALE generates an elementary matrix that scales a specific row
    % by a scalar in modular arithmetic mod p.
    %
    % Inputs:
    %   row    - The row to be scaled.
    %   scalar - The scalar value to scale the row by (mod p).
    %   dim    - The dimension of the square matrix.
    %   p      - The modulus.
    %
    % Output:
    %   E      - The elementary matrix that scales the specified row under mod p.
    
    % Check if the input row is valid
    if row > dim || row < 1
        error('Row index must be within the range of the matrix dimension.');
    end

    % Ensure the scalar is valid under mod p
    if scalar < 0
        scalar = mod(scalar, p); % Convert negative scalar to equivalent mod p
    end

    if mod(scalar, 1) ~= 0
        % Handle fractional scalars: scalar = numerator * mod_inverse(denominator, p)
        [num, denom] = rat(scalar); % Convert to numerator/denominator
        denom_inv = mod_inverse(denom, p);
        if denom_inv == -1
            error('Denominator %d has no modular inverse mod %d.', denom, p);
        end
        scalar = mod(num * denom_inv, p);
    end

    % Check if the scalar has an inverse mod p
    scalar_inv = mod_inverse(scalar, p);
    if scalar_inv == -1
        error('The scalar value %d has no modular inverse mod %d.', scalar, p);
    end

    % Create an identity matrix of the specified dimension
    E = eye(dim);

    % Scale the specified row with the modular inverse
    E(row, row) = scalar_inv;
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
