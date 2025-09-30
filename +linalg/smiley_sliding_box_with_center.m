function sliding_box_with_center(smiley, kernel, updateInterval)
    % Initialize the slider matrix
    smiley = uint8(smiley);
    slider=smiley;
    Kernel=kernel
    
    % Create a figure window and display the initial image
    figure;
    h = imshow(smiley,'InitialMagnification',2000);
    
    % Get the size of the smiley matrix
    [rows, cols] = size(smiley);
    
    % Calculate the padding size (assuming the black box is 3x3)
    padSize = 1;
    
    % Convert the updateInterval to an integer step interval
    stepInterval = round(1 / updateInterval);
    
    % Iterate over the smiley matrix with padding considered
    for i = padSize + 1:cols - padSize
        for j = padSize + 1:rows - padSize
            region=slider(j-1:j+1,i-1:i+1);
            % Set the region to black
            slider(j - padSize:j + padSize, i - padSize:i + padSize) = 0;
            %Set the middle to the average from the kernel
            slider(j,i)=uint8(sum(sum(Kernel.*double(region))));
            
            % Update the display at intervals
            if mod((i-1)*(rows-2*padSize) + (j-1), stepInterval) == 0
                set(h, 'CData', slider); % Update the image data
                drawnow; % Update the figure window immediately
            end
            
            % Reset the slider matrix to the original smiley matrix
            slider = smiley;
        end
    end
end
