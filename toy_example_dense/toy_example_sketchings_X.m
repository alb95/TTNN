function X = toy_example_sketchings_X(n, r)

%% Create the X sketchings
X = cell(3,4);
X{1,1} = randn([ones(1,3)*n, r]);
X{1,2} = randn([ones(1,5)*n, r]);
X{1,3} = randn([ones(1,4)*n, r]);
X{2,1} = randn([ones(1,4)*n, r]);
X{2,2} = randn([ones(1,5)*n, r]);
X{2,3} = randn([ones(1,5)*n, r]);
X{2,4} = randn([ones(1,5)*n, r]);
X{3,1} = randn([ones(1,5)*n, r]);
X{3,2} = randn([ones(1,5)*n, r]);
end
