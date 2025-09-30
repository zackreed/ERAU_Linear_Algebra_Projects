function point_handle = simple_plot_points(points, color)
    % simple_plot_points plots a set of 2D points with an optional color input.
    % 
    % Inputs:
    %   points - A matrix where each row is a point [x, y].
    %   color  - (Optional) A string specifying the color of the points. Defaults to 'magenta'.
    % 
    % Output:
    %   point_handle - Handle to the plotted points.

    % Set default color if not provided
    if nargin < 2
        color = 'magenta';
    end

    points = points';

    % Plot points with the specified or default color
    point_handle = scatter(points(:, 1), points(:, 2), 'MarkerEdgeColor', color, 'MarkerFaceColor', color);
end
