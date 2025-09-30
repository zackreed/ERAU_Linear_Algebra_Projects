function conv_animator(smiley, Kernel)
    %turn the matrix into uint8
    smiley=uint8(smiley);
    % Initialize the blurred face matrix
    blurred_face = smiley;
    
    % Get the size of the kernel
    [kRows, kCols] = size(Kernel);
    
    % Calculate the padding size (assuming the kernel is square and has an odd size)
    padSize = floor(kRows / 2);
    
    % Create a figure window and display the initial image
    figure;
    h = imshow(blurred_face, 'InitialMagnification', 2000);
    
    % Set the update interval (number of iterations before updating the display)
    updateInterval = .1; % Adjust this value to speed up or slow down the animation
    
    % Iterate over the smiley matrix with padding considered
    for i = padSize + 1:size(smiley, 2) - padSize
        for j = padSize + 1:size(smiley, 1) - padSize
            % Extract the region of interest
            region = smiley(j - padSize:j + padSize, i - padSize:i + padSize);
            
            % Perform the convolution operation
            blurred_face(j, i) = uint8(sum(sum(Kernel .* double(region))));
            
            % Update the display at intervals
            if mod((i-1)*(size(smiley,1)-2*padSize) + (j-1), updateInterval) == 0
                set(h, 'CData', blurred_face); % Update the image data
                drawnow; % Update the figure window immediately
            end
        end
    end
    
    % Ensure the final state is displayed
    set(h, 'CData', blurred_face);
    drawnow;
end
