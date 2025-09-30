function plot_cloud(points)

    points=points'
    % Plot the point cloud (first n-3 entries)
    scatter3(points(:,1), points(:,2), points(:,3));

    % Set axis properties and labels
    axis equal;
    xlabel('X axis');
    ylabel('Y axis');
    zlabel('Z axis');
    title('Point Cloud');
    
    % Show grid
    grid on;
end
