function result = mod_divide(a, b, m)
    % MOD_DIVIDE Perform modular division a / b mod m
    % a: numerator
    % b: denominator
    % m: modulus
    
    % Compute modular inverse of b mod m
    b_inv = mod_inverse(b, m);
    if b_inv == -1
        error('No modular inverse exists for b = %d mod %d', b, m);
    end
    
    % Compute a * b^(-1) mod m
    result = mod(a * b_inv, m);
end

function inv = mod_inverse(b, m)
    % MOD_INVERSE Compute the modular inverse of b mod m using the extended Euclidean algorithm
    [g, x, ~] = gcd(b, m);
    if g ~= 1
        inv = -1; % No modular inverse exists
    else
        inv = mod(x, m); % Modular inverse exists
    end
end
