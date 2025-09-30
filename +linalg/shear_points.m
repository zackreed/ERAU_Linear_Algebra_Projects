function sheared_points = shear_points(points, shear_amount, horizontal)
    points=points';
    % Default horizontal shearing if not provided
    if nargin < 3
        horizontal = true;
    end

    % Create the shear matrix
    if horizontal
        shear_matrix = [1, shear_amount;
                        0, 1];
    else
        shear_matrix = [1, 0;
                        shear_amount, 1];
    end

    % Apply the shear to the points
    sheared_points = (shear_matrix * points');

    % Return the sheared points
end
