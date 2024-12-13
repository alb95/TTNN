function S = toy_example_norm(B)
% compute the norm of a tensor in TTN toy format
n = size(B{4,1}, 1);
r = size(B{4,1}, 2);

R = cell(4,4);
M = cell(4,4);

[~, R{4,1}] = qr(B{4, 1}, 0);
[~, R{4,2}] = qr(B{4, 2}, 0);
[~, R{3,2}] = qr(B{3, 2}, 0); 
[~, R{3,3}] = qr(B{3, 3}, 0); 
[~, R{3,4}] = qr(B{3, 4}, 0); 
[~, R{2,2}] = qr(B{2, 2}, 0); 

M{3,1} = B{3,1};
M{3,1} = tensorprod(M{3,1}, R{4,1}, 1, 2);
M{3,1} = tensorprod(M{3,1}, R{4,2}, 1, 2);
M{3,1} = permute(M{3,1}, [2,3,1]);
[~, R{3,1}] = qr(reshape(M{3, 1}, [r^2, r]), 0); 

M{2,1} = B{2,1};
M{2,1} = tensorprod(M{2,1}, R{3,1}, 1, 2);
M{2,1} = tensorprod(M{2,1}, R{3,2}, 1, 2);
M{2,1} = permute(M{2,1}, [2,3,1]);
[~, R{2,1}] = qr(reshape(M{2, 1}, [r^2, r]), 0); 

M{2,3} = B{2,3};
M{2,3} = tensorprod(M{2,3}, R{3,3}, 1, 2);
M{2,3} = tensorprod(M{2,3}, R{3,4}, 1, 2);
M{2,3} = permute(M{2,3}, [2,3,1]);
[~, R{2,3}] = qr(reshape(M{2, 3}, [r^2, r]), 0); 

M{1,1} = B{1,1};
M{1,1} = tensorprod(M{1,1}, R{2,1}, 1, 2);
M{1,1} = tensorprod(M{1,1}, R{2,2}, 1, 2);
M{1,1} = tensorprod(M{1,1}, R{2,3}, 1, 2);

S = norm(M{1,1}, 'fro');
end

