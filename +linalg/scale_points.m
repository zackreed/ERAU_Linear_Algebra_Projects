function scaled_points = scale_points(points, scale_amount, horizontal)
    % Default horizontal scaling if not provided
    if nargin < 3
        horizontal = true;
    end

    % Create the scale matrix
    if horizontal
        scale_matrix = [scale_amount, 0;
                        0, 1];
    else
        scale_matrix = [1, 0;
                        0, scale_amount];
    end

    % Apply the scale to the points
    scaled_points = (scale_matrix * points);

    % Return the scaled points
end