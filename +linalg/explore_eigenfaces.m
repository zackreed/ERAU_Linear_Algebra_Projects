function explore_eigenfaces(eigen_dims, mat_filename)
    % explore_eigenfaces - Interactive exploration of eigenfaces
    %
    % Syntax: explore_eigenfaces(eigen_dims, mat_filename)
    %
    % Inputs:
    %   eigen_dims   - Array of eigenvector indices to control via sliders
    %   mat_filename - Name of the .mat file containing U, S, V, mean_face
    %
    % Example:
    %   eigen_dims = [1, 2, 5, 9, 15];
    %   explore_eigenfaces(eigen_dims, 'img_svd.mat');

    % Load U, S, V, mean_face from the specified .mat file
    data = load(mat_filename, 'U', 'S', 'V', 'mean_face');
    V = data.V;
    mean_face = data.mean_face;

    % Ensure mean_face is a column vector
    if isrow(mean_face)
        mean_face = mean_face';
    end

    % Number of eigenvectors (dimensions of eigenspace)
    N = size(V, 2);

    % Initialize the projections (coefficients) to zero
    projections = zeros(N, 1);

    % Store the initial projections for resetting (all zeros)
    initial_projections = projections;

    % Initial reconstruction is the mean face
    approx_face = reshape(mean_face, 64, 64);

    % Create UI figure and layout
    fig = uifigure('Name', 'Explore Eigenfaces', 'NumberTitle', 'off');
    grid = uigridlayout(fig, [1, 2]);
    grid.ColumnWidth = {'2x', '1x'};
    grid.RowHeight = {'1x'};

    % Create an axes in the left column for the image
    ax = uiaxes(grid);
    ax.Layout.Row = 1;
    ax.Layout.Column = 1;
    ax.Visible = 'off';  % Hide axes ticks
    h_img = imshow(uint8(approx_face), 'Parent', ax);

    % Create a panel for sliders in the second column
    slider_panel = uipanel(grid, 'Title', 'Adjust Eigenface Scalars');
    slider_panel.Layout.Row = 1;
    slider_panel.Layout.Column = 2;

    % Create a vertical grid layout inside the panel
    num_sliders = length(eigen_dims);
    num_rows = num_sliders * 2 + 1; % Each slider and label take 2 rows, plus 1 for the reset button

    slider_grid = uigridlayout(slider_panel, [num_rows, 1]);
    slider_grid.RowHeight = repmat({'fit'}, 1, num_rows);
    slider_grid.Scrollable = 'on';  % Allow scrolling if too many sliders

    h_slider = gobjects(num_sliders, 1);
    row_idx = 1;

    % Default slider range
    default_min = -4000;
    default_max = 4000;

    for i = 1:num_sliders
        eigen_index = eigen_dims(i);

        % Initial value is zero
        initial_value = 0;

        % Set slider min and max based on default range
        slider_min = default_min;
        slider_max = default_max;

        % Create label
        label = uilabel(slider_grid);
        label.Layout.Row = row_idx;
        label.Layout.Column = 1;
        label.Text = ['Eigenface ', num2str(eigen_index)];
        label.HorizontalAlignment = 'center';
        row_idx = row_idx + 1;

        % Create slider
        h_slider(i) = uislider(slider_grid);
        h_slider(i).Layout.Row = row_idx;
        h_slider(i).Layout.Column = 1;
        h_slider(i).Limits = [slider_min, slider_max];
        h_slider(i).Value = initial_value;
        h_slider(i).ValueChangedFcn = @(src, event) update_image();
        row_idx = row_idx + 1;
    end

    % Create reset button
    reset_button = uibutton(slider_grid, 'push', 'Text', 'Reset to Zero', 'ButtonPushedFcn', @(src, event) reset_sliders());
    reset_button.Layout.Row = row_idx;
    reset_button.Layout.Column = 1;

    % Nested function to update the image when sliders are adjusted
    function update_image()
        % Update the projections for the controlled eigenvectors
        for j = 1:num_sliders
            eigen_idx = eigen_dims(j);
            projections(eigen_idx) = h_slider(j).Value;
        end

        % Reconstruct the image with updated projections
        eigen_contributions = V(:, eigen_dims) * projections(eigen_dims);
        approx_face = reshape(mean_face + eigen_contributions, 64, 64);

        % Update the displayed image
        set(h_img, 'CData', uint8(approx_face));
        drawnow;
    end

    % Nested function to reset sliders to initial values
    function reset_sliders()
        for j = 1:num_sliders
            eigen_idx = eigen_dims(j);
            h_slider(j).Value = initial_projections(eigen_idx);
            projections(eigen_idx) = initial_projections(eigen_idx);
        end
        % Update the image after resetting sliders
        update_image();
    end
end