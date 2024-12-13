n = 15;
r = 7;
l = 2;
[X, Y] = toy_example_sketchings(n, r, l);
%A = ones(ones(1,6)*n);
A = zeros(ones(1,6)*n);
for i = 1:5
    A2 = randn(n,1);
    for j = 1:5
       A2 = kron(A2,randn(n,1));
    end
    A2 = reshape(A2, ones(1,6)*n);
    A = A+A2;
end
B = toy_example_nystrom(A, X, Y, r, l);
Bsvd = toy_example_SVD(A, r);
Bhmt = toy_example_HMT(A, X, r);
T = toy_example_from_TTN_to_tensor(B);
Tsvd = toy_example_from_TTN_to_tensor(Bsvd);
Thmt = toy_example_from_TTN_to_tensor(Bhmt);
norm(T-A,'fro')/norm(T,'fro')
norm(Tsvd-A,'fro')/norm(T,'fro')
norm(Thmt-A, 'fro')/norm(T,'fro')
%% 