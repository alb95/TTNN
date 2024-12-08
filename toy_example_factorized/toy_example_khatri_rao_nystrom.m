function B = toy_example_khatri_rao_nystrom(A, X, Y, r, l)
% provide an A in TTN format
Ranks_A = cell(4,4);
for i = 1:4
    for j = 1:4
        Ranks_A{i,j} = size(A{i,j});
    end
end
B = cell(4,4);
C = cell(4,4);
D = cell(4,4);
Q = cell(4,4);
R = cell(4,4);
Right = cell(4,4);
AX = cell(4,4);
YkAX = cell(4,4);
YAX = cell(4,4);

C{4,1} = tensorprod(A{4,1}, X{1}, 1, 1);
C{4,2} = tensorprod(A{4,2}, X{2}, 1, 1);
C{3,2} = tensorprod(A{3,2}, X{3}, 1, 1);
C{2,2} = tensorprod(A{2,2}, X{4}, 1, 1);
C{3,3} = tensorprod(A{3,3}, X{5}, 1, 1);
C{3,4} = tensorprod(A{3,4}, X{6}, 1, 1);
krC4_12 = reshape(khatrirao(C{4,1}, C{4,2}),[Ranks_A{3,1}(1),Ranks_A{3,1}(2),r]);
C{3,1} = tensorprod(A{3,1}, krC4_12, [1,2], [1,2]);

krC3_12 = reshape(khatrirao(C{3,1}, C{3,2}),[Ranks_A{2,1}(1),Ranks_A{2,1}(2),r]);
C{2,1} = tensorprod(A{2,1}, krC3_12, [1,2], [1,2]);

krC3_34 = reshape(khatrirao(C{3,3}, C{3,4}),[Ranks_A{2,3}(1),Ranks_A{2,3}(2),r]);
C{2,3} = tensorprod(A{2,3}, krC3_34, [1,2], [1,2]);

%krC2_123 = reshape(khatrirao(C{2,1}, ...
%            khatrirao(C{2,2}, C{2,3})),[Ranks_A{1,1}(1),Ranks_A{1,1}(2),Ranks_A{1,1}(3),r]);
%C{1,1} = tensorprod(A{1,1}, krC2_123, [1,2,3], [1,2,3]);

%----------
D = cell(4,4);

D{4,1} = tensorprod(A{4,1}, Y{1}, 1, 1);
D{4,2} = tensorprod(A{4,2}, Y{2}, 1, 1);
D{3,2} = tensorprod(A{3,2}, Y{3}, 1, 1);
D{2,2} = tensorprod(A{2,2}, Y{4}, 1, 1);
D{3,3} = tensorprod(A{3,3}, Y{5}, 1, 1);
D{3,4} = tensorprod(A{3,4}, Y{6}, 1, 1);

krD4_12 = reshape(khatrirao(D{4,1}, D{4,2}),[Ranks_A{3,1}(1),Ranks_A{3,1}(2),r+l]);
D{3,1} = tensorprod(A{3,1}, krD4_12, [1,2], [1,2]);

krD3_12 = reshape(khatrirao(D{3,1}, D{3,2}),[Ranks_A{2,1}(1),Ranks_A{2,1}(2),r+l]);
D{2,1} = tensorprod(A{2,1}, krD3_12, [1,2], [1,2]);

krD3_34 = reshape(khatrirao(D{3,3}, D{3,4}),[Ranks_A{2,3}(1),Ranks_A{2,3}(2),r+l]);
D{2,3} = tensorprod(A{2,3}, krD3_34, [1,2], [1,2]);

%krD2_123 = reshape(khatrirao(D{2,1}, ...
%            khatrirao(D{2,2}, D{2,3})),[Ranks_A{1,1}(1),Ranks_A{1,1}(2),Ranks_A{1,1}(3),r+l]);
%D{1,1} = tensorprod(A{1,1}, krD2_123, [1,2,3], [1,2,3]);
%---------
krC2_23 = reshape(khatrirao(C{2,2}, C{2,3}),[Ranks_A{1,1}(2),Ranks_A{1,1}(3),r]);
Right{2,1} = tensorprod(A{1,1}, krC2_23, [2,3], [1,2]);

AX{2,1} = tensorprod(A{2,1}, Right{2,1}, 3,1);
YkAX{2,1} = tensorprod(AX{2,1}, D{3,1}, 1,1);
YkAX{2,1} = tensorprod(YkAX{2,1}, D{3,2}, 1,1);
YkAX{2,1} = permute(YkAX{2,1}, [2,3,1]);

YAX{2,1} = tensorprod(D{2,1}, Right{2,1}, 1, 1);
[Q{2,1}, R{2,1}] = qr(YAX{2,1}, 0);

krC2_13 = reshape(khatrirao(C{2,1}, C{2,3}),[Ranks_A{1,1}(1),Ranks_A{1,1}(3),r]);
Right{2,2} = tensorprod(A{1,1}, krC2_13, [1,3], [1,2]);
AX{2,2} = tensorprod(A{2,2}, Right{2,2}, 2, 1);
YAX{2,2} = tensorprod(AX{2,2}, Y{4}, 1,1);
YAX{2,2} = permute(YAX{2,2}, [2,1]);
[Q{2,2}, R{2,2}] = qr(YAX{2,2}, 0);

krC2_12 = reshape(khatrirao(C{2,1}, C{2,2}),[Ranks_A{1,1}(1),Ranks_A{1,1}(2),r]);
Right{2,3} = tensorprod(A{1,1}, krC2_12, [1,2], [1,2]);

AX{2,3} = tensorprod(A{2,3}, Right{2,3}, 3,1);
YkAX{2,3} = tensorprod(AX{2,3}, D{3,3}, 1,1);
YkAX{2,3} = tensorprod(YkAX{2,3}, D{3,4}, 1,1);
YkAX{2,3} = permute(YkAX{2,3}, [2,3,1]);

YAX{2,3} = tensorprod(D{2,3}, Right{2,3}, 1, 1);
[Q{2,3}, R{2,3}] = qr(YAX{2,3}, 0);

krC2_23_C3_2 = reshape(khatrirao(C{3,2}, Right{2,1}),[Ranks_A{2,1}(2),Ranks_A{2,1}(3),r]);
Right{3,1} = tensorprod(A{2,1}, krC2_23_C3_2, [2,3], [1,2]);
AX{3,1} = tensorprod(A{3,1}, Right{3,1}, 3,1);
YkAX{3,1} = tensorprod(AX{3,1}, D{4,1}, 1,1);
YkAX{3,1} = tensorprod(YkAX{3,1}, D{4,2}, 1,1);
YkAX{3,1} = permute(YkAX{3,1}, [2,3,1]);

YAX{3,1} = tensorprod(D{3,1}, Right{3,1}, 1, 1);
[Q{3,1}, R{3,1}] = qr(YAX{3,1}, 0);

krC31_R21 = reshape(khatrirao(C{3,1}, Right{2,1}),[Ranks_A{2,1}(1),Ranks_A{2,1}(3),r]);
Right{3,2} = tensorprod(A{2,1}, krC31_R21, [1,3], [1,2]);
AX{3,2} = tensorprod(A{3,2}, Right{3,2}, 2, 1);
YAX{3,2} = tensorprod(AX{3,2}, Y{3}, 1, 1);
YAX{3,2} = permute(YAX{3,2}, [2,1]);
[Q{3,2}, R{3,2}] = qr(YAX{3,2}, 0);

krC34_R23 = reshape(khatrirao(C{3,4}, Right{2,3}),[Ranks_A{2,3}(2),Ranks_A{2,3}(3),r]);
Right{3,3} = tensorprod(A{2,3}, krC34_R23, [2,3], [1,2]);
AX{3,3} = tensorprod(A{3,3}, Right{3,3}, 2, 1);
YAX{3,3} = tensorprod(AX{3,3}, Y{5}, 1, 1);
YAX{3,3} = permute(YAX{3,3}, [2,1]);
[Q{3,3}, R{3,3}] = qr(YAX{3,3}, 0);

krC33_R23 = reshape(khatrirao(C{3,3}, Right{2,3}),[Ranks_A{2,3}(1),Ranks_A{2,3}(3),r]);
Right{3,4} = tensorprod(A{2,3}, krC33_R23, [1,3], [1,2]);
AX{3,4} = tensorprod(A{3,4}, Right{3,4}, 2, 1);
YAX{3,4} = tensorprod(AX{3,4}, Y{6}, 1, 1);
YAX{3,4} = permute(YAX{3,4}, [2,1]);
[Q{3,4}, R{3,4}] = qr(YAX{3,4}, 0);


krC42_R31 = reshape(khatrirao(C{4,2}, Right{3,1}),[Ranks_A{3,1}(2),Ranks_A{3,1}(3),r]);
Right{4,1} = tensorprod(A{3,1}, krC42_R31, [2,3], [1,2]);
AX{4,1} = tensorprod(A{4,1}, Right{4,1}, 2, 1);
YAX{4,1} = tensorprod(AX{4,1}, Y{1}, 1, 1);
YAX{4,1} = permute(YAX{4,1}, [2,1]);
[Q{4,1}, R{4,1}] = qr(YAX{4,1}, 0);

krC41_R32 = reshape(khatrirao(C{4,1}, Right{3,1}),[Ranks_A{3,1}(1),Ranks_A{3,1}(3),r]);
Right{4,2} = tensorprod(A{3,1}, krC41_R32, [1,3], [1,2]);
AX{4,2} = tensorprod(A{4,2}, Right{4,2}, 2, 1);
YAX{4,2} = tensorprod(AX{4,2}, Y{2}, 1, 1);
YAX{4,2} = permute(YAX{4,2}, [2,1]);
[Q{4,2}, R{4,2}] = qr(YAX{4,2}, 0);
%------------
B{1,1} = A{1,1};
for j = 1:3
    B{1,1} = tensorprod(B{1,1}, D{2,j}, 1, 1);
end
for j = 1:3
    B{1,1} = tensorprod(B{1,1}, Q{2,j}, 1, 1);
end

B{2,1} = reshape(YkAX{2,1}, [(r+l)^2, r])/R{2,1};
B{2,1} = reshape(B{2,1},[r+l,r+l,r]);
for j = 1:2
    B{2,1} = tensorprod(B{2,1}, Q{3,j}, 1,1);
end
B{2,1} = permute(B{2,1},[2,3,1]);

B{2,2} = AX{2,2}/R{2,2};

B{2,3} = reshape(YkAX{2,3}, [(r+l)^2, r])/R{2,3};
B{2,3} = reshape(B{2,3},[r+l,r+l,r]);
for j = 1:2
    B{2,3} = tensorprod(B{2,3}, Q{3,j+2}, 1,1);
end
B{2,3} = permute(B{2,3},[2,3,1]);

B{3,1} = reshape(YkAX{3,1}, [(r+l)^2, r])/R{3,1};
B{3,1} = reshape(B{3,1},[r+l,r+l,r]);
for j = 1:2
    B{3,1} = tensorprod(B{3,1}, Q{4,j}, 1,1);
end
B{3,1} = permute(B{3,1},[2,3,1]);

B{3,2} = AX{3,2}/R{3,2};

B{3,3} = AX{3,3}/R{3,3};

B{3,4} = AX{3,4}/R{3,4};

B{4,1} = AX{4,1}/R{4,1};

B{4,2} = AX{4,2}/R{4,2};
