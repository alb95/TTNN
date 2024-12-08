function B = toy_example_SVD(A, r)

n = size(A,1);
B = cell(4,4);


[B{4,1}, ~, ~] = svd(reshape(A, [n,n^5]), 'econ');
B{4,1} = B{4,1}(:, 1:r);

[B{4,2}, ~, ~] = svd(reshape(permute(A, [2,3,4,5,6,1]), [n,n^5]), 'econ');
B{4,2} = B{4,2}(:, 1:r);

[B{3,2}, ~, ~] = svd(reshape(permute(A, [3,1,2,4,5,6]), [n,n^5]), 'econ');
B{3,2} = B{3,2}(:, 1:r);

[B{3,3}, ~, ~] = svd(reshape(permute(A, [5,1,2,3,4,6]), [n,n^5]), 'econ');
B{3,3} = B{3,3}(:, 1:r);

[B{3,4}, ~, ~] = svd(reshape(permute(A, [6,1,2,3,4,5]), [n,n^5]), 'econ');
B{3,4} = B{3,4}(:, 1:r);

[B{2,2}, ~, ~] = svd(reshape(permute(A, [4,1,2,3,5,6]), [n,n^5]), 'econ');
B{2,2} = B{2,2}(:, 1:r);

A12  = A;
for i = 1:2
    A12 = tensorprod(A12, B{4,i}, 1,1);
end
A12 = permute(A12, [5,6,1,2,3,4]);
[B{3,1}, ~, ~] = svd(reshape(A12, [r^2,n^4]), 'econ');
B{3,1} = B{3,1}(:, 1:r);
B{3,1} = reshape(B{3,1}, [r,r,r]);

A123 = A12;
A123 = tensorprod(A123, B{3,1}, [1,2],[1,2]);
A123 = tensorprod(A123, B{3,2}, 1, 1);
A123 = permute(A123, [4,5,1,2,3]);
[B{2,1}, ~, ~] = svd(reshape(A123, [r^2,n^3]), 'econ');
B{2,1} = B{2,1}(:, 1:r);
B{2,1} = reshape(B{2,1}, [r,r,r]);

A56  = A;
A56 = tensorprod(A56, B{3,3}, 5,1);
A56 = tensorprod(A56, B{3,4}, 5,1);
A56 = permute(A56, [5,6,1,2,3,4]);

[B{2,3}, ~, ~] = svd(reshape(A56, [r^2,n^4]), 'econ');
B{2,3} = B{2,3}(:, 1:r);
B{2,3} = reshape(B{2,3}, [r,r,r]);

B{1,1} = tensorprod(A123, B{2,1}, [1,2], [1,2]);
B{1,1} = tensorprod(B{1,1}, B{2,2}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{3,3}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{3,4}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{2,3}, [3,4], [1,2]);



