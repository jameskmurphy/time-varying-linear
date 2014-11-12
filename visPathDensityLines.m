function [ output_args ] = visPathDensityLines( xstart, xstep, paths, meanlinespec, stdlinespec, fill  )
%VISPATHDENSITY Summary of this function goes here
%   Detailed explanation goes here

colmax = max(paths);
colmin = min(paths);

T = size(paths,2);
if fill
    %visFillBetweenLines(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 3*std(paths), mean(paths) + 3*std(paths), [0.8 0.8 0.8], false);
    visFillBetweenLines(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 2*std(paths), mean(paths) + 2*std(paths), [0.7 0.7 0.7], false);
    %visFillBetweenLines(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 1*std(paths), mean(paths) + 1*std(paths), [0.3 0.3 0.3], false);
end

if meanlinespec
    plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths), meanlinespec);
end
if stdlinespec
    %plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) + 1*std(paths), stdlinespec);
    %plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 1*std(paths), stdlinespec);
    
    plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) + 2*std(paths), stdlinespec);
    plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 2*std(paths), stdlinespec);
    
    %plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) + 3*std(paths), stdlinespec);
    %plot(xstart:xstep:(xstart+((T-1)*xstep)), mean(paths) - 3*std(paths), stdlinespec);
end


end

