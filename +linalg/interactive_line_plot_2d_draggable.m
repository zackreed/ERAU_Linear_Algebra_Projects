function interactive_line_plot_2d_draggable(varargin)
    % Interactive 2D plot where students can drag a center point to move it and a vector tip to rotate the line.
    % The function plots multiple scatter point sets and adjusts the axis to fit them.

    % Check if any scatter point sets are provided
    if isempty(varargin)
        error('At least one set of points must be provided.');
    end

    % Plot each set of points with different colors
    num_point_sets = length(varargin);
    colors = lines(num_point_sets); % Generate distinct colors for each point set
    all_points = [];

    for i = 1:num_point_sets
        current_points = varargin{i};
        if ~ismatrix(current_points) || size(current_points, 2) ~= 2
            error('Each point set must be a matrix with 2 columns for 2D points.');
        end
        scatter(current_points(:, 1), current_points(:, 2), 'MarkerEdgeColor', colors(i, :), 'MarkerFaceColor', colors(i, :));
        hold on;
        all_points = [all_points; current_points]; % Combine all points for axis calculation
    end

    % Set the axis limits to fit all scatter points with 5% padding
    x_min = min(all_points(:, 1));
    x_max = max(all_points(:, 1));
    y_min = min(all_points(:, 2));
    y_max = max(all_points(:, 2));
    axis_limits = [x_min - 0.05 * (x_max - x_min), x_max + 0.05 * (x_max - x_min), ...
                   y_min - 0.05 * (y_max - y_min), y_max + 0.05 * (y_max - y_min)];
    axis(axis_limits);
    grid on;

    % Initial point position at the center of the window
    initial_point = [(x_min + x_max) / 2, (y_min + y_max) / 2];
    initial_angle = 0; % Initial angle in radians
    color = 'black';

    % Calculate the initial line endpoints and red tip position
    vector_length = min((x_max - x_min), (y_max - y_min)) / 4; % Fixed length for the red dot vector
    [line_x, line_y] = calculate_line_points(initial_point, initial_angle, axis_limits);
    [tip_x, tip_y] = calculate_tip_position(initial_point, initial_angle, vector_length, axis_limits);

    % Plot initial elements
    line_handle = plot(line_x, line_y, 'Color', color, 'LineWidth', 1.5);
    point_handle = plot(initial_point(1), initial_point(2), 'ko', 'MarkerSize', 12, 'MarkerFaceColor', 'black', 'ButtonDownFcn', @(src, event) startDragPoint(src, 'center'));
    tip_handle = plot(tip_x, tip_y, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'red', 'ButtonDownFcn', @(src, event) startDragPoint(src, 'tip'));

    % Display current point and unit vector components
    point_text = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.35 0.87 0.3 0.03], ...
        'String', sprintf('Point: (%.2f, %.2f)', initial_point));
    vector_text = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.67 0.87 0.3 0.03], ...
        'String', sprintf('Vector: (%.2f, %.2f)', cos(initial_angle), sin(initial_angle)));

    % Set up drag behavior
    dragging = false;
    drag_type = '';

    function startDragPoint(src, type)
        dragging = true;
        drag_type = type;
        set(gcf, 'WindowButtonMotionFcn', @dragPoint);
        set(gcf, 'WindowButtonUpFcn', @stopDrag);
    end

    function dragPoint(~, ~)
        if ~dragging
            return;
        end
        current_point = get(gca, 'CurrentPoint');
        new_x = current_point(1, 1);
        new_y = current_point(1, 2);

        if strcmp(drag_type, 'center')
            % Update the center point
            initial_point(1) = new_x;
            initial_point(2) = new_y;
            set(point_handle, 'XData', new_x, 'YData', new_y); % Update the visual position
            set(point_text, 'String', sprintf('Point: (%.2f, %.2f)', new_x, new_y));
        elseif strcmp(drag_type, 'tip')
            % Update the angle based on the new tip position
            dx = new_x - initial_point(1);
            dy = new_y - initial_point(2);
            initial_angle = atan2(dy, dx);
            set(vector_text, 'String', sprintf('Vector: (%.2f, %.2f)', cos(initial_angle), sin(initial_angle)));
        end

        % Update the line endpoints and red tip position
        [line_x, line_y] = calculate_line_points(initial_point, initial_angle, axis_limits);
        [tip_x, tip_y] = calculate_tip_position(initial_point, initial_angle, vector_length, axis_limits);

        % Update the plot elements
        set(line_handle, 'XData', line_x, 'YData', line_y);
        set(tip_handle, 'XData', tip_x, 'YData', tip_y);
    end

    function stopDrag(~, ~)
        dragging = false;
        set(gcf, 'WindowButtonMotionFcn', '');
        set(gcf, 'WindowButtonUpFcn', '');
    end

    % Function to calculate the line points based on axis bounds
    function [line_x, line_y] = calculate_line_points(point, angle, limits)
        % Unpack axis limits
        x_min = limits(1);
        x_max = limits(2);
        y_min = limits(3);
        y_max = limits(4);

        % Direction vector components
        dx = cos(angle);
        dy = sin(angle);

        % Parameterize the line as x(t) = point(1) + t * dx, y(t) = point(2) + t * dy
        t_values = [...
            (x_min - point(1)) / dx, (x_max - point(1)) / dx, ...
            (y_min - point(2)) / dy, (y_max - point(2)) / dy];
        t_values = t_values(isfinite(t_values));

        t_min = min(t_values);
        t_max = max(t_values);

        line_x = [point(1) + t_min * dx, point(1) + t_max * dx];
        line_y = [point(2) + t_min * dy, point(2) + t_max * dy];
    end

    % Function to calculate the red tip position
    function [tip_x, tip_y] = calculate_tip_position(point, angle, length, limits)
        tip_x = point(1) + length * cos(angle);
        tip_y = point(2) + length * sin(angle);

        % Clamp the tip position to stay within plot bounds
        tip_x = max(limits(1), min(tip_x, limits(2)));
        tip_y = max(limits(3), min(tip_y, limits(4)));
    end
end