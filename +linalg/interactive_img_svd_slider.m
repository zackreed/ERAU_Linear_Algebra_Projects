%function to alter SVD of image
function interactive_img_svd_slider(image_matrix, reconstruct_dims)
    % svd_singular_value_slider - Interactive visualization of image reconstruction by adjusting singular values.
    %
    % Syntax: svd_singular_value_slider(image_matrix, reconstruct_dims)
    %
    % Inputs:
    %   image_matrix    - The image matrix to decompose and reconstruct.
    %   reconstruct_dims - Array of singular value indices to control via sliders.
    %
    % Example:
    %   reconstruct_dims = [1, 2, 5, 9, 15];
    %   svd_singular_value_slider(image_matrix, reconstruct_dims);

    % Convert image to double precision for SVD
    image_matrix = double(image_matrix);
    
    % Perform SVD on the image matrix
    [Uim, Sim, Vim] = svd(image_matrix);
    
    % Store the original singular values
    singular_values = diag(Sim);
    num_singular_values = length(singular_values);
    
    % Initialize the adjusted singular values
    adjusted_singular_values = singular_values;
    
    % Default slider range
    default_min = -3000;
    default_max = 3000;
    
    % Create UI figure and layout
    fig = uifigure('Name', 'Singular Vector Scaling', 'NumberTitle', 'off');
    grid = uigridlayout(fig, [1, 2]);
    grid.ColumnWidth = {'2x', '1x'};
    grid.RowHeight = {'1x'};
    
    % Create an axes in the left column for the image
    ax = uiaxes(grid);
    ax.Layout.Row = 1;
    ax.Layout.Column = 1;
    ax.Visible = 'off';  % Hide axes ticks
    
    % Initial reconstruction using all singular values
    approx_image = Uim * Sim * Vim';
    h_img = imshow(uint8(approx_image), 'Parent', ax);
    
    % Create a panel for sliders in the second column
    slider_panel = uipanel(grid, 'Title', 'Adjust Singular Vector Scalar');
    slider_panel.Layout.Row = 1;
    slider_panel.Layout.Column = 2;
    
    % Create a vertical grid layout inside the panel
    num_sliders = length(reconstruct_dims);
    num_rows = num_sliders * 2 + 1; % Each slider and label take 2 rows, plus 1 for the reset button
    slider_grid = uigridlayout(slider_panel, [num_rows, 1]);
    slider_grid.RowHeight = repmat({'fit'}, 1, num_rows);
    slider_grid.Scrollable = 'on';  % Allow scrolling if too many sliders
    
    h_slider = gobjects(num_sliders, 1);
    initial_values = singular_values(reconstruct_dims);
    row_idx = 1;
    
    for i = 1:num_sliders
        singular_index = reconstruct_dims(i);
        initial_value = singular_values(singular_index);
    
        % Print out the initial value of the slider
        fprintf('Initial Coefficient of Singular Vector %d is %.2f\n', singular_index, initial_value);
    
        % Check if initial_value is within default range
        if initial_value >= default_min && initial_value <= default_max
            % Initial value is within default range, use default range
            slider_min = default_min;
            slider_max = default_max;
        else
            % Initial value is outside default range, adjust range
            % Define buffer for slider ranges
            buffer_percentage = 1.5; % Adjust as needed
            min_buffer = 1000;       % Adjust as needed
            buffer = max(abs(initial_value) * buffer_percentage, min_buffer);
            
            % Set slider min and max based on initial value and buffer
            slider_min = initial_value - buffer;
            slider_max = initial_value + buffer;
        end
    
        % Create label
        label = uilabel(slider_grid);
        label.Layout.Row = row_idx;
        label.Layout.Column = 1;
        label.Text = ['Singular Vector ', num2str(singular_index)];
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
    reset_button = uibutton(slider_grid, 'push', 'Text', 'Reset to Singular Values', 'ButtonPushedFcn', @(src, event) reset_singular_values());
    reset_button.Layout.Row = row_idx;
    reset_button.Layout.Column = 1;
    
    % Nested function to update the image when sliders are adjusted
    function update_image()
        % Update the singular values for the controlled indices
        for j = 1:num_sliders
            singular_idx = reconstruct_dims(j);
            adjusted_singular_values(singular_idx) = h_slider(j).Value;
        end
        
        % Reconstruct the image with updated singular values
        Sim_adjusted = diag(adjusted_singular_values);
        % Ensure Sim_adjusted has the correct dimensions
        if size(Sim_adjusted, 1) < size(Uim, 2)
            Sim_adjusted = [Sim_adjusted; zeros(size(Uim, 2) - size(Sim_adjusted, 1), size(Sim_adjusted, 2))];
        end
        if size(Sim_adjusted, 2) < size(Vim, 2)
            Sim_adjusted = [Sim_adjusted, zeros(size(Sim_adjusted, 1), size(Vim, 2) - size(Sim_adjusted, 2))];
        end
        
        approx_image = Uim * Sim_adjusted * Vim';
        
        % Update the displayed image
        set(h_img, 'CData', uint8(approx_image));
        drawnow;
    end

    % Nested function to reset singular values to initial values
    function reset_singular_values()
        for j = 1:num_sliders
            singular_idx = reconstruct_dims(j);
            h_slider(j).Value = singular_values(singular_idx);
            adjusted_singular_values(singular_idx) = singular_values(singular_idx);
        end
        % Reconstruct and update the image
        Sim_adjusted = diag(adjusted_singular_values);
        % Adjust dimensions if necessary
        if size(Sim_adjusted, 1) < size(Uim, 2)
            Sim_adjusted = [Sim_adjusted; zeros(size(Uim, 2) - size(Sim_adjusted, 1), size(Sim_adjusted, 2))];
        end
        if size(Sim_adjusted, 2) < size(Vim, 2)
            Sim_adjusted = [Sim_adjusted, zeros(size(Sim_adjusted, 1), size(Vim, 2) - size(Sim_adjusted, 2))];
        end
        
        approx_image = Uim * Sim_adjusted * Vim';
        set(h_img, 'CData', uint8(approx_image));
        drawnow;
    end
end