function S = toy_example_difference(B, C)
% sum of tensors in TTN_TOY_format

S = cell(4, 4);
S{4,1} = [B{4,1}, C{4,1}];
S{4,2} = [B{4,2}, C{4,2}];
S{3,2} = [B{3,2}, C{3,2}];
S{3,3} = [B{3,3}, C{3,3}];
S{3,4} = [B{3,4}, C{3,4}];
S{2,2} = [B{2,2}, C{2,2}];

rb = size(B{3,1});
rc = size(C{3,1});
S{3, 1} = zeros(rb+rc);
S{3, 1}(1:rb(1),1:rb(2),1:rb(3)) = B{3,1};
S{3, 1}(rb(1)+1:rb(1)+rc(1), rb(2)+1:rb(2)+rc(2), rb(3)+1:rb(3)+rc(3)) = C{3,1};

rb = size(B{2,1});
rc = size(C{2,1});
S{2, 1} = zeros(rb+rc);
S{2, 1}(1:rb(1),1:rb(2),1:rb(3)) = B{2,1};
S{2, 1}(rb(1)+1:rb(1)+rc(1), rb(2)+1:rb(2)+rc(2), rb(3)+1:rb(3)+rc(3)) = C{2,1};

rb = size(B{2,3});
rc = size(C{2,3});
S{2, 3} = zeros(rb+rc);
S{2, 3}(1:rb(1),1:rb(2),1:rb(3)) = B{2,3};
S{2, 3}(rb(1)+1:rb(1)+rc(1), rb(2)+1:rb(2)+rc(2), rb(3)+1:rb(3)+rc(3)) = C{2,3};

rb = size(B{1,1});
rc = size(C{1,1});
S{1, 1} = zeros(rb+rc);
S{1, 1}(1:rb(1),1:rb(2),1:rb(3)) = B{1,1};
S{1, 1}(rb(1)+1:rb(1)+rc(1), rb(2)+1:rb(2)+rc(2), rb(3)+1:rb(3)+rc(3)) = -C{1,1};


