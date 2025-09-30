function surf_handle = simple_plot_plane(x_range, y_range, point, normal, color)
    % plot_plane plots a plane given a point and a normal vector within specified x and y ranges.
    % 
    % Inputs:
    %   x_range - A vector [xmin, xmax] specifying the x-axis range.
    %   y_range - A vector [ymin, ymax] specifying the y-axis range.
    %   point   - A vector [x0, y0, z0] representing a point on the plane.
    %   normal  - A vector [a, b, c] representing the normal to the plane.
    %   color   - (Optional) A string specifying the color of the plane. Defaults to 'blue'.
    % 
    % Output:
    %   surf_handle - Handle to the plotted surface.

    % Set default color if not provided
    if nargin < 5
        color = 'blue';
    end

    % Create a grid of x and y values based on the input ranges
    [x, y] = meshgrid(x_range(1):1:x_range(2), y_range(1):1:y_range(2));

    % Calculate d from the plane equation ax + by + cz = d
    d = dot(normal, point);

    % Calculate the z values for the plane
    z = (d - normal(1) * x - normal(2) * y) / normal(3);

    % Plot the plane with the specified color and return the handle
    surf_handle = surf(x, y, z, 'FaceColor', color);
end
