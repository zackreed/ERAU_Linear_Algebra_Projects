function plot_img_quiver(points)
    % Input:
    % - points: Nx2 matrix where each row represents the endpoint of a vector
    % All vectors will originate from the origin [0, 0]
    
    % Origin for all vectors (center point)
    origin_x = zeros(size(points,1), 1); % Starting x coordinate for all vectors
    origin_y = zeros(size(points,1), 1); % Starting y coordinate for all vectors
    
    % Create a quiver plot with all vectors originating from the origin
    quiver(origin_x, origin_y, points(:,1), points(:,2), 0, 'Color', 'magenta');
    
    hold on;

    % Set axis equal for correct scaling
    axis equal;

    % Add labels for clarity (optional)
    xlabel('X-axis');
    ylabel('Y-axis');
    title('Quiver plot of vectors originating from the origin');
    
    % Display the plot
    hold off;
end