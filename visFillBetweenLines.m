function visFillBetweenLines( xs, L, U, col, drawoutline )

hold on;
X = [xs fliplr(xs)];
Y = [U fliplr(L)];

fill(X,Y, repmat(col,size(X,1),1),'linestyle','none');%col);

if(drawoutline)
    plot(xs, U, 'k-');
    plot(xs, L, 'k-');
end

end

