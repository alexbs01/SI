function portfolio_return = compute_portfolio_return(weights, stock_data)
    % Calculates the performance of the portfolio taking into account a
    % certain weights and the prices of the stocks
    n_assets = size(stock_data, 2);
    portfolio_return = sum(weights .* mean(stock_data)) / sqrt(n_assets);
end