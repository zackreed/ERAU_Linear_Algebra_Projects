function quiver_handles = simple_plot_quiver(varargin)
    % simple_plot_quiver plots multiple sets of 2D or 3D vectors starting at the origin.
    %
    % Inputs:
    %   Each input argument is a matrix where each row represents a vector [dx, dy] (2D) or [dx, dy, dz] (3D).
    %   Optional color strings can be provided as separate inputs after each dataset.
    %
    % Output:
    %   quiver_handles - Array of handles to the plotted quivers.

    % Set up color options
    default_colors = lines(nargin); % Automatically generate distinct colors
    quiver_handles = gobjects(1, nargin); % Initialize array to store plot handles

    % Determine if input is 2D or 3D based on the first dataset
    first_vectors = varargin{1}';
    dim = size(first_vectors, 2); % Number of columns determines 2D or 3D

    % Validate dimensionality
    if dim == 2
        is_3D = false;
    elseif dim == 3
        is_3D = true;
    else
        error('Input datasets must be 2D or 3D (size [N x 2] or [N x 3]).');
    end

    % Loop through datasets
    i = 1; % Counter for the input arguments
    dataset_index = 1; % Counter for datasets
    while i <= nargin
        vectors = varargin{i}';
        i = i + 1; % Move to the next argument

        % Validate that all datasets have consistent dimensionality
        if size(vectors, 2) ~= dim
            error('All datasets must have the same dimensionality (2D or 3D).');
        end

        % Determine color
        if i <= nargin && ischar(varargin{i})
            color = varargin{i}';
            i = i + 1; % Skip over the color input
        else
            color = default_colors(dataset_index, :); % Assign automatically generated color
        end

        % Extract components for quiver plot
        if is_3D
            % 3D vectors
            x = zeros(size(vectors, 1), 1); % Starting points for x
            y = zeros(size(vectors, 1), 1); % Starting points for y
            z = zeros(size(vectors, 1), 1); % Starting points for z
            u = vectors(:, 1); % x-components of the vectors
            v = vectors(:, 2); % y-components of the vectors
            w = vectors(:, 3); % z-components of the vectors

            % Plot the 3D quivers
            quiver_handles(dataset_index) = quiver3(x, y, z, u, v, w, 0, ...
                'Color', color, 'LineWidth', 1.5);
        else
            % 2D vectors
            x = zeros(size(vectors, 1), 1); % Starting points for x
            y = zeros(size(vectors, 1), 1); % Starting points for y
            u = vectors(:, 1); % x-components of the vectors
            v = vectors(:, 2); % y-components of the vectors

            % Plot the 2D quivers
            quiver_handles(dataset_index) = quiver(x, y, u, v, 0, ...
                'Color', color, 'LineWidth', 1.5);
        end

        hold on; % Keep plot open for additional datasets
        dataset_index = dataset_index + 1; % Move to the next dataset
    end

    % Set up labels and grid
    if is_3D
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        title('3D Vectors');
    else
        xlabel('X-axis');
        ylabel('Y-axis');
        title('2D Vectors');
    end

    grid on;
    hold off;
end
