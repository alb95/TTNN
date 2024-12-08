function Y = toy_example_khatri_rao_Y_sketchings(n, r, l)

%% Create the Y sketchings
Y = cell(1,6);
for j = 1:6
    Y{j} = randn(n, r+l);
end
end

