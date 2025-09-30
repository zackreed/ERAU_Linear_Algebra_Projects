function plot_img_points(points)

    points=points';
    % Adjust the size of the points by setting 'SizeData' (e.g., 10 for smaller points)
    scatter(points(:,1), points(:,2), 10, 'MarkerEdgeColor', 'magenta');  % '10' is the marker size
    
    hold on;

    % Set axis equal for correct scaling
    axis equal;

    % Add legend for clarity (if needed)
    % legend({'Point Cloud', 'Basis Vector 1', 'Basis Vector 2'});

    % Display the plot
    hold off;
end