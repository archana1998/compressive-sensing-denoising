function [fullImage ] = stackcol( patchCell )
% Code that reads patches from a cell, reshapes patches to column arrays
% and stacks all the patches side by side
% each column in fullImage is a patch from patchCell, and all patches are
% stacked columnwise

	n=size(patchCell);
	nc=numel(patchCell{1,1});
	fullImage=zeros(nc,n(1)*n(2));
	for i=1:n(1)
		for j=1:n(2)
		  fullImage(:,j+n(2)*(i-1))= reshape(patchCell{i,j},nc,1);
		end
	end
end
