function rotated_points=rotate_points(points,angle)
    points=points';
    % Convert angle to radians
    theta = deg2rad(angle);

    % Create the 2D rotation matrix for the given angle
    rotation_matrix = [cos(theta), -sin(theta);
                       sin(theta), cos(theta)];

    % Apply the rotation to the points
    rotated_points = (rotation_matrix * points');

    % Return the rotated points
end
