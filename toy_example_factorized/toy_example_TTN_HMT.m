function B = toy_example_TTN_HMT(A, X, r)
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
QA = cell(4,4);
M = cell(4,4);

%% compute all the right partial contractions

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

krC2_23 = reshape(khatrirao(C{2,2}, C{2,3}),[Ranks_A{1,1}(2),Ranks_A{1,1}(3),r]);
Right{2,1} = tensorprod(A{1,1}, krC2_23, [2,3], [1,2]);
AX{2,1} = tensorprod(A{2,1}, Right{2,1}, 3,1);

krC2_13 = reshape(khatrirao(C{2,1}, C{2,3}),[Ranks_A{1,1}(1),Ranks_A{1,1}(3),r]);
Right{2,2} = tensorprod(A{1,1}, krC2_13, [1,3], [1,2]);
AX{2,2} = tensorprod(A{2,2}, Right{2,2}, 2, 1);

krC2_12 = reshape(khatrirao(C{2,1}, C{2,2}),[Ranks_A{1,1}(1),Ranks_A{1,1}(2),r]);
Right{2,3} = tensorprod(A{1,1}, krC2_12, [1,2], [1,2]);
AX{2,3} = tensorprod(A{2,3}, Right{2,3}, 3,1);

krC2_23_C3_2 = reshape(khatrirao(C{3,2}, Right{2,1}),[Ranks_A{2,1}(2),Ranks_A{2,1}(3),r]);
Right{3,1} = tensorprod(A{2,1}, krC2_23_C3_2, [2,3], [1,2]);
AX{3,1} = tensorprod(A{3,1}, Right{3,1}, 3,1);

krC31_R21 = reshape(khatrirao(C{3,1}, Right{2,1}),[Ranks_A{2,1}(1),Ranks_A{2,1}(3),r]);
Right{3,2} = tensorprod(A{2,1}, krC31_R21, [1,3], [1,2]);
AX{3,2} = tensorprod(A{3,2}, Right{3,2}, 2, 1);

krC34_R23 = reshape(khatrirao(C{3,4}, Right{2,3}),[Ranks_A{2,3}(2),Ranks_A{2,3}(3),r]);
Right{3,3} = tensorprod(A{2,3}, krC34_R23, [2,3], [1,2]);
AX{3,3} = tensorprod(A{3,3}, Right{3,3}, 2, 1);

krC33_R23 = reshape(khatrirao(C{3,3}, Right{2,3}),[Ranks_A{2,3}(1),Ranks_A{2,3}(3),r]);
Right{3,4} = tensorprod(A{2,3}, krC33_R23, [1,3], [1,2]);
AX{3,4} = tensorprod(A{3,4}, Right{3,4}, 2, 1);

krC42_R31 = reshape(khatrirao(C{4,2}, Right{3,1}),[Ranks_A{3,1}(2),Ranks_A{3,1}(3),r]);
Right{4,1} = tensorprod(A{3,1}, krC42_R31, [2,3], [1,2]);
AX{4,1} = tensorprod(A{4,1}, Right{4,1}, 2, 1);


krC41_R32 = reshape(khatrirao(C{4,1}, Right{3,1}),[Ranks_A{3,1}(1),Ranks_A{3,1}(3),r]);
Right{4,2} = tensorprod(A{3,1}, krC41_R32, [1,3], [1,2]);
AX{4,2} = tensorprod(A{4,2}, Right{4,2}, 2, 1);

%% compute the QR
[Q{4,1}, ~] = qr(AX{4,1}, 0);
[Q{4,2}, ~] = qr(AX{4,2}, 0);
M{4,1} = tensorprod(A{4,1}, Q{4,1},1, 1);
M{4,2} = tensorprod(A{4,2}, Q{4,2},1, 1);

QA{3,1} = tensorprod(A{3,1}, M{4,1}, 1 ,1);
QA{3,1} = tensorprod(QA{3,1}, M{4,2}, 1, 1);
AX{3,1} = tensorprod(QA{3,1}, Right{3,1}, 1,1);
AX{3,1} = reshape(AX{3,1}, [r^2, r]);
[Q{3,1}, ~] = qr(AX{3,1}, 0);
Q{3,1} = reshape(Q{3,1}, [r,r,r]);
M{3,1} = tensorprod(QA{3,1}, Q{3,1}, [2,3], [1,2]);
[Q{3,2}, ~] = qr(AX{3,2}, 0);
M{3,2} = tensorprod(A{3,2}, Q{3,2}, 1, 1);

QA{2,1} = tensorprod(A{2,1}, M{3,1},1, 1);
QA{2,1} = tensorprod(QA{2,1}, M{3,2}, 1, 1);
AX{2,1} = tensorprod(QA{2,1}, Right{2,1}, 1,1);
AX{2,1} = reshape(AX{2,1}, [r^2, r]);
[Q{2,1}, ~] = qr(AX{2,1}, 0);
Q{2,1} = reshape(Q{2,1}, [r,r,r]);
M{2,1} = tensorprod(QA{2,1}, Q{2,1}, [2,3], [1,2]); 
[Q{2,2}, ~] = qr(AX{2,2}, 0);
M{2,2} = tensorprod(A{2,2}, Q{2,2}, 1, 1);

[Q{3,3}, ~] = qr(AX{3,3}, 0);
[Q{3,4}, ~] = qr(AX{3,4}, 0);
M{3,3} = tensorprod(A{3,3}, Q{3,3},1, 1);
M{3,4} = tensorprod(A{3,4}, Q{3,4},1, 1);

QA{2,3} = tensorprod(A{2,3}, M{3,3}, 1, 1);
QA{2,3} = tensorprod(QA{2,3}, M{3,4}, 1, 1);
AX{2,3} = tensorprod(QA{2,3}, Right{2,3}, 1, 1);
AX{2,3} = reshape(AX{2,3}, [r^2, r]);
[Q{2,3}, ~] = qr(AX{2,3}, 0);
Q{2,3} = reshape(Q{2,3}, [r,r,r]);
M{2,3} = tensorprod(QA{2,3}, Q{2,3}, [2,3], [1,2]);

B = Q;
B{1,1} = A{1,1};
for i = 1:3
    B{1,1} = tensorprod(B{1,1}, M{2,i}, 1, 1);
end
