function B = toy_example_HMT(A, X, r)

n = size(A,1);
B = cell(4,4);
AX = cell(4,4);

AX{4,1} = tensorprod(A, X{3,1}, [2,3,4,5,6], [1,2,3,4,5]);
[B{4,1}, ~] = qr(AX{4,1},0);

AX{4,2} = tensorprod(A, X{3,2}, [1,3,4,5,6], [1,2,3,4,5]);
[B{4,2}, ~] = qr(AX{4,2},0);

AX{3,2} = tensorprod(A, X{2,2}, [1,2,4,5,6], [1,2,3,4,5]);
[B{3,2}, ~] = qr(AX{3,2},0);

AX{3,3} = tensorprod(A, X{2,3}, [1,2,3,4,6], [1,2,3,4,5]);
[B{3,3}, ~] = qr(AX{3,3},0);

AX{3,4} = tensorprod(A, X{2,4}, [1,2,3,4,5], [1,2,3,4,5]);
[B{3,4}, ~] = qr(AX{3,4},0);

AX{2,2} = tensorprod(A, X{1,2}, [1,2,3,5,6], [1,2,3,4,5]); 
[B{2,2}, ~] = qr(AX{2,2},0);

A12  = A;
for i = 1:2
    A12 = tensorprod(A12, B{4,i}, 1,1);
end
A12 = permute(A12, [5,6,1,2,3,4]);

AX{3,1} = tensorprod(A12, X{2,1}, [3,4,5,6], [1,2,3,4]); 
AX{3,1} = reshape(AX{3,1}, [r^2,r]);
[B{3,1}, ~] = qr(AX{3,1},0);
B{3,1} = reshape(B{3,1}, [r,r,r]);

A123 = A12;
A123 = tensorprod(A123, B{3,1}, [1,2],[1,2]);
A123 = tensorprod(A123, B{3,2}, 1, 1);
A123 = permute(A123, [4,5,1,2,3]);
AX{2,1} = tensorprod(A123, X{1,1}, [3,4,5], [1,2,3]);
AX{2,1} = reshape(AX{2,1}, [r^2,r]);
[B{2,1}, ~] = qr(AX{2,1},0);
B{2,1} = reshape(B{2,1}, [r,r,r]);

A56  = A;
A56 = tensorprod(A56, B{3,3}, 5,1);
A56 = tensorprod(A56, B{3,4}, 5,1);
A56 = permute(A56, [5,6,1,2,3,4]);

AX{2,3} = tensorprod(A56, X{1,3}, [3,4,5,6], [1,2,3,4]);
AX{2,3} = reshape(AX{2,3}, [r^2, r]);
[B{2,3}, ~] = qr(AX{2,3},0);
B{2,3} = reshape(B{2,3}, [r,r,r]);

B{1,1} = tensorprod(A123, B{2,1}, [1,2], [1,2]);
B{1,1} = tensorprod(B{1,1}, B{2,2}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{3,3}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{3,4}, 1, 1);
B{1,1} = tensorprod(B{1,1}, B{2,3}, [3,4], [1,2]);



