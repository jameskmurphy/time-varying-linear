function [ output_args ] = RunTest( input_args )
%RUNTEST Summary of this function goes here
%   Detailed explanation goes here

n=3;
T = 300;
PriorM = [0.7 0.3 0 0.3; 0.4 0.1 0.1 -0.2; 0.2 0.2 0.4 -0.3; 0.1 -0.3 0.4 0.5];
%PriorM = (1-2*rand(n))*0.00;
PriorM = PriorM(1:n,1:n);
PriorV = 0.0001*eye(n);
PriorXMu = zeros(n,1);
PriorXCov = eye(n);
Q = 0.1*eye(n);
lambda = 10;
gamma = 1e6;
V = 0.01*eye(n);


[ A,X ] = GenerateTestData( T, PriorM, PriorV, PriorXMu, PriorXCov, Q,lambda,gamma, V );

figure(1);
plot(X')
figure(2);
for i=1:n
    for j=1:n
        subplot(n,n,(i-1)*n+j);
        plot(squeeze(A(i,j,2:end)));
    end
end


GibbsSampler(X,Q,lambda,gamma, V, A);

end

