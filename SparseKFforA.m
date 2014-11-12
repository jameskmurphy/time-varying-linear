function [ Mt, Mtm, Covv ] = KFforA( X, PriorM, PriorV, Q, lambda, V )
%KFFORA Summary of this function goes here
%   Detailed explanation goes here

n = size(X,1);
T = size(X,2);


QQ = kron(V, lambda*Q);
R  = Q;
F  = eye(n^2);

PriorMu = PriorM(:);
PriorCov = kron(PriorV, Q);
H = sparse(MakeH(X(:,1)));

% correct
K = PriorCov*H'/(H*PriorCov*H' + R);
Mt(:,2)  = PriorMu+K*( X(:,2)-H*PriorMu );
Mtm(:,:,2) = reshape(Mt(:,2),n,n);
Covv(:,:,2) = (eye(n^2) - K*H)*PriorCov;

% main loop
for t=3:T
    % predict
    xpred = F*Mt(:,t-1);
    covpred = F*Covv(:,:,t-1)*F' + QQ;
    
    % correct
    H = sparse(MakeH(X(:,t-1)));
    K = covpred*H'/(H*covpred*H' + R);
    Mt(:,t)  = xpred+K*( X(:,t)-H*xpred );
    Mtm(:,:,t) = reshape(Mt(:,t),n,n);
    Covv(:,:,t) = (eye(n^2) - K*H)*covpred;
end
end

function H = MakeH(X)
n = size(X,1);
H = zeros(n,n^2);
for i=1:n
    H( :,(i-1)*n+1:i*n) = X(i)*eye(n);
end
end