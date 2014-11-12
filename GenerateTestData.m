function [ A,X ] = GenerateTestData( T, PriorM, PriorV, PriorXMu, PriorXCov, Q,lambda,gamma,V )
%GENERATETESTDATA Summary of this function goes here
%   Detailed explanation goes here

n = numel(PriorXMu);
X(:,1) = mvnrnd(PriorXMu, PriorXCov)';
A(:,:,2) = SampleMN(PriorM, Q, PriorV);

for t=2:T

    X(:,t) = A(:,:,t)*X(:,t-1) + mvnrnd(zeros(n,1), gamma*Q)';
    if t<T
        GT1 = true;
        while GT1
            A(:,:,t+1) = A(:,:,t) + SampleMN(zeros(n), lambda*Q, V); 

            % force stability
            AA = A(:,:,t+1);
            [~, D] = eig(AA);
            GT1 = max(abs(diag(D)))>0.9;
        end
            
    end
    
    
end

end

