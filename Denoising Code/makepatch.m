function [ patchCell, newMatSize ] = makepatch(inputImage,patchSize,percentageOverlap)
% Helper function to extract patches of size patchSize from images 
% with percentage overlap between any two consecutive patches given as
% input
% Outputs:
% patchCell- A cell containing all the patches,
% newMatSize - size of new image after zero padding

	inputImage=double(inputImage);
	N=double(size(inputImage));
	L=percentageOverlap*patchSize; % 50% overlap

	%Number of patches per row and column
	P=ceil((N-L)/(patchSize-L));

	%size of new matrix N'
	newMatSize=(patchSize-L)*P+L;

	zp=newMatSize-N;
	%zero padding when needed
	inputImage=[inputImage,zeros(N(1),zp(2))];
	inputImage=[inputImage;zeros(zp(1),newMatSize(2))];
	%patches stored in cell C
	patchCell=cell(P);
	for i=1:P(1)
		for j=1:P(2)
			patchCell{i,j}=inputImage((patchSize-L)*(i-1)+1:(i*patchSize-(i-1)*L),(patchSize-L)*(j-1)+1:(j*patchSize-(j-1)*L));
		end
	end

end

