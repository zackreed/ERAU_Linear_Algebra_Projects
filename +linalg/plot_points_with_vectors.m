function plot_points_with_vectors(points)
    % Vectors come from the last two points in the point cloud
    points=points';
    vectors = points(end-1:end, :);

    % Plot points except for the last two in purple
    points = points(1:end-2, :);
    scatter(points(:,1), points(:,2), 'MarkerEdgeColor', 'magenta');
    hold on;

    % Plot the first vector in blue as a quiver
    quiver(0, 0, vectors(1, 1), vectors(1, 2), 'Color', 'blue', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

    % Plot the second vector in red as a quiver
    quiver(0, 0, vectors(2, 1), vectors(2, 2), 'Color', 'red', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

    % Set axis equal for correct scaling
    axis equal;

    % Create labels with actual vector values
    label_vector_1 = sprintf('Basis Vector 1: (%.2f, %.2f)', vectors(1, 1), vectors(1, 2));
    label_vector_2 = sprintf('Basis Vector 2: (%.2f, %.2f)', vectors(2, 1), vectors(2, 2));

    % Add legend with the updated labels
    legend({'Point Cloud', label_vector_1, label_vector_2}, 'Location', 'bestoutside');

    % Display the plot
    hold off;
end