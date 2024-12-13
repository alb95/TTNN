
numerit = 30;
n = 500;
r = 70;
numit = 25;
rho = 0.3;

%% exponential decay

errNYS = zeros(1, numit);
errHMT = zeros(1, numit);
errSVD = zeros(1,numit);
AvarErrNys = zeros(1,numit);
AvarErrHmt = zeros(1, numit);
AvarErrSvd = zeros(1, numit);
timeNYS = zeros(1, numit);
timeHMT = zeros(1, numit);
timeSVD = zeros(1,numit);
AvarTimeNys = zeros(1,numit);
AvarTimeHmt = zeros(1, numit);
AvarTimeSvd = zeros(1, numit);
tx = zeros(1, numit);
ty = zeros(1, numit);

B = create_toy_example_TTN(n, r, 'exp', rho);
for numerix = 1:numerit
    for i = 1:numit
        rs = 2*i;
        ls = 10;
        tic
        X = toy_example_khatri_rao_X_sketchings(n, rs);
        tx(i) = toc;
        tic
        Y = toy_example_khatri_rao_Y_sketchings(n, rs,ls);
        ty(i) = toc;
        tic
        Enys = toy_example_khatri_rao_nystrom(B, X, Y, rs, ls);
        timeNYS(i) = toc;
        timeNYS(i) = timeNYS(i) + tx(i) + ty(i);
        tic
        Ehmt = toy_example_TTN_HMT(B, X, rs);
        timeHMT(i) = toc;
        timeHMT(i) = timeHMT(i) + tx(i);
        tic
        Esvd = toy_example_TTN_SVD(B, rs); 
        timeSVD(i) = toc;
        errNYS(i) = toy_example_norm(toy_example_difference(B, Enys))/toy_example_norm(B);
        errHMT(i) = toy_example_norm(toy_example_difference(B, Ehmt))/toy_example_norm(B);
        errSVD(i) = toy_example_norm(toy_example_difference(B, Esvd))/toy_example_norm(B);
    end
    AvarErrNys = AvarErrNys + errNYS/numerit;
    AvarErrHmt = AvarErrHmt + errHMT/numerit;
    AvarErrSvd = AvarErrSvd + errSVD/numerit;

    AvarTimeNys = AvarTimeNys + timeNYS/numerit;
    AvarTimeHmt = AvarTimeHmt + timeHMT/numerit;
    AvarTimeSvd = AvarTimeSvd + timeSVD/numerit;

end
    figure
    semilogy(2*(1:numit), AvarErrNys)
    hold on
    plot(2*(1:numit), AvarErrHmt)
    plot(2*(1:numit), AvarErrSvd)
    
    times = [2*(1:numit)', timeNYS', timeHMT', timeSVD'];
    avarage_times = [2*(1:numit)', AvarTimeNys', AvarTimeHmt', AvarTimeSvd'];
    accuracy = [2*(1:numit)', errNYS', errHMT',errSVD'];
    avarage_accuracy = [2*(1:numit)', AvarErrNys', AvarErrHmt',AvarErrSvd'];
    writematrix(times, 'toy_example_times_exp.csv');
    writematrix(avarage_times, 'toy_example_avarage_times_exp.csv');
    writematrix(accuracy, 'toy_example_accuracy_exp.csv');
    writematrix(avarage_accuracy, 'toy_example_avarage_accuracy_exp.csv');

%% linear decay

errNYS = zeros(1, numit);
errHMT = zeros(1, numit);
errSVD = zeros(1,numit);
AvarErrNys = zeros(1,numit);
AvarErrHmt = zeros(1, numit);
AvarErrSvd = zeros(1, numit);
timeNYS = zeros(1, numit);
timeHMT = zeros(1, numit);
timeSVD = zeros(1,numit);
AvarTimeNys = zeros(1,numit);
AvarTimeHmt = zeros(1, numit);
AvarTimeSvd = zeros(1, numit);
tx = zeros(1, numit);
ty = zeros(1, numit);

B = create_toy_example_TTN(n, r, 'linear', rho);
for numerix = 1:numerit
    for i = 1:numit
        rs = 2*i;
        ls = 10;
        tic
        X = toy_example_khatri_rao_X_sketchings(n, rs);
        tx(i) = toc;
        tic
        Y = toy_example_khatri_rao_Y_sketchings(n, rs,ls);
        ty(i) = toc;
        tic
        Enys = toy_example_khatri_rao_nystrom(B, X, Y, rs, ls);
        timeNYS(i) = toc;
        timeNYS(i) = timeNYS(i) + tx(i) + ty(i);
        tic
        Ehmt = toy_example_TTN_HMT(B, X, rs);
        timeHMT(i) = toc;
        timeHMT(i) = timeHMT(i) + tx(i);
        tic
        Esvd = toy_example_TTN_SVD(B, rs); 
        timeSVD(i) = toc;
        errNYS(i) = toy_example_norm(toy_example_difference(B, Enys))/toy_example_norm(B);
        errHMT(i) = toy_example_norm(toy_example_difference(B, Ehmt))/toy_example_norm(B);
        errSVD(i) = toy_example_norm(toy_example_difference(B, Esvd))/toy_example_norm(B);
    end
    AvarErrNys = AvarErrNys + errNYS/numerit;
    AvarErrHmt = AvarErrHmt + errHMT/numerit;
    AvarErrSvd = AvarErrSvd + errSVD/numerit;

    AvarTimeNys = AvarTimeNys + timeNYS/numerit;
    AvarTimeHmt = AvarTimeHmt + timeHMT/numerit;
    AvarTimeSvd = AvarTimeSvd + timeSVD/numerit;

end
    figure
    semilogy(2*(1:numit), AvarErrNys)
    hold on
    plot(2*(1:numit), AvarErrHmt)
    plot(2*(1:numit), AvarErrSvd)
    
    times = [2*(1:numit)', timeNYS', timeHMT', timeSVD'];
    avarage_times = [2*(1:numit)', AvarTimeNys', AvarTimeHmt', AvarTimeSvd'];
    accuracy = [2*(1:numit)', errNYS', errHMT',errSVD'];
    avarage_accuracy = [2*(1:numit)', AvarErrNys', AvarErrHmt',AvarErrSvd'];
    writematrix(times, 'toy_example_times_linear.csv');
    writematrix(avarage_times, 'toy_example_avarage_times_linear.csv');
    writematrix(accuracy, 'toy_example_accuracy_linear.csv');
    writematrix(avarage_accuracy, 'toy_example_avarage_accuracy_linear.csv');


%% quadratic decay

errNYS = zeros(1, numit);
errHMT = zeros(1, numit);
errSVD = zeros(1,numit);
AvarErrNys = zeros(1,numit);
AvarErrHmt = zeros(1, numit);
AvarErrSvd = zeros(1, numit);
timeNYS = zeros(1, numit);
timeHMT = zeros(1, numit);
timeSVD = zeros(1,numit);
AvarTimeNys = zeros(1,numit);
AvarTimeHmt = zeros(1, numit);
AvarTimeSvd = zeros(1, numit);
tx = zeros(1, numit);
ty = zeros(1, numit);

B = create_toy_example_TTN(n, r, 'quadratic', rho);
for numerix = 1:numerit
    for i = 1:numit
        rs = 2*i;
        ls = 10;
        tic
        X = toy_example_khatri_rao_X_sketchings(n, rs);
        tx(i) = toc;
        tic
        Y = toy_example_khatri_rao_Y_sketchings(n, rs,ls);
        ty(i) = toc;
        tic
        Enys = toy_example_khatri_rao_nystrom(B, X, Y, rs, ls);
        timeNYS(i) = toc;
        timeNYS(i) = timeNYS(i) + tx(i) + ty(i);
        tic
        Ehmt = toy_example_TTN_HMT(B, X, rs);
        timeHMT(i) = toc;
        timeHMT(i) = timeHMT(i) + tx(i);
        Esvd = toy_example_TTN_SVD(B, rs); 
        timeSVD(i) = toc;
        errNYS(i) = toy_example_norm(toy_example_difference(B, Enys))/toy_example_norm(B);
        errHMT(i) = toy_example_norm(toy_example_difference(B, Ehmt))/toy_example_norm(B);
        errSVD(i) = toy_example_norm(toy_example_difference(B, Esvd))/toy_example_norm(B);
    end
    AvarErrNys = AvarErrNys + errNYS/numerit;
    AvarErrHmt = AvarErrHmt + errHMT/numerit;
    AvarErrSvd = AvarErrSvd + errSVD/numerit;

    AvarTimeNys = AvarTimeNys + timeNYS/numerit;
    AvarTimeHmt = AvarTimeHmt + timeHMT/numerit;
    AvarTimeSvd = AvarTimeSvd + timeSVD/numerit;

end
    figure
    semilogy(2*(1:numit), AvarErrNys)
    hold on
    plot(2*(1:numit), AvarErrHmt)
    plot(2*(1:numit), AvarErrSvd)
    
    times = [2*(1:numit)', timeNYS', timeHMT', timeSVD'];
    avarage_times = [2*(1:numit)', AvarTimeNys', AvarTimeHmt', AvarTimeSvd'];
    accuracy = [2*(1:numit)', errNYS', errHMT',errSVD'];
    avarage_accuracy = [2*(1:numit)', AvarErrNys', AvarErrHmt',AvarErrSvd'];
    writematrix(times, 'toy_example_times_quadratic.csv');
    writematrix(avarage_times, 'toy_example_avarage_times_quadratic.csv');
    writematrix(accuracy, 'toy_example_accuracy_quadratic.csv');
    writematrix(avarage_accuracy, 'toy_example_avarage_accuracy_quadratic.csv');

%% cubic decay

errNYS = zeros(1, numit);
errHMT = zeros(1, numit);
errSVD = zeros(1,numit);
AvarErrNys = zeros(1,numit);
AvarErrHmt = zeros(1, numit);
AvarErrSvd = zeros(1, numit);
timeNYS = zeros(1, numit);
timeHMT = zeros(1, numit);
timeSVD = zeros(1,numit);
AvarTimeNys = zeros(1,numit);
AvarTimeHmt = zeros(1, numit);
AvarTimeSvd = zeros(1, numit);
tx = zeros(1, numit);
ty = zeros(1, numit);

B = create_toy_example_TTN(n, r, 'cubic', rho);
for numerix = 1:numerit
    for i = 1:numit
        rs = 2*i;
        ls = 10;
        tic
        X = toy_example_khatri_rao_X_sketchings(n, rs);
        tx(i) = toc;
        tic
        Y = toy_example_khatri_rao_Y_sketchings(n, rs,ls);
        ty(i) = toc;
        tic
        Enys = toy_example_khatri_rao_nystrom(B, X, Y, rs, ls);
        timeNYS(i) = toc;
        timeNYS(i) = timeNYS(i) + tx(i) + ty(i);
        tic
        Ehmt = toy_example_TTN_HMT(B, X, rs);
        timeHMT(i) = toc;
        timeHMT(i) = timeHMT(i) + tx(i);
        tic
        Esvd = toy_example_TTN_SVD(B, rs); 
        timeSVD(i) = toc;
        errNYS(i) = toy_example_norm(toy_example_difference(B, Enys))/toy_example_norm(B);
        errHMT(i) = toy_example_norm(toy_example_difference(B, Ehmt))/toy_example_norm(B);
        errSVD(i) = toy_example_norm(toy_example_difference(B, Esvd))/toy_example_norm(B);
    end
    AvarErrNys = AvarErrNys + errNYS/numerit;
    AvarErrHmt = AvarErrHmt + errHMT/numerit;
    AvarErrSvd = AvarErrSvd + errSVD/numerit;

    AvarTimeNys = AvarTimeNys + timeNYS/numerit;
    AvarTimeHmt = AvarTimeHmt + timeHMT/numerit;
    AvarTimeSvd = AvarTimeSvd + timeSVD/numerit;

end
    figure
    semilogy(2*(1:numit), AvarErrNys)
    hold on
    plot(2*(1:numit), AvarErrHmt)
    plot(2*(1:numit), AvarErrSvd)
    
    times = [2*(1:numit)', timeNYS', timeHMT', timeSVD'];
    avarage_times = [2*(1:numit)', AvarTimeNys', AvarTimeHmt', AvarTimeSvd'];
    accuracy = [2*(1:numit)', errNYS', errHMT',errSVD'];
    avarage_accuracy = [2*(1:numit)', AvarErrNys', AvarErrHmt',AvarErrSvd'];
    writematrix(times, 'toy_example_times_cubic.csv');
    writematrix(avarage_times, 'toy_example_avarage_times_cubic.csv');
    writematrix(accuracy, 'toy_example_accuracy_cubic.csv');
    writematrix(avarage_accuracy, 'toy_example_avarage_accuracy_cubic.csv');





