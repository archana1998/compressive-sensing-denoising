%plot1 psnr vs iterations
inputImage=imread('lena256.jpg');

%Sigma and PSNR for zero mean guassian noise
sigmaNoise=10;PSNRNoise=30;

%Addin noise to image. Calculating MSE wrt inputImage
noisyImage = addnoise(inputImage,sigmaNoise,PSNRNoise);

noisyImageMSE = sum(sum((noisyImage-inputImage).^2))/numel(inputImage)

noisyImage = double(noisyImage);
%Denoising imageand comparing MSE wrt inputImage 
patchSize=16;percentageOverlap=0.5;T=6;eps=11.5;
load('Dictionary.mat','Dictionary');
output=denoise(noisyImage,Dictionary,patchSize,percentageOverlap,T,eps,4);
denoised_img = output{1,2};
denoisedImageMSE = sum(sum((output{1,2}-inputImage).^2))/numel(inputImage)