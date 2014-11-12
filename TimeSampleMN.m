function [ output_args ] = TimeSampleMN( input_args )
%TIMESAMPLEMN Summary of this function goes here
%   Detailed explanation goes here

ns = 5:5:200;


for i=1:numel(ns)
    n = ns(i);
    tic
    S = SampleMN(zeros(n), eye(n), eye(n));
    ts(i) = toc;
end

clf;
hold on;
plot(log(ns), log(ts));
plot([log(ns(1)) log(ns(end))], [log(ts(1)), 4*(log(ns(end))-log(ns(1)))], 'r-');



end

