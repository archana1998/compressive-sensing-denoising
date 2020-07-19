function [ Rij] = Rijmat(i,j,patchSize,percentageOverlap,newMatSize)
%Creating Rij matrix

	L=percentageOverlap*patchSize;
	Rij=sparse(patchSize*patchSize,prod(newMatSize));

	I=zeros(newMatSize);
	I((patchSize-L)*(i-1)+1:(i*patchSize-(i-1)*L),(patchSize-L)*(j-1)+1:(j*patchSize-(j-1)*L))=ones(patchSize,patchSize);
	I=reshape(I,prod(newMatSize),1);
	f=find(I);
	for i=1:patchSize*patchSize
		Rij(i,f(i))=1;
	end

end