function B = toy_example_nystrom(A, X, Y, r, l)
B = cell(4,4);
AX = cell(3,4);
YAX = cell(3,4);
Q = cell(3,4);
R = cell(3,4);

B{1,1} = tensorprod(A, Y{1,1}, [1,2,3], [1,2,3]);
B{1,1} = tensorprod(B{1,1}, Y{1,2}, 1, 1);
B{1,1} = tensorprod(B{1,1}, Y{1,3}, [1,2], [1,2]);

%-------
AX{1,1} = tensorprod(A,X{1,1}, [4,5,6], [1,2,3]);

YAX{1,1} = tensorprod(AX{1,1}, Y{1,1}, [1,2,3], [1,2,3]);
YAX{1,1} = permute(YAX{1,1}, [2,1]);

[Q{1,1}, R{1,1}] = qr(YAX{1,1}, 0);

YkAX{1,1} = tensorprod(AX{1,1}, Y{2,1}, [1,2],[1,2]);
YkAX{1,1} = tensorprod(YkAX{1,1}, Y{2,2}, 1,1);
YkAX{1,1} = permute(YkAX{1,1}, [2,3,1]);
%---------
AX{1,2} = tensorprod(A, X{1,2}, [1,2,3,5,6], [1,2,3,4,5]);

YAX{1,2} = tensorprod(AX{1,2},Y{1,2}, 1, 1);
YAX{1,2} = permute(YAX{1,2}, [2,1]);

[Q{1,2}, R{1,2}] = qr(YAX{1,2}, 0);
%------
AX{1,3} = tensorprod(A, X{1,3}, [1,2,3,4], [1,2,3,4]);

YAX{1,3} = tensorprod(AX{1,3}, Y{1,3}, [1,2], [1,2]);
YAX{1,3} = permute(YAX{1,3},[2,1]);

[Q{1,3}, R{1,3}] = qr(YAX{1,3}, 0);

YkAX{1,3} = tensorprod(AX{1,3}, Y{2,3}, 1,1);
YkAX{1,3} = tensorprod(YkAX{1,3}, Y{2,4}, 1,1);
YkAX{1,3} = permute(YkAX{1,3}, [2,3,1]);
%------
AX{2,1} = tensorprod(A, X{2,1}, [3,4,5,6], [1,2,3,4]);

YAX{2,1} = tensorprod(AX{2,1}, Y{2,1}, [1,2], [1,2]);
YAX{2,1} = permute(YAX{2,1}, [2,1]);

[Q{2,1}, R{2,1}] = qr(YAX{2,1}, 0);

YkAX{2,1} = tensorprod(AX{2,1}, Y{3,1}, 1,1);
YkAX{2,1} = tensorprod(YkAX{2,1}, Y{3,2}, 1,1);
YkAX{2,1} = permute(YkAX{2,1}, [2,3,1]);
%------
AX{2,2} = tensorprod(A, X{2,2}, [1,2,4,5,6], [1,2,3,4,5]);

YAX{2,2} = tensorprod(AX{2,2}, Y{2,2}, 1,1);
YAX{2,2} = permute(YAX{2,2}, [2,1]);

[Q{2,2}, R{2,2}] = qr(YAX{2,2}, 0);
%------
AX{2,3} = tensorprod(A, X{2,3}, [1,2,3,4,6], [1,2,3,4,5]);

YAX{2,3} = tensorprod(AX{2,3}, Y{2,3}, 1,1);
YAX{2,3} = permute(YAX{2,3}, [2,1]);

[Q{2,3}, R{2,3}] = qr(YAX{2,3}, 0);
%------
AX{2,4} = tensorprod(A, X{2,4}, [1,2,3,4,5], [1,2,3,4,5]);

YAX{2,4} = tensorprod(AX{2,4}, Y{2,4}, 1,1);
YAX{2,4} = permute(YAX{2,4}, [2,1]);

[Q{2,4}, R{2,4}] = qr(YAX{2,4}, 0);
%------
AX{3,1} = tensorprod(A, X{3,1}, [2,3,4,5,6], [1,2,3,4,5]);

YAX{3,1} = tensorprod(AX{3,1}, Y{3,1}, 1,1);
YAX{3,1} = permute(YAX{3,1}, [2,1]);

[Q{3,1}, R{3,1}] = qr(YAX{3,1}, 0);
%------
AX{3,2} = tensorprod(A, X{3,2}, [1,3,4,5,6], [1,2,3,4,5]);

YAX{3,2} = tensorprod(AX{3,2}, Y{3,2}, 1,1);
YAX{3,2} = permute(YAX{3,2}, [2,1]);

[Q{3,2}, R{3,2}] = qr(YAX{3,2}, 0);
%% adding the Q
for j = 1:3
    B{1,1} = tensorprod(B{1,1}, Q{1,j}, 1,1);
end

B{2,1} = reshape(YkAX{1,1}, [(r+l)^2, r])/R{1,1};
B{2,1} = reshape(B{2,1},[r+l,r+l,r]);
for j = 1:2
    B{2,1} = tensorprod(B{2,1}, Q{2,j}, 1,1);
end
B{2,1} = permute(B{2,1},[2,3,1]);

B{2,2} = AX{1,2}/R{1,2};

B{2,3} = reshape(YkAX{1,3}, [(r+l)^2, r])/R{1,3};
B{2,3} = reshape(B{2,3},[r+l,r+l,r]);
for j = 1:2
    B{2,3} = tensorprod(B{2,3}, Q{2,j+2}, 1,1);
end
B{2,3} = permute(B{2,3},[2,3,1]);

B{3,1} = reshape(YkAX{2,1}, [(r+l)^2, r])/R{2,1};
B{3,1} = reshape(B{3,1},[r+l,r+l,r]);
for j = 1:2
    B{3,1} = tensorprod(B{3,1}, Q{3,j}, 1,1);
end
B{3,1} = permute(B{3,1},[2,3,1]);

B{3,2} = AX{2,2}/R{2,2};

B{3,3} = AX{2,3}/R{2,3};

B{3,4} = AX{2,4}/R{2,4};

B{4,1} = AX{3,1}/R{3,1};

B{4,2} = AX{3,2}/R{3,2};