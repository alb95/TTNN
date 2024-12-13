function B = create_toy_example_TTN(n, r, decay, rho)

B = cell(4,4);

B{1,1} = create_low_rank_cp_tensor(r, 3, decay, rho);
B{2, 1} = create_low_rank_cp_tensor(r, 3, decay, rho);
[Q,~] = qr(randn(n, r), 0); B{2, 2} = Q;
B{2, 3} = create_low_rank_cp_tensor(r, 3, decay, rho);
B{3, 1} = create_low_rank_cp_tensor(r, 3, decay, rho);
[Q,~] = qr(randn(n, r), 0); B{3, 2} = Q;
[Q,~] = qr(randn(n, r), 0); B{3, 3} = Q;
[Q,~] = qr(randn(n, r), 0); B{3, 4} = Q;
[Q,~] = qr(randn(n, r), 0); B{4, 1} = Q;
[Q,~] = qr(randn(n, r), 0); B{4, 2} = Q;

