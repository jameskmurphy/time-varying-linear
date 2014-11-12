function As = GibbsSampler( NumSamples, X, Q, lambda, V, Atrue, DO_VIS )
%GIBBSSAMPLER Summary of this function goes here
%   Detailed explanation goes here

n = size(X,1);
T = size(X,2);

PriorM = zeros(n);
PriorV = 100*eye(n);

As = zeros(n,n,T,NumSamples);


for s=1:NumSamples

    [ Mt, Vt, invVt ] = FilterForA( X, PriorM, PriorV, Q, lambda, V );
    As(:,:,:,s) = SampleA( Mt, invVt, Q, lambda, V );
    
    
    if DO_VIS && mod(s,10)==0 
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
                plot(squeeze(Atrue(i,j,2:T)), 'r-');
            end
        end
        figure(3);
        for i=1:n
            for j=1:n
                subplot(n,n,(i-1)*n+j);
                cla;
                hold on;
                visPathDensityLines( 2, 1, squeeze(As(i,j,2:T,max(1,s-500):end))', 'b-', 'b--'  )
                plot(squeeze(Atrue(i,j,2:T)), 'r-');
            end
        end
    end
end



end

