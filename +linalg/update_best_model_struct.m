function best_model = update_best_model_struct(best_model, rmse_test, als_results,fold)
    if rmse_test < best_model.rmse
        fprintf("Best approximations updated after validation %d with RMSE %.4f\n",fold,rmse_test);
        best_model.rmse = rmse_test;
        best_model.U = als_results.U;
        best_model.V = als_results.V;
        best_model.mu = als_results.mu;
    else
        %fprintf("Best approximations not updated for this fold.\n");
    end
end