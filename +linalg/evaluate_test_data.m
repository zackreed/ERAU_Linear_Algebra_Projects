function rmse_test = evaluate_test_data(data_split, als_results)
    % Compute predicted ratings
    predicted_ratings_test = als_results.U * als_results.V' + data_split.mu;

    % Compute RMSE using only test mask entries
    error_test = data_split.test_mask .* ...
                 (data_split.A_test - predicted_ratings_test);
    rmse_test = sqrt(sum(error_test(:).^2) / nnz(data_split.test_mask));
end