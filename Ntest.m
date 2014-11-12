function [ output_args ] = Ntest( input_args )
%RUNTEST Summary of this function goes here
%   Detailed explanation goes here
T = 300;

Nmax = 70;

for n=1:Nmax

    %PriorM = [0.7 0.3 0 0.3; 0.4 0.1 0.1 -0.2; 0.2 0.2 0.4 -0.3; 0.1 -0.3 0.4 0.5];
    PriorM = (1-2*rand(n))*0.00;
    PriorM = PriorM(1:n,1:n);
    PriorV = 0.0001*eye(n);
    PriorXMu = zeros(n,1);
    PriorXCov = eye(n);
    Q = 0.1*eye(n);
    lambda = 0.001;
    V = 0.001*eye(n);
    [ A,X ] = GenerateTestData( T, PriorM, PriorV, PriorXMu, PriorXCov, Q,lambda,V );

    tic
    GibbsSamplerMN(10, X,Q,lambda,V, A, false);
    MNtime(n) = toc;

    if(n<=30)
        tic
        GibbsSamplerKF(10, X,Q,lambda,V, A, false);
        KFtime(n) = toc;
    end
    
    figure(1);clf; hold on;
    plot(1:numel(MNtime),MNtime/10, 'r-x');
    plot(1:numel(KFtime),KFtime/10, 'b-x');
    
    x=[1,Nmax+10];
    plot(x, 1e-6*x.^4, 'r-', 'color', [1 0.7 0.7]);
    plot(x, 1e-5*x.^4, 'r-', 'color', [1 0.7 0.7]);
    plot(x, 1e-7*x.^6, 'b-', 'color', [0.7 0.7 1]);
    plot(x, 1e-6*x.^6, 'b-', 'color', [0.7 0.7 1]);
    plot(x, 1e-5*x.^6, 'b-', 'color', [0.7 0.7 1]);
    
    set(gca, 'XScale','log');
    set(gca, 'YScale','log');
    legend('Matrix-Normal filter', 'Standard KF', '\propto n^4', '\propto n^6');
    xlabel('System Dimension (n)');
    ylabel('Running time per filter+sample (s)');
    drawnow;
end


end

