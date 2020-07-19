function [ C1 ] = denoise(Xc,D,patchSize,percentageOverlap,T,eps,iters )
%D  : dictionary of atoms of size n × K
%T  : sparsity threshold
%eps: error tolerance
%iter: number of iterations to run.
%First iteration cleans up the image by a large margin. 
%Subsequent iterations incrementally improve quality 
    sigma=eps/1.15;
    lambda=30/sigma;



    Y1=double(reshape(Xc,numel(Xc),1));
    sum1=sparse(size(Y1,1),size(Y1,1));
    L=percentageOverlap*patchSize;
    C1=cell(1,iters);

    for k=1:iters
        [C,N1]=makepatch(Xc,patchSize,percentageOverlap);
        Y=stackcol(C);
        for l=1:size(Y,2)
            X(:,l)=OMP(Y(:,l),D,T,eps);
        end
        if k==1
            for i=1:size(C,1)
                for j=1:size(C,2)
                    Rij=Rijmat(i,j,patchSize,percentageOverlap,N1);
                    sum1=sum1+Rij'*Rij;
                end
            end
            I=speye(numel(Xc));
            T1=lambda*I+sum1;
        end

        sum2=sparse(size(Y1,1),1);
        for i=1:size(C,1)
            for j=1:size(C,2)
                Rij=Rijmat(i,j,patchSize,percentageOverlap,N1);
                sum2=sum2+Rij'*(D*X(:,(i-1)*size(C,2)+j));
            end
        end

        T2=lambda*Y1+sum2;
        Q=T1\T2;
        Xc=uint8(reshape(Q,N1));
        C1{1,k}=Xc;

    end

end

