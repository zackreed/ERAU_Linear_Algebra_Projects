function transformed_points = plot_transformed_img_points(points, transformation)
    % Apply the transformation to the points
    transformed_points = transformation * points';
    transformed_points = transformed_points';

    % Check if the data is 2D or 3D based on the number of columns in points
    if size(transformed_points, 2) == 2
        % 2D scatter plot with larger points (e.g., size 10)
        scatter(transformed_points(:,1), transformed_points(:,2), 10, 'MarkerEdgeColor', 'magenta');  % '10' is the marker size
        xlabel('X'); ylabel('Y');
    elseif size(transformed_points, 2) == 3
        % 3D scatter plot with smaller points (e.g., size 5)
        scatter3(transformed_points(:,1), transformed_points(:,2), transformed_points(:,3), 5, 'MarkerEdgeColor', 'magenta');  % '5' is the marker size
        xlabel('X'); ylabel('Y'); zlabel('Z');
    else
        error('Input points must be either 2D or 3D.');
    end

    hold on;

    % Set axis equal for correct scaling
    axis equal;

    % Display the plot
    hold off;
end
