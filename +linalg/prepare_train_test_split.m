function data_split = prepare_train_test_split(A, cv_setup, fold)
    % Extract necessary fields from cv_setup
    m = cv_setup.m;
    n = cv_setup.n;
    users_idx = cv_setup.users_idx;
    items_idx = cv_setup.items_idx;
    cv_indices = cv_setup.cv_indices;
    mask_full = cv_setup.mask_full;

    % Create test and training masks
    test_mask = false(m, n);
    train_mask = mask_full;

    % Set up indices for the test set in this fold
    test_indices = (cv_indices == fold);
    for idx = find(test_indices)'
        user = users_idx(idx);
        item = items_idx(idx);
        test_mask(user, item) = true;
        train_mask(user, item) = false;  % Remove from training mask
    end

    % Create training and test matrices
    A_train = A;
    A_train(test_mask) = 0;  % Remove test ratings from training data
    A_test = zeros(m, n);
    A_test(test_mask) = A(test_mask);  % Test data contains only test ratings

    % Precompute mask for training data
    mask_train = (A_train ~= 0);

    % Compute global mean from training data
    mu = sum(A_train(A_train ~= 0)) / nnz(A_train);

    % Return structure
    data_split = struct('A_train', A_train, 'A_test', A_test, ...
                        'test_mask', test_mask, 'train_mask', train_mask, ...
                        'mask_train', mask_train, 'mu', mu);
end