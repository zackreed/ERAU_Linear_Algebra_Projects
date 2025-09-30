function plot_handle = start_simple_plot(initial_point)
    % start_simple_plot initializes a plot and chooses between 2D and 3D plotting.
    % If initial_point is 2D, it calls simple_plot_points.
    % If initial_point is 3D, it calls simple_plot_cloud.
    % 
    % Inputs:
    %   initial_point - A vector representing the point to be plotted.
    % 
    % Output:
    %   plot_handle - Handle to the plot.

    initial_point=initial_point';

    % Determine if the initial_point is 2D or 3D
    if length(initial_point) == 2
        % 2D point
        figure;
        plot_handle = linalg.simple_plot_points(initial_point,'blue');
    elseif length(initial_point) == 3
        % 3D point
        figure;
        plot_handle = linalg.simple_plot_cloud(initial_point,'blue');
    else
        error('initial_point must be a 2D or 3D vector.');
    end

    hold on;
end
