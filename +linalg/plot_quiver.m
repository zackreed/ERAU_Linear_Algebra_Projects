function plot_quiver(points)
    % Input:
    % - points: Nx2 or Nx3 matrix where each row represents the endpoint of a vector
    % All vectors will originate from the origin [0, 0, 0]

    points=points';

    % make zeros for base points
    origins = zeros(size(points, 1), size(points, 2));

    dim = size(points, 2);
    
    % Define wiggle room percentage for axis boundaries
    margin_factor = 0.1;

    figure;
    if dim == 2
        % Create a quiver plot with all vectors originating from the origin
        quiver(origins(:,1), origins(:,2), points(:,1), points(:,2));

        % Calculate axis limits with wiggle room
        x_min = min(points(:,1)) - margin_factor * range(points(:,1));
        x_max = max(points(:,1)) + margin_factor * range(points(:,1));
        y_min = min(points(:,2)) - margin_factor * range(points(:,2));
        y_max = max(points(:,2)) + margin_factor * range(points(:,2));

        % Set axis limits
        xlim([x_min, x_max]);
        ylim([y_min, y_max]);

    elseif dim == 3
        % Create a 3D quiver plot with all vectors originating from the origin
        quiver3(origins(:,1), origins(:,2), origins(:,3), points(:,1), points(:,2), points(:,3));

        % Calculate axis limits with wiggle room for 3D case
        x_min = min(points(:,1)) - margin_factor * range(points(:,1));
        x_max = max(points(:,1)) + margin_factor * range(points(:,1));
        y_min = min(points(:,2)) - margin_factor * range(points(:,2));
        y_max = max(points(:,2)) + margin_factor * range(points(:,2));
        z_min = min(points(:,3)) - margin_factor * range(points(:,3));
        z_max = max(points(:,3)) + margin_factor * range(points(:,3));

        % Set axis limits
        xlim([x_min, x_max]);
        ylim([y_min, y_max]);
        zlim([z_min, z_max]);

    else
        fprintf('Vectors must be 2 or 3 dimensional.\n');
    end

    % Set axis equal for correct scaling
    axis equal;

    % Add labels for clarity
    xlabel('X-axis');
    ylabel('Y-axis');
    if dim == 3
        zlabel('Z-axis');
    end
    title('Quiver plot of vectors originating from the origin');
end