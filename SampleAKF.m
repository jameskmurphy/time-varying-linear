function [ As, Asm ] = SampleAKF( XhatKK, CovhatKK, Q, lambda, V  )
%SAMPLEAKF Summary of this function goes here
%   Detailed explanation goes here
n = sqrt(size(XhatKK, 1));
T = size(XhatKK, 2);
Cu = kron(V, lambda*Q);
A  = eye(n^2);


As(:,T) = mvnrnd(XhatKK(:,T), max(CovhatKK(:,:,T), CovhatKK(:,:,T)'));
Asm(:,:,T) = reshape(As(:,T), n,n);
mut(:,T) = XhatKK(:,T);
Sigmat(:,:,T) = max(CovhatKK(:,:,T), CovhatKK(:,:,T)');

for t=T-1:-1:2
    
    InvSigmat = inv(CovhatKK(:,:,t)) + A'/Cu*A;
    mut(:,t) = InvSigmat \ (CovhatKK(:,:,t)\XhatKK(:,t) + A'/Cu*As(:,t+1));
    
    Sigmatt = inv(InvSigmat);
    Sigmat(:,:,t) = max(Sigmatt, Sigmatt');  % can go non-symmetric due to numerical errors

    As(:,t) = mvnrnd(mut(:,t), Sigmat(:,:,t));
    Asm(:,:,t) = reshape(As(:,t), n,n);
end

end

