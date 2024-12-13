function H = create_hilbert_tensor(n, d)
    % Creates a Hilbert tensor of dimension d and size n in each dimension
    % Inputs:
    % d - the dimension of the tensor
    % n - the size in each dimension (i.e., the tensor is n-by-n-by-n-... n times)
    % Output:
    % H - the resulting Hilbert tensor

    % Initialize cell array for the ranges 1:n for each dimension
    ranges = repmat({0:n-1}, 1, d);
    
    % Create a grid for all possible index combinations
    [grids{1:d}] = ndgrid(ranges{:});
    
    % Initialize the Hilbert tensor of size n-by-n-by-n-... d times
    H = zeros(n * ones(1, d));
    
    % Fill the tensor with the Hilbert formula
    for i = 1:numel(grids{1})
        idx = cellfun(@(x) x(i), grids);  % Extract the current index for each dimension
        H(i) = 1 / (1 + sum(idx));        % Compute the Hilbert value for this index
    end
end