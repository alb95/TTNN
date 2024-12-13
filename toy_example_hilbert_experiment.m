n = 20;
H = create_hilbert_tensor(n, 6);
l = 3;
numit = 13;
errB = zeros(1,numit-1);
errC = zeros(1,numit-1);
errD = zeros(1,numit-1);
errE = zeros(1,numit-1);

tB = zeros(1,numit-1);
tC = zeros(1,numit-1);
tD = zeros(1,numit-1);
tE = zeros(1,numit-1);
tx = zeros(1,numit-1);
ty = zeros(1,numit-1);

tBtot = 0;
tCtot = 0;
tDtot = 0;
tEtot = 0;

eBtot = 0;
eCtot = 0;
eDtot = 0;
eEtot = 0;

tseqxy = zeros(1,numit-1);
normH = norm(H, 'fro');
numerit = 30;

for numero=1:numerit
    for r = 2:numit
    
        tic
        X = toy_example_sketchings_X(n, r);
        tx(r-1) = toc;
    
        tic
        Y = toy_example_sketchings_Y(n, r,l);
        ty(r-1) = toc;
    
        tic
        B = toy_example_nystrom(H, X, Y, r, l);
        tB(r-1) = toc;
        tB(r-1) = tB(r-1) + tx(r-1) + ty(r-1);
        denseB = toy_example_from_TTN_to_tensor(B);
    
        tic
        [Xs, Ys] = toy_example_sequential_sketchings(n, r, l);
        tseqxy(r-1) = toc;
        tic
        C = toy_example_sequential_nystrom(H, Xs, Ys, r, l);
        tC(r-1) = toc;
        tC(r-1) = tC(r-1)+ tseqxy(r-1);
        denseC = toy_example_from_TTN_to_tensor(C);
    
        tic
        D = toy_example_SVD(H, r);
        tD(r-1) = toc;
        denseD = toy_example_from_TTN_to_tensor(D);
    
        tic
        E = toy_example_HMT(H, X, r);
        tE(r-1) = toc;
        tE(r-1) = tE(r-1)+tx(r-1);
    
        denseE = toy_example_from_TTN_to_tensor(E);
    
        errB(r-1) = norm(H-denseB, 'fro')/normH;
        errC(r-1) = norm(H-denseC, 'fro')/normH;
        errD(r-1) = norm(H-denseD, 'fro')/normH;
        errE(r-1) = norm(H-denseE, 'fro')/normH;
    end
tBtot = tB + tBtot;
tCtot = tC + tCtot;
tDtot = tD + tDtot;
tEtot = tE + tEtot;

eBtot = errB + eBtot;
eCtot = errC + eCtot;
eDtot = errD + eDtot;
eEtot = errE + eEtot;
end
tBtot = tBtot/numerit;
tCtot = tCtot/numerit;
tDtot = tDtot/numerit;
tEtot = tEtot/numerit;

eBtot = eBtot/numerit;
eCtot = eCtot/numerit;
eDtot = eDtot/numerit;
eEtot = eEtot/numerit;


tsketch = [(2:numit)', tx'+ty', tseqxy', tx'];
talg = [(2:numit)', tB'-tx'-ty', tC'-tseqxy', tD', tE'-tx'];
accuracy = [(2:numit)', errB', errC', errD', errE'];
total_accuracy = [(2:numit)', eBtot', eCtot', eDtot', eEtot'];
times = [(2:numit)', tB', tC', tD', tE'];
total_times = [(2:numit)', tBtot', tCtot', tDtot', tEtot'];
semilogy(2:numit, errB)
hold on
plot(2:numit, errC)
plot(2:numit, errD)
plot(2:numit, errE)

figure
plot(2:numit, tB)
hold on
plot(2:numit, tC)
plot(2:numit, tD)
plot(2:numit, tE)


writematrix(accuracy, '6D_Hilbert_accuracy.csv');
writematrix(total_accuracy, '6D_Hilbert_avaraged_accuracy.csv');
writematrix(times, '6D_Hilbert_time.csv');
writematrix(total_times, '6D_Hilbert_avaraged_times.csv');
writematrix(tsketch, '6D_Hilbert_time_sketchings.csv');
writematrix(talg, '6D_Hilbert_time_algorithms.csv');
