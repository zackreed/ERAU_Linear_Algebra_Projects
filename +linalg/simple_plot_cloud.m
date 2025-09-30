function cloud_handles = simple_plot_cloud(varargin)
    % simple_plot_cloud plots multiple sets of 2D or 3D points with distinct colors.
    %
    % Inputs:
    %   Each input argument is a matrix where each row represents a point [x, y] (2D) or [x, y, z] (3D).
    %   Optional color strings can be provided as separate inputs after each dataset.
    %
    % Output:
    %   cloud_handles - Array of handles to the plotted point sets.

    % Set up color options
    default_colors = lines(nargin); % Automatically generate a distinct color for each input
    cloud_handles = gobjects(1, nargin); % Initialize array to store plot handles

    % Loop through datasets
    i = 1; % Counter for the input arguments
    dataset_index = 1; % Counter for datasets
    is_3D = NaN; % Flag to track if we're plotting 2D or 3D (initialize as unknown)

    while i <= nargin
        points = varargin{i}';
        i = i + 1; % Move to the next argument

        % Validate the input dimensions
        [num_rows, num_cols] = size(points);
        if num_cols ~= 2 && num_cols ~= 3
            error('Input dataset must have 2 or 3 rows (2D: [x; y] or 3D: [x; y; z]).');
        end

        % Determine if the input is 2D or 3D and ensure consistency
        if isnan(is_3D)
            % First dataset determines whether we plot in 2D or 3D
            is_3D = (num_cols == 3);
        elseif is_3D ~= (num_cols == 3)
            error('All datasets must be either 2D or 3D. Mixing is not allowed.');
        end

        % Determine color
        if i <= nargin && ischar(varargin{i})
            color = varargin{i};
            i = i + 1; % Skip over the color input
        else
            color = default_colors(dataset_index, :); % Assign automatically generated color
        end

        % Plot points
        if is_3D
            % 3D scatter plot
            cloud_handles(dataset_index) = scatter3(points(:, 1), points(:, 2), points(:, 3), ...
                'MarkerEdgeColor', color, 'MarkerFaceColor', color);
        else
            % 2D scatter plot
            cloud_handles(dataset_index) = scatter(points(:, 1), points(:, 2), ...
                'MarkerEdgeColor', color, 'MarkerFaceColor', color);
        end

        hold on; % Keep plot open for additional datasets
        dataset_index = dataset_index + 1; % Move to the next dataset
    end

    % Set up labels and grid
    if is_3D
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        %title('3D Point Clouds');
    else
        xlabel('X-axis');
        ylabel('Y-axis');
        %title('2D Point Clouds');
    end

    grid on;
    hold off;
end
