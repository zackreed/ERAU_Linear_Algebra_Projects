function interactive_img_slider(image_vector, dims)
    % Ensure image_vector is a row vector
    if iscolumn(image_vector)
        image_vector = image_vector';
    end

    % Validate dims
    if any(dims > numel(image_vector)) || any(dims < 1)
        error('All values in dims must be valid indices within the range of image_vector.');
    end

    % Clip pixel values to the slider range [0, 255]
    image_vector = max(0, min(255, image_vector));

    % Dynamically compute the side length of the square image
    side_length = sqrt(length(image_vector));
    if mod(side_length, 1) ~= 0
        error('Input vector length must be a perfect square.');
    end
    side_length = round(side_length);

    % Reshape the image vector into a square matrix
    approx_face = image_vector;
    approx_image = reshape(approx_face, side_length, side_length);

    % Create UI figure and layout
    fig = uifigure('Name', 'Interactive Image Slider', 'NumberTitle', 'off');
    grid = uigridlayout(fig, [1, 2]);
    grid.ColumnWidth = {'2x', '1x'};
    grid.RowHeight = {'1x'};

    % Create an axes in the left column for the image
    ax = uiaxes(grid);
    ax.Layout.Row = 1;
    ax.Layout.Column = 1;
    ax.Visible = 'off';  % Hide axes ticks
    h_img = imshow(uint8(approx_image), 'Parent', ax);

    % Create a panel for sliders in the second column
    slider_panel = uipanel(grid, 'Title', 'Adjust Coordinate Values (Pixels)');
    slider_panel.Layout.Row = 1;
    slider_panel.Layout.Column = 2;

    % Create a vertical grid layout inside the panel
    num_sliders = length(dims);
    slider_grid = uigridlayout(slider_panel, [num_sliders * 2 + 1, 1]); % Each slider takes 2 rows
    slider_grid.RowHeight = repmat({'fit'}, 1, num_sliders * 2 + 1);
    slider_grid.Scrollable = 'on';  % Allow scrolling if too many sliders

    h_slider = gobjects(num_sliders, 1);
    initial_values = zeros(num_sliders, 1);

    for i = 1:num_sliders
        pixel_idx = dims(i);
    
        % Ensure pixel_idx is valid
        assert(pixel_idx >= 1 && pixel_idx <= numel(image_vector), 'Invalid pixel index: %d', pixel_idx);
    
        % Get initial value and ensure it's a valid scalar within [0, 255]
        initial_value = double(image_vector(pixel_idx)); % Convert to double
        fprintf('Pixel %d: Initial value = %f\n', pixel_idx, initial_value); % Debug info
    
        % Clip initial_value to slider range if necessary
        initial_value = max(0, min(255, initial_value));
    
        % Create label
        label = uilabel(slider_grid);
        label.Layout.Row = 2 * i - 1;
        label.Layout.Column = 1;
        label.Text = ['Pixel ', num2str(pixel_idx)];
        label.HorizontalAlignment = 'center';
    
        % Create slider
        h_slider(i) = uislider(slider_grid);
        h_slider(i).Layout.Row = 2 * i;
        h_slider(i).Layout.Column = 1;
        h_slider(i).Limits = [0, 255];
        h_slider(i).Value = initial_value; % Initialize slider value
        h_slider(i).ValueChangedFcn = @(src, event) update_image();
    end

    % Create reset button
    reset_button = uibutton(slider_grid, 'push', 'Text', 'Reset Pixels', 'ButtonPushedFcn', @(src, event) reset_sliders());
    reset_button.Layout.Row = num_sliders * 2 + 1;
    reset_button.Layout.Column = 1;

    % Nested function to update the image when sliders are adjusted
    function update_image()
        % Update the pixel values at specified indices
        for j = 1:num_sliders
            pixel_idx = dims(j);
            approx_face(pixel_idx) = h_slider(j).Value;
        end

        % Reshape the image vector into a square image
        approx_image = reshape(approx_face, side_length, side_length);

        % Update the displayed image
        set(h_img, 'CData', uint8(approx_image));
        drawnow;
    end

    % Nested function to reset sliders to initial values
    function reset_sliders()
        for j = 1:num_sliders
            h_slider(j).Value = initial_values(j);
            approx_face(dims(j)) = initial_values(j);
        end

        % Update the image after resetting sliders
        approx_image = reshape(approx_face, side_length, side_length);
        set(h_img, 'CData', uint8(approx_image));
        drawnow;
    end
end