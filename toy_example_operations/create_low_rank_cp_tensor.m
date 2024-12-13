function T = create_low_rank_cp_tensor(n, d, decay, rho)

% choose the type of decay of the singular values

if strcmp(decay, 'exp')
    if nargin < 4
        rho = 0.5;
    end
    sigma = rho.^(0:n-1);
end

if strcmp(decay, 'linear')
    sigma = 1./(1:n);
end
if strcmp(decay, 'quadratic')
    sigma = 1./((1:n).^2);
end
if strcmp(decay, 'cubic')
    sigma = 1./((1:n).^3);
end
%% create the tensor

T = zeros(n*ones(1, d));
% create the superdiagonal of the tensor
for i = 1:n
    idx = repmat({i}, 1,d);
    T(idx{:}) = sigma(i); 
end
U = cell(1,d);
for i = 1:d
    [U{i}, ~] = qr(randn(n, n), 0);
end
for i = 1:d
    T = tensorprod(T, U{i}, 1, 1);
end