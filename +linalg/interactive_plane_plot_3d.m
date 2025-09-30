function interactive_plane_plot_3d(varargin)
    % Interactive 3D plot with sliders for point and plane rotation components.
    % This function plots multiple 3D scatter point sets and adjusts the axis to fit them.
    % It also updates interactively with sliders for point position and plane rotation.

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
        if ~ismatrix(current_points) || size(current_points, 2) ~= 3
            error('Each point set must be a matrix with 3 columns for 3D points.');
        end
        scatter3(current_points(:, 1), current_points(:, 2), current_points(:, 3), 'MarkerEdgeColor', colors(i, :), 'MarkerFaceColor', colors(i, :));
        hold on;
        all_points = [all_points; current_points]; % Combine all points for axis calculation
    end

    % Set the axis limits to fit all scatter points with 5% padding
    x_min = min(all_points(:, 1));
    x_max = max(all_points(:, 1));
    y_min = min(all_points(:, 2));
    y_max = max(all_points(:, 2));
    z_min = min(all_points(:, 3));
    z_max = max(all_points(:, 3));
    x_range = [x_min - 0.05 * (x_max - x_min), x_max + 0.05 * (x_max - x_min)];
    y_range = [y_min - 0.05 * (y_max - y_min), y_max + 0.05 * (y_max - y_min)];
    z_range = [z_min - 0.05 * (z_max - z_min), z_max + 0.05 * (z_max - z_min)];
    axis([x_range y_range z_range]);
    grid on;

    % Initial point position at the center of the window
    initial_point = [(x_min + x_max) / 2, (y_min + y_max) / 2, (z_min + z_max) / 2];
    initial_vertical_angle = 0; % Initial vertical rotation angle (elevation)
    initial_horizontal_angle = 0; % Initial horizontal rotation angle (azimuth)

    % Define initial plane size (2/3 of x and y range)
    plane_size_x = (x_max - x_min) * 2/3;
    plane_size_y = (y_max - y_min) * 2/3;

    % Create initial plane data
    [X, Y] = meshgrid(linspace(-plane_size_x/2, plane_size_x/2, 20), linspace(-plane_size_y/2, plane_size_y/2, 20));
    Z = zeros(size(X));

    % Plot the initial plane
    plane_handle = surf(X + initial_point(1), Y + initial_point(2), Z + initial_point(3), 'FaceAlpha', 0.5, 'EdgeColor', 'none');

    % Plot the initial point
    point_handle = plot3(initial_point(1), initial_point(2), initial_point(3), 'ko', 'MarkerFaceColor', 'k');

    % Plot the initial normal vector
    quiver_handle = quiver3(initial_point(1), initial_point(2), initial_point(3), 0,0,1, 'k', 'LineWidth', 2);

    % Display current point and normal vector components
    point_text = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.68 0.83 0.3 0.03], ...
        'String', sprintf('Point: (%.2f, %.2f, %.2f)', initial_point));
    normal_vector_text = uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.35 0.83 0.3 0.03], ...
        'String', sprintf('Normal Vector: (0, 0, 1)'));

    % Create sliders for x, y, z components of the point
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.02 0.91 0.1 0.03], 'String', 'Point X');
    point_x_slider = uicontrol('Style', 'slider', 'Units', 'normalized', 'Min', x_range(1), 'Max', x_range(2), 'Value', initial_point(1), ...
        'Position', [0.12 0.91 0.2 0.03], 'Callback', @(src, event) update_plot());

    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.02 0.87 0.1 0.03], 'String', 'Point Y');
    point_y_slider = uicontrol('Style', 'slider', 'Units', 'normalized', 'Min', y_range(1), 'Max', y_range(2), 'Value', initial_point(2), ...
        'Position', [0.12 0.87 0.2 0.03], 'Callback', @(src, event) update_plot());

    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.02 0.83 0.1 0.03], 'String', 'Point Z');
    point_z_slider = uicontrol('Style', 'slider', 'Units', 'normalized', 'Min', z_range(1), 'Max', z_range(2), 'Value', initial_point(3), ...
        'Position', [0.12 0.83 0.2 0.03], 'Callback', @(src, event) update_plot());

    % Create sliders for vertical and horizontal rotation angles
    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.35 0.91 0.15 0.03], 'String', 'Vertical Rotation');
    vertical_rotation_slider = uicontrol('Style', 'slider', 'Units', 'normalized', 'Min', -pi/2, 'Max', pi/2, 'Value', 0, ...
        'Position', [0.5 0.91 0.4 0.03], 'Callback', @(src, event) update_plot());

    uicontrol('Style', 'text', 'Units', 'normalized', 'Position', [0.35 0.87 0.15 0.03], 'String', 'Horizontal Rotation');
    horizontal_rotation_slider = uicontrol('Style', 'slider', 'Units', 'normalized', 'Min', -pi, 'Max', pi, 'Value', 0, ...
        'Position', [0.5 0.87 0.4 0.03], 'Callback', @(src, event) update_plot());

    % Callback function to update the plot based on slider values
    function update_plot()
        % Get current values from the sliders
        point_x = get(point_x_slider, 'Value');
        point_y = get(point_y_slider, 'Value');
        point_z = get(point_z_slider, 'Value');
        vertical_angle = get(vertical_rotation_slider, 'Value');
        horizontal_angle = get(horizontal_rotation_slider, 'Value');

        % Update point display
        set(point_text, 'String', sprintf('Point: (%.2f, %.2f, %.2f)', point_x, point_y, point_z));

        % Calculate the normal vector based on the rotation angles
        %normal_x = cos(vertical_angle) * cos(horizontal_angle);
        %normal_y = cos(vertical_angle) * sin(horizontal_angle);
        %normal_z = sin(vertical_angle);
        %set(normal_vector_text, 'String', sprintf('Normal Vector: (%.2f, %.2f, %.2f)', normal_x, normal_y, normal_z));

        % Rotate the plane
        [X, Y, Z] = calculate_rotated_plane([point_x, point_y, point_z], plane_size_x, plane_size_y, vertical_angle, horizontal_angle);

        % Update the plane plot
        delete(plane_handle);
        plane_handle = surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

        % Update the point plot
        set(point_handle, 'XData', point_x, 'YData', point_y, 'ZData', point_z);

        % Update the normal vector plot
        %delete(quiver_handle);
        %quiver_handle = quiver3(point_x, point_y, point_z, normal_x, normal_y, normal_z, ...
                                %'k', 'LineWidth', 2, 'MaxHeadSize', 0.5);
        % Pick two consistent points from the plane grid (e.g., top-left and top-right corners)
        point1 = [X(1, 1), Y(1, 1), Z(1, 1)];
        point2 = [X(1, end), Y(1, end), Z(1, end)];

        % Center the points by subtracting the center point
        centered_point1 = point1 - [point_x, point_y, point_z];
        centered_point2 = point2 - [point_x, point_y, point_z];

        % Calculate the cross product to find the normal vector
        normal_vector = cross(centered_point1, centered_point2);

        % Ensure the normal vector points upward by checking its orientation
        if normal_vector(3) < 0
            normal_vector = -normal_vector; % Flip direction if pointing downward
        end

        normal_vector=normal_vector/2;

        % Normalize the normal vector to make it a unit vector
        normal_unit = normal_vector / norm(normal_vector);

        % Update the normal vector text display
        set(normal_vector_text, 'String', sprintf('Normal Vector: (%.2f, %.2f, %.2f)', normal_unit));

        % Update the quiver plot with the scaled normal vector
        delete(quiver_handle);
        quiver_handle = quiver3(point_x, point_y, point_z, ...
                                normal_vector(1), normal_vector(2), normal_vector(3), ...
                                'k', 'LineWidth', 2, 'MaxHeadSize', 0.5);
    end

    % Function to calculate rotated plane data
    function [X, Y, Z] = calculate_rotated_plane(center, size_x, size_y, vert_angle, horiz_angle)
        [X, Y] = meshgrid(linspace(-size_x/2, size_x/2, 20), linspace(-size_y/2, size_y/2, 20));
        Z = zeros(size(X));
        % Create rotation matrices
        Rz = [cos(horiz_angle), -sin(horiz_angle), 0; sin(horiz_angle), cos(horiz_angle), 0; 0, 0, 1];
        Ry = [cos(vert_angle), 0, sin(vert_angle); 0, 1, 0; -sin(vert_angle), 0, cos(vert_angle)];
        Rx = [1, 0, 0; 0, cos(vert_angle), -sin(vert_angle); 0, sin(vert_angle), cos(vert_angle)];
        
        % Combine rotations (e.g., Z -> Y -> X)
        rotation_matrix = Rz * Ry * Rx;
        
        % Rotate the plane points
        for i = 1:numel(X)
            rotated_point = rotation_matrix * [X(i); Y(i); Z(i)];
            X(i) = rotated_point(1) + center(1);
            Y(i) = rotated_point(2) + center(2);
            Z(i) = rotated_point(3) + center(3);
        end
    end
end