function [ Mt, Vt, invVt ] = FilterForA( X, PriorM, PriorV, Q, lambda, gamma, V )
%FilterForA Summary of this function goes here
%   Detailed explanation goes here

tind=2;
n = size(X,1);
T = size(X,2);

% Correct
invVt(:,:,tind) = inv(PriorV) + X(:,1)*X(:,1)';
Vt(:,:,tind)    = inv(invVt(:,:,tind));
Mt(:,:,tind)    = (PriorM/PriorV + X(:,2)*X(:,1)')/invVt(:,:,tind);

% Main loop
for tind = 3:T
    
    % Predict
    invVstar = (1/lambda)*inv(V) + invVt(:,:,tind-1);
    %Vpred = lambda*inv(eye(n) - (1/lambda)*inv(invVstar)*inv(V))*V;
    %Vpred = lambda*(V - inv(inv(V)-lambda*invVstar));
    Vpred = lambda*V+inv(invVt(:,:,tind-1));
    Mpred = ((1/lambda)*((Vpred/V)/invVstar)*invVt(:,:,tind-1)*Mt(:,:,tind-1)')';
    
    % Correct
    invVt(:,:,tind) = inv(Vpred) + (1/gamma)*X(:,tind-1)*X(:,tind-1)';
    Vt(:,:,tind)    = inv(invVt(:,:,tind));
    Mt(:,:,tind)    = (Mpred/Vpred + (1/gamma)*X(:,tind)*X(:,tind-1)')/invVt(:,:,tind);
    
end



end

