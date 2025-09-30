function [best_mu, best_U, best_V, best_rmse] = run_als_with_cross_validation(matrix, tolerance, lambda_reg, k_latent, num_folds, max_iters)
    % RUN_ALS_WITH_CROSS_VALIDATION - Perform ALS with k-fold cross-validation.
    %
    % Inputs:
    %   matrix      - Sparse matrix containing the data.
    %   tolerance   - Convergence tolerance for ALS.
    %   lambda_reg  - Regularization coefficient for ALS.
    %   k_latent    - Number of latent dimensions.
    %   num_folds   - Number of folds for cross-validation.
    %   max_iters   - Maximum number of iterations for ALS.
    %
    % Outputs:
    %   best_mu     - Global mean of the best model.
    %   best_U      - User-latent matrix of the best model.
    %   best_V      - Item-latent matrix of the best model.
    %   best_rmse   - RMSE of the best model.

    % Set up cross-validation and initialize the best model
    [cv_setup, best_model] = linalg.set_up_cross_validation(matrix, num_folds);
    rmse_folds = zeros(num_folds, 1);

    for fold = 1:num_folds
        % Split the data into training and test sets
        data_split = linalg.prepare_train_test_split(matrix, cv_setup, fold);

        % Run ALS for the current fold
        als_results = linalg.run_als(data_split, k_latent, lambda_reg, max_iters, tolerance,fold);

        % Evaluate on test data
        rmse_test = linalg.evaluate_test_data(data_split, als_results);
        fprintf('Validation %d, Test RMSE: %.4f\n', fold, rmse_test);

        % Update the best model
        best_model = linalg.update_best_model_struct(best_model, rmse_test, als_results,fold);

        % Store the RMSE for this fold
        rmse_folds(fold) = rmse_test;
    end

    % Assign outputs for the best model
    best_mu = best_model.mu;
    best_U = best_model.U;
    best_V = best_model.V;
    best_rmse = best_model.rmse;

    % Compute the average RMSE across all folds (optional)
    %average_rmse = mean(rmse_folds);
    %fprintf('\nAverage RMSE across all folds: %.4f\n', average_rmse);
end