function [D, X ] = KSVD( Y,D,K,T,eps,N )
%Updates dictionary 
%Y  : image used to train dictionary
%D  : dictionary of atoms of size n × K
%T  : sparsity threshold
%eps: error tolerance
%K  : number of atoms in dictionary
%N  : number of k-svd iterations to run
%X  : Sparse representation of Y
	tic;
	
	%Uncomment for observing Dictionary for each iteration
	%dictFile='dictionaries\dict000.tif';
	
	n = size(D,1); %Number of elements of Dictionary
	M=size(Y,2);
	X=zeros(K,M);
	for i=1:N
		for l=1:N
			X(:,l)=OMP(Y(:,l),D,T,eps);
		end
		disp('iteration ');disp(i);
		for j=1:K
		   idx = find(X(j,:));
			if isempty(idx)
				E=Y-D*X;
				check = sum(E.^2,1);
				ind = find(check ==max(check),1);
				X(j,:)=zeros(1,M);
				D(:,j)=Y(:,ind)/norm(Y(:,ind));
			else 
				X(j,:)=zeros(1,M);
				E=Y-D*X;
				Ek = E(:,idx);
				[U, S, V]=svd(Ek);
				X(j,idx)=S(1,1)*V(:,1)'; 
				D(:,j)=U(:,1)/norm(U(:,1));
			end
		end
		%Uncomment for observing Dictionary for each iteration
		%op = [];
		%for l = 1:sqrt(K)
		%	op1 = []; 
		%	for k = 1:sqrt(K)
		%		op1 = [op1;reshape(D(:,k),sqrt(n),sqrt(n))];
		%	end
		%op = [op,op1];
		%end
		%op = (op-min(op(:)))/(max(op(:))-min(op(:)));
		%dictFile(18:20)=sprintf('%.0f%0.f%0.f',(mod(i,1000)-mod(i,100))/100,(mod(i,100)-mod(i,10))/10,mod(i,10));
		%imwrite(op,dictFile);
	end
	toc;

end
