function [ noisyImage ] =addnoise( inputImage,sigma,PSNR)
% Adds Guassian noise of variance sigma^2 with a % specified PSNR to a given
% input image

	guassianNoiseImage=imnoise(zeros(size(inputImage)),'gaussian',0,sigma*sigma);
	originalPower=sum(sum(guassianNoiseImage.^2))/numel(guassianNoiseImage);
	desiredPower=255*255*10^(-PSNR/10);
	%Scaling the PSNR of guassianNoiseImage
	guassianNoiseImage=sqrt(desiredPower/originalPower)*guassianNoiseImage;
	noisyImage =inputImage+uint8(guassianNoiseImage);
end

