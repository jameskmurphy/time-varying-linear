function As = SampleA( Mt, invVt, Q, lambda, V )
%SAMPLEA Summary of this function goes here
%   Detailed explanation goes here

T = size(Mt,3);

As(:,:,T) = SampleMN(Mt(:,:,T), Q, inv(invVt(:,:,T)));

for t=T-1:-1:2
    invVstar = inv(V)/lambda + invVt(:,:,t);
    Mstar = (Mt(:,:,t)*invVt(:,:,t) + (1/lambda)*As(:,:,t+1)/V)/invVstar;
    As(:,:,t) = SampleMN(Mstar, Q, inv(invVstar));
end

end

