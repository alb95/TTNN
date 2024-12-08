function Y = toy_example_sketchings_Y(n, r, l)
%% Create the Y sketchings
Y = cell(3,4);
Y{1,1} = randn([ones(1,3)*n, r+l]);
Y{1,2} = randn(n,r+l);
Y{1,3} = randn([ones(1,2)*n, r+l]);
Y{2,1} = randn([ones(1,2)*n, r+l]);
Y{2,2} = randn(n, r+l);
Y{2,3} = randn(n, r+l);
Y{2,4} = randn(n, r+l);
Y{3,1} = randn(n, r+l);
Y{3,2} = randn(n, r+l);
end
