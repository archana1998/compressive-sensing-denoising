function [ A ] = reconstr( C,w,po,N1)
%This function reconstructs an image given its component patches in a cell
% Inputs:C-cell,w is patch size, po is percentage overlap in fractions,N1 is N'
% Outputs: A- reconstructed image
	A=double(zeros(N1));%blank image onto which patches are overlapped and added
	B=double(zeros(N1));%blank image onto which extent of overlapis recorded
	L=po*w;
	P=size(C);%No. of patches
	for i=1:P(1)
		for j=1:P(2)
			  A((w-L)*(i-1)+1:(i*w-(i-1)*L),(w-L)*(j-1)+1:(j*w-(j-1)*L))= A((w-L)*(i-1)+1:(i*w-(i-1)*L),(w-L)*(j-1)+1:(j*w-(j-1)*L))+C{i,j};
			  B((w-L)*(i-1)+1:(i*w-(i-1)*L),(w-L)*(j-1)+1:(j*w-(j-1)*L))= B((w-L)*(i-1)+1:(i*w-(i-1)*L),(w-L)*(j-1)+1:(j*w-(j-1)*L))+ones(w,w);
		end
	end
	A=A./B;
end

