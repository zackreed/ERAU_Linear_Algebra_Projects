function plot_subspaces_2D(varargin)
    % This function takes in multiple data matrices and plots all possible
    % 2D projections (subspaces) of each dataset, using a different color
    % for each dataset.
    %
    % Example:
    % plot_subspaces_2D(setosa_data, versicolor_data, virginica_data);

    num_datasets = length(varargin);
    colors = lines(num_datasets); % Generate distinct colors for each dataset

    % Assuming each data matrix has the same number of columns (dimensions)
    num_dimensions = size(varargin{1}, 2);

    % Generate all combinations of 2D subspaces
    pairs = nchoosek(1:num_dimensions, 2);
    num_pairs = size(pairs, 1);

    % Loop over each 2D subspace
    for i = 1:num_pairs
        pair = pairs(i, :);

        % Create a new figure for each 2D subspace
        figure;
        hold on;
        grid on;

        % Track min and max across all datasets for setting axis limits
        xlims = [inf, -inf];
        ylims = [inf, -inf];

        % Plot each dataset in the current 2D subspace
        for j = 1:num_datasets
            data = varargin{j};

            % Check range of values in each dimension to diagnose possible constant values
            range_x = range(data(:, pair(1)));
            range_y = range(data(:, pair(2)));

            fprintf('Dataset %d, Subspace [%d %d]: Range X = %.2f, Y = %.2f\n', ...
                    j, pair(1), pair(2), range_x, range_y);

            scatter(data(:, pair(1)), data(:, pair(2)), 36, colors(j, :), 'filled');

            % Update axis limits based on data range
            xlims = [min(xlims(1), min(data(:, pair(1)))), max(xlims(2), max(data(:, pair(1))))];
            ylims = [min(ylims(1), min(data(:, pair(2)))), max(ylims(2), max(data(:, pair(2))))];
        end

        % Set axis labels
        xlabel(['Dimension ', num2str(pair(1))]);
        ylabel(['Dimension ', num2str(pair(2))]);

        % Set axis limits
        xlim(xlims);
        ylim(ylims);

        % Add legend for each dataset
        legend(arrayfun(@(k) ['Dataset ', num2str(k)], 1:num_datasets, 'UniformOutput', false));

        title(['2D Subspace: Dimensions ', num2str(pair(1)), ' vs. ', num2str(pair(2))]);

        hold off;
    end
end