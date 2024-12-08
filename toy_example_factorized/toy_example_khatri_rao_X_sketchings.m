function X = toy_example_khatri_rao_X_sketchings(n, r)

%% Create the X sketchings
X = cell(1,6);
for j = 1:6
    X{j} = randn(n, r);
end
end

