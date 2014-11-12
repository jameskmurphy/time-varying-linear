function As = GibbsSampler( X, Q, lambda, gamma, V, Atrue )
%GIBBSSAMPLER Summary of this function goes here
%   Detailed explanation goes here

NumSamples = 2000;

n = size(X,1);
T = size(X,2);

PriorM = zeros(n);
PriorV = 100*eye(n);

[ Mt, Vt, invVt ] = FilterForA( X, PriorM, PriorV, Q, lambda, gamma, V );
[ MtKFv, Mtm, Covv ] =     KFforA( X, PriorM, PriorV, Q, lambda, gamma, V );
figure(4);clf;
for i=1:n
    for j=1:n
        subplot(n,n,(i-1)*n+j);
        cla;
        hold on;
        plot(squeeze(Mt(i,j,2:T)), 'b-');
        
        cc = squeeze(Vt(i,i,:))*Q(j,j);
        plot(squeeze(Mt(i,j,2:T)) + 2*sqrt(cc(2:T)), 'b-', 'color', [0.5 0.5 1]);
        plot(squeeze(Mt(i,j,2:T)) - 2*sqrt(cc(2:T)), 'b-', 'color', [0.5 0.5 1]);
        
        
        plot(squeeze(Mtm(i,j,2:T)), 'g:');
        ijix = (i-1)*n+j;
        cckf = squeeze(Covv(ijix,ijix,:));
        plot(squeeze(Mtm(i,j,2:T)) + 2*sqrt(cckf(2:T)), 'b:', 'color', [0.5 1 0.5]);
        plot(squeeze(Mtm(i,j,2:T)) - 2*sqrt(cckf(2:T)), 'b:', 'color', [0.5 1 0.5]);
        
        plot(squeeze(Atrue(i,j,2:T)), 'b-');
    end
end


for s=1:NumSamples

    As(:,:,:,s) = SampleA( Mt, invVt, Q, lambda, V );
    [~, AsKF(:,:,:,s)] = SampleAKF( MtKFv, Covv, Q, lambda, V );
    
    
    if(mod(s,100)==0)
        figure(3);
        for i=1:n
            for j=1:n
                subplot(n,n,(i-1)*n+j);
                cla;
                hold on;
                visPathDensityLines( 2, 1, squeeze(AsKF(i,j,2:T,1:end))', false, false, true  )
                visPathDensityLines( 2, 1, squeeze(As(i,j,2:T,1:end))', false, 'k-', false  )
                plot(2:T, squeeze(Atrue(i,j,2:T)), 'b-');
                axis tight;
            end
        end
    end
end



end

