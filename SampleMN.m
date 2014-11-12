function S = SampleMN( M, U, V )

n = size(M,1);
Sv = kron( chol(V), chol(U) ) * randn(n^2,1);
S = reshape(Sv,n,n)+M;

end

