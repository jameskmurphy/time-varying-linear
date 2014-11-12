function AsKF = GibbsSamplerKF( NumSamples, X, Q, lambda, V, Atrue, DO_VIS )
%GIBBSSAMPLER Summary of this function goes here
%   Detailed explanation goes here

n = size(X,1);
T = size(X,2);

PriorM = zeros(n);
PriorV = 100*eye(n);

AsKF = zeros(n,n,T,NumSamples);

for s=1:NumSamples

    [ MtKFv, Mtm, Covv ] = SparseKFforA( X, PriorM, PriorV, Q, lambda, V );
    [~, AsKF(:,:,:,s)] = SampleAKF( MtKFv, Covv, Q, lambda, V );
    
    if DO_VIS && mod(s,10)==0
    figure(4);clf; 
        for i=1:n
            for j=1:n
                subplot(n,n,(i-1)*n+j);
                cla;
                hold on;
                plot(squeeze(Mtm(i,j,2:T)), 'g:');
                ijix = (i-1)*n+j;
                cckf = squeeze(Covv(ijix,ijix,:));
                plot(squeeze(Mtm(i,j,2:T)) + 2*sqrt(cckf(2:T)), 'b:', 'color', [0.5 1 0.5]);
                plot(squeeze(Mtm(i,j,2:T)) - 2*sqrt(cckf(2:T)), 'b:', 'color', [0.5 1 0.5]);

                plot(squeeze(Atrue(i,j,2:T)), 'r-');
            end
        end
        figure(3);
        for i=1:n
            for j=1:n
                subplot(n,n,(i-1)*n+j);
                cla;
                hold on;
                visPathDensityLines( 2, 1, squeeze(AsKF(i,j,2:T,max(1,s-500):end))', 'g-', 'g--'  )
                plot(squeeze(Atrue(i,j,2:T)), 'r-');
            end
        end
    end
end



end

