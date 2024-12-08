function [X, Y] = toy_example_khatri_rao_sketchings(n, r, l)

%% Create the X sketchings
X = cell(1,6);
for j = 1:6
    X{j} = randn(n, r);
end
%% Create the Y sketchings
Y = cell(1,6);
for j = 1:6
    Y{j} = randn(n, r+l);
end
end



