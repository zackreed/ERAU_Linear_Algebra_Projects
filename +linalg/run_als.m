function als_results = run_als(data_split, k_latent, lambda_reg, max_iters, tol,fold)
    [m, n] = size(data_split.A_train);

    % Initialize U and V matrices
    rng(42+fold);  % Seed for reproducibility
    U = rand(m, k_latent);
    V = rand(n, k_latent);

    % Center the training data
    A_train_centered = data_split.A_train;
    A_train_centered(data_split.A_train ~= 0) = ...
        data_split.A_train(data_split.A_train ~= 0) - data_split.mu;

    % Store RMSE history for convergence check
    rmse_train = zeros(max_iters, 1);
    converged = false;

    for iter = 1:max_iters
        % Update U matrix
        for i = 1:m
            rated_items = find(data_split.A_train(i, :) ~= 0);
            if isempty(rated_items), continue; end
            V_rated = V(rated_items, :);
            A_rated = A_train_centered(i, rated_items)';
            A_matrix = V_rated' * V_rated + lambda_reg * eye(k_latent);
            b_vector = V_rated' * A_rated;
            U(i, :) = (A_matrix \ b_vector)';
        end

        % Update V matrix
        for j = 1:n
            rated_users = find(data_split.A_train(:, j) ~= 0);
            if isempty(rated_users), continue; end
            U_rated = U(rated_users, :);
            A_ratings = A_train_centered(rated_users, j);
            A_matrix = U_rated' * U_rated + lambda_reg * eye(k_latent);
            b_vector = U_rated' * A_ratings;
            V(j, :) = (A_matrix \ b_vector)';
        end

        % Compute training RMSE
        predicted_ratings_train = U * V' + data_split.mu;
        error_train = data_split.mask_train .* ...
                      (data_split.A_train - predicted_ratings_train);
        rmse_train(iter) = sqrt(sum(error_train(:).^2) / nnz(data_split.mask_train));

        % Check for convergence
        if iter > 1 && abs(rmse_train(iter) - rmse_train(iter - 1)) < tol
            converged = true;
            fprintf('Validation %d converged at iteration %d and training RMSE %.4f\n', fold,iter,rmse_train(iter));
            break;
        end
    end

    % Return results as a structure
    als_results = struct('U', U, 'V', V, 'rmse_train', rmse_train, ...
                         'converged', converged, 'mu', data_split.mu);
end