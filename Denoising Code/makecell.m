function [patchCell] = makecell( fillImage,patchSize,newMatSize)
% code that stores all the patches from Y in a cell
%     fillImage = derivedStackedIm1;
%     newMatSize = size(C1);
	n=size(fillImage,2);
	patchCell=cell(newMatSize);
	for i=1:n
		if mod(i,newMatSize(2))==0
		   patchCell{floor(i/newMatSize(2)),newMatSize(2)}=reshape(fillImage(:,i),patchSize,patchSize);
		else
		   patchCell{floor(i/newMatSize(2))+1,mod(i,newMatSize(2))}=reshape(fillImage(:,i),patchSize,patchSize);
		end
	end
end