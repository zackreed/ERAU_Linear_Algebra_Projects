function plot_points(points)
    % Vectors come from the last two points in the point cloud
    %vectors = points(end-1:end, :);

    points=points';

    % Plot points except for the last two in purple
    scatter(points(:,1), points(:,2), 'MarkerEdgeColor', 'magenta');
    hold on;

    % Plot the first vector in blue as a quiver
    %quiver(0, 0, vectors(1, 1), vectors(1, 2), 'Color', 'blue', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

    % Plot the second vector in red as a quiver
    %quiver(0, 0, vectors(2, 1), vectors(2, 2), 'Color', 'red', 'LineWidth', 1.5, 'MaxHeadSize', 0.5);

    % Set axis equal for correct scaling
    axis equal;

    % Add legend for clarity
    %legend({'Point Cloud', 'Basis Vector 1', 'Basis Vector 2'});

    % Display the plot
    hold off;
end