function B = toy_example_TTN_SVD(A, r)
% permorm the TTN rounding of the tensor A in toy example TTN format.
rA = size(A{4,1}, 2);
B = cell(4,4);
Q = cell(4,4);
R = cell(4,4);
M = cell(4,4);

%% orthogonalization phase

[Q{4,1}, R{4,1}] = qr(A{4, 1}, 0);
[Q{4,2}, R{4,2}] = qr(A{4, 2}, 0);
[Q{3,2}, R{3,2}] = qr(A{3, 2}, 0); 
[Q{3,3}, R{3,3}] = qr(A{3, 3}, 0); 
[Q{3,4}, R{3,4}] = qr(A{3, 4}, 0); 
[Q{2,2}, R{2,2}] = qr(A{2, 2}, 0); 

M{2,3} = A{2,3};
M{2,3} = tensorprod(M{2,3}, R{3,3}, 1, 2);
M{2,3} = tensorprod(M{2,3}, R{3,4}, 1, 2);
M{2,3} = permute(M{2,3}, [2,3,1]);
[Q{2,3}, R{2,3}] = qr(reshape(M{2, 3}, [rA^2, rA]), 0); 

M{1,1} = A{1,1};
M{1,1} = tensorprod(M{1,1}, R{2,2}, 2, 2);
M{1,1} = tensorprod(M{1,1}, R{2,3}, 2, 2);
M{1,1} = permute(M{1,1}, [2,3,1]);
[Q{1,1}, R{1,1}] = qr(reshape(M{1, 1}, [rA^2, rA]), 0); 
M{1,1} = reshape(Q{1,1}, [rA,rA,rA]);
M{1,1} = permute(M{1,1}, [3,1,2]);

M{2,1} = tensorprod(A{2,1}, R{3,2}, 2, 2);
M{2,1} = tensorprod(M{2,1}, R{1,1}, 2, 2);
M{2,1} = permute(M{2,1}, [2,3,1]);
[Q{2,1}, R{2,1}] = qr(reshape(M{2, 1}, [rA^2, rA]), 0);
M{2,1} = reshape(Q{2,1}, [rA,rA,rA]);
M{2,1} = permute(M{2,1}, [3,1,2]);

M{3,1} = tensorprod(A{3,1}, R{4,1}, 1, 2);
M{3,1} = tensorprod(M{3,1}, R{4,2}, 1, 2);
M{3,1} = tensorprod(M{3,1}, R{2,1}, 1, 2);

%% trancated SVD phase
[U{4,1}, ~, ~] = svd(reshape(M{3,1}, [rA, rA^2]), 'econ');
U{4,1} = U{4,1}(:, 1:r);
B{4,1} = Q{4,1}*U{4,1};

[U{4,2}, ~, ~] = svd(reshape(permute(M{3,1}, [2, 1, 3]), [rA, rA^2]), 'econ');
U{4,2} = U{4,2}(:, 1:r);
B{4,2} = Q{4,2}*U{4,2};

M{3,1} = tensorprod(M{3,1}, U{4,1}, 1, 1);
M{3,1} = tensorprod(M{3,1}, U{4,2}, 1, 1);
M{3,1} = permute(M{3,1}, [2,3,1]);
[U{3,1}, S{3,1}, V{3,1}]  = svd(reshape(M{3,1}, [r^2, rA]), 'econ');
U{3,1} = U{3,1}(:, 1:r);
S{3,1} = S{3,1}(1:r, 1:r);
V{3,1} = V{3,1}(:, 1:r);
R{3,1} = S{3,1}*V{3,1}';
B{3,1} = reshape(U{3,1}, [r,r,r]);

M{2,1} = tensorprod(M{2,1}, R{3,1}, 1, 2);
[U{3,2}, ~, ~]  = svd(reshape(M{2,1}, [rA, rA*r]), 'econ');
U{3,2} = U{3,2}(:, 1:r);
B{3,2} = Q{3,2}*U{3,2};

M{2,1} = tensorprod(M{2,1}, U{3,2}, 1,1);
M{2,1} = permute(M{2,1}, [2,3,1]);
[U{2,1}, S{2,1}, V{2,1}]  = svd(reshape(M{2,1}, [r^2, rA]), 'econ');
U{2,1} = U{2,1}(:, 1:r);
S{2,1} = S{2,1}(1:r, 1:r);
V{2,1} = V{2,1}(:, 1:r);
R{2,1} = S{2,1}*V{2,1}';
B{2,1} = reshape(U{2,1}, [r,r,r]);

M{1,1} = tensorprod(M{1,1}, R{2,1}, 1, 2);
[U{2,2}, ~, ~]  = svd(reshape(M{1,1}, [rA, rA*r]), 'econ');
U{2,2} = U{2,2}(:, 1:r);
B{2,2} = Q{2,2}*U{2,2};

M{1,1} = tensorprod(M{1,1}, U{2,2}, 1, 1);
M{1,1} = permute(M{1,1}, [2,3,1]);%??? svd instead of qr???
[Q{1,1}, R{1,1}] = qr(reshape(M{1,1}, [r^2, rA]), 0); %important r^2> rA
M{2,3} = tensorprod(Q{2,3}, R{1,1}, 2, 2);
rx = numel(M{2,3})/rA^2;
M{2,3} = reshape(M{2,3}, [rA, rA, rx]);
[U{3,3}, ~, ~]  = svd(reshape(M{2,3}, [rA, rA*rx]), 'econ');
[U{3,4}, ~, ~]  = svd(reshape(permute(M{2,3},[2,3,1]), [rA, rA*rx]), 'econ');
U{3,3} = U{3,3}(:, 1:r);
U{3,4} = U{3,4}(:, 1:r);

B{3,3} = Q{3,3}*U{3,3};

B{3,4} = Q{3,4}*U{3,4};

M{2,3} = tensorprod(M{2,3}, U{3,3}, 1, 1);
M{2,3} = tensorprod(M{2,3}, U{3,4}, 1, 1);
M{2,3} = permute(M{2,3}, [2,3,1]);
[U{2,3}, S{2,3}, V{2,3}]  = svd(reshape(M{2,3}, [r^2, rx]), 'econ');
U{2,3} = U{2,3}(:, 1:r);
S{2,3} = S{2,3}(1:r, 1:r);
V{2,3} = V{2,3}(:, 1:r);
R{2,3} = S{2,3}*V{2,3}';
B{2,3} = reshape(U{2,3}, [r,r,r]);


Q{1,1} = tensorprod(Q{1,1}, R{2,3}, 2,2);
B{1,1} = reshape(Q{1,1}, [r,r,r]);


end

