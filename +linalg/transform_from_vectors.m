function transformed_points = transform_from_vectors(points, vector1, vector2)
    points=points';
    % Ensure the vectors are column vectors
    vector1 = vector1(:);
    vector2 = vector2(:);

    % Create the transformation matrix with vectors as columns
    transformation_matrix = [vector1, vector2];

    % Apply the transformation to the points
    transformed_points = (transformation_matrix * points');

    % Return the transformed points
end