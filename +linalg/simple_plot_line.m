function line_handle = simple_plot_line(point, vector, data, color)
    % simple_plot_line plots a line defined by a point and a direction vector in 2D or 3D.
    %
    % Inputs:
    %   point   - A vector [x0, y0] or [x0, y0, z0] representing a point on the line.
    %   vector  - A vector [vx, vy] or [vx, vy, vz] representing the direction of the line.
    %   data    - (Optional) Data points (Nx2 or Nx3 matrix) to determine the plot range.
    %   color   - (Optional) A string specifying the color of the line. Defaults to 'magenta'.
    %
    % Output:
    %   line_handle - Handle to the plotted line.

    % Set default color if not provided
    if nargin < 4
        color = 'magenta';
    end

    % Determine if the line is 2D or 3D based on the length of the input vectors
    if length(point) == 2 && length(vector) == 2
        % 2D Line
        if nargin >= 3 && ~isempty(data)
            % Determine range from the data
            xmin = min(data(:, 1));
            xmax = max(data(:, 1));
        else
            % Default range for 2D
            xmin = -10;
            xmax = 10;
        end

        % Generate points for the line
        x = linspace(xmin, xmax, 100);
        t = (x - point(1)) / vector(1);
        y = point(2) + t * vector(2);

        % Plot the line in 2D
        line_handle = plot(x, y, 'Color', color, 'LineWidth', 2);

    elseif length(point) == 3 && length(vector) == 3
        % 3D Line
        if nargin >= 3 && ~isempty(data)
            % Determine range from the data
            xmin = min(data(:, 1));
            xmax = max(data(:, 1));
        else
            % Default range for 3D: the square at the origin
            xmin = -10;
            xmax = 10;
        end

        % Generate points for the line
        x = linspace(xmin, xmax, 100);
        t = (x - point(1)) / vector(1);
        y = point(2) + t * vector(2);
        z = point(3) + t * vector(3);

        % Plot the line in 3D
        line_handle = plot3(x, y, z, 'Color', color, 'LineWidth', 2);

    else
        error('Input point and vector must both be either 2D or 3D vectors.');
    end

    % Add grid and labels
    grid on;
    if length(point) == 2
        xlabel('X-axis');
        ylabel('Y-axis');
        title('2D Line');
    elseif length(point) == 3
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        title('3D Line');
    end
end
