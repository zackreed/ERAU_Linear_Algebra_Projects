% Function to plot point cloud and unit vectors as quiver arrows
function plot_cloud_with_vectors(points)
    points=points';
    % Plot the point cloud (first n-3 entries)
    scatter3(points(1:end-3,1), points(1:end-3,2), points(1:end-3,3), 1, 'b', 'filled');
    hold on;
    
    colors = {'b', 'r', 'y'};  % Blue, Red, Yellow
    quiverHandles = gobjects(1, 3);  % Initialize array to store handles for quivers
    labels = cell(1, 3);  % Initialize labels array

    for i = 1:3
        % Extract the vector values for the current vector
        vector_value = points(end-3+i, :);
        
        % Plot the vector with the desired color and store the handle
        quiverHandles(i) = quiver3(0, 0, 0, vector_value(1), vector_value(2), vector_value(3), 'LineWidth', 2, 'Color', colors{i});
        
        % Create a label with the actual vector values
        labels{i} = sprintf('Basis Vector %d: (%.2f, %.2f, %.2f)', i, vector_value(1), vector_value(2), vector_value(3));
    end
    hold off;
    
    % Set axis labels for clarity
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title('Cloud Plot with Basis Vectors');
    grid on;
    axis equal;
    
    % Add the legend, referencing the handles to link colors with labels
    legend(quiverHandles, labels, 'Location', 'bestoutside');
end