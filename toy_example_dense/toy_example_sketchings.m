function [X, Y] = toy_example_sketchings(n, r, l)

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

