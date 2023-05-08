function [portfolio_return, portfolio_std] = compute_portfolio_stats(weights, stock_data)
    % Funtion to calculate the risk and performance of the portfolio on a
    % set of stocks for a certain period of time
    portfolio_return = compute_portfolio_return(weights, stock_data);
    portfolio_std = sqrt(weights * cov(stock_data) * weights');
end