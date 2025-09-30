function plot_subspaces_3D(varargin)
    % This function takes in multiple data matrices and plots all possible
    % 3D projections (subspaces) of each dataset, using a different color
    % for each dataset.
    %
    % Example:
    % plot_subspaces_3D(setosa_data, versicolor_data, virginica_data);

    num_datasets = length(varargin);
    colors = lines(num_datasets); % Generate distinct colors for each dataset

    % Assuming each data matrix has the same number of columns (dimensions)
    num_dimensions = size(varargin{1}, 2);

    % Generate all combinations of 3D subspaces
    triplets = nchoosek(1:num_dimensions, 3);
    num_triplets = size(triplets, 1);

    % Loop over each 3D subspace
    for i = 1:num_triplets
        triplet = triplets(i, :);

        % Create a new figure for each 3D subspace
        figure;
        hold on;
        grid on;
        
        % Track min and max across all datasets for setting axis limits
        xlims = [inf, -inf];
        ylims = [inf, -inf];
        zlims = [inf, -inf];
        
        % Plot each dataset in the current 3D subspace
        for j = 1:num_datasets
            data = varargin{j};
            
            % Check range of values in each dimension to diagnose possible 2D plots
            %range_x = range(data(:, triplet(1)));
            %range_y = range(data(:, triplet(2)));
            %range_z = range(data(:, triplet(3)));
            
            %fprintf('Dataset %d, Subspace [%d %d %d]: Range X = %.2f, Y = %.2f, Z = %.2f\n', ...
            %        j, triplet(1), triplet(2), triplet(3), range_x, range_y, range_z);
            
            scatter3(data(:, triplet(1)), data(:, triplet(2)), data(:, triplet(3)), ...
                36, colors(j, :), 'filled');
            
            % Update axis limits based on data range
            xlims = [min(xlims(1), min(data(:, triplet(1)))), max(xlims(2), max(data(:, triplet(1))))];
            ylims = [min(ylims(1), min(data(:, triplet(2)))), max(ylims(2), max(data(:, triplet(2))))];
            zlims = [min(zlims(1), min(data(:, triplet(3)))), max(zlims(2), max(data(:, triplet(3))))];
        end

        % Set axis labels
        xlabel(['Dimension ', num2str(triplet(1))]);
        ylabel(['Dimension ', num2str(triplet(2))]);
        zlabel(['Dimension ', num2str(triplet(3))]);

        % Set axis limits and enforce 3D view
        xlim(xlims);
        ylim(ylims);
        zlim(zlims);
        view(3); % Force a 3D view

        % Add legend for each dataset
        legend(arrayfun(@(k) ['Dataset ', num2str(k)], 1:num_datasets, 'UniformOutput', false));

        title(['3D Subspace: Dimensions ', num2str(triplet(1)), ', ', num2str(triplet(2)), ', ', num2str(triplet(3))]);
        
        hold off;
    end
end