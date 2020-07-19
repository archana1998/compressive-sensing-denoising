function [x] = OMP(y,D,T,eps)
%y  : input signal
%D  : Overcomplete DCT dictionary
%T  : sparsity threshold
%eps: error tolerance
%x  : Sparse representation of y using basis vectors from dictionary D
	r=y;
	K=size(D,2);
	l=[];
	k=0;
	x = zeros(K,1);
	while(k<T)
		p = D'*r;
		i = find(abs(p)==max(abs(p)),1);
		l = [l,i];
		k=k+1;
		Dk = D(:,l);
		xk=pinv(Dk)*y;
		r=y-Dk*xk;
		if norm(r)<sqrt(eps)
			 break;
		end
	end
	x(l)=xk;
	
end

