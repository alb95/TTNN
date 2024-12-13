load('6D_Hilbert.mat') % create the 6D tensor H of size 20.
n = 20;
r = 7;
l = 3;

tic
[X, Y] = toy_example_sketchings(n, r, l);
B = toy_example_nystrom(H, X, Y, r, l);
toc
tic
BS = toy_example_sequential_nystrom(H, XS, YS, r, l);
[XS, YS] = toy_example_sequential_sketchings(n, r, l);
toc

T = toy_example_from_TTN_to_tensor(B);
TS = toy_example_from_TTN_to_tensor(BS);
err = norm(H-T,'fro')/norm(H,'fro')
errS = norm(H-TS, 'fro')/norm(H, 'fro')

