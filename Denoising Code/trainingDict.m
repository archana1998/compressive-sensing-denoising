clc;
clear all;
load('A1.mat')
patchSize=16;percentageOverlap=0.5;T=6;eps=11.5;

ps2=patchSize^2;numAtoms=256;
Dictionary=A1; %Ramanujan Dictionary of size 256*256

Im1=imread('boat256.bmp');
[C1 N1]=makepatch(Im1,patchSize,percentageOverlap);
stackedIm1 = stackcol(C1);

Im2=imread('lena256.jpg');
[C2 N2]=makepatch(Im2,patchSize,percentageOverlap);
stackedIm2 = stackcol(C2);

Im3=imread('barbara256.jpg');
[C3 N3]=makepatch(Im3,patchSize,percentageOverlap);
stackedIm3 = stackcol(C3);


trainingData=[stackedIm1,stackedIm2,stackedIm3];
numIter = size(trainingData,2);

%Training Dictionary using above 3 images 

%[Dictionary SparseData]=KSVD(trainingData,Dictionary,ps2,T,eps,numIter);
%(trains dictionary, takes hours to run. I have saved the matrices after
%training)
% save('Dictionary.mat','Dictionary');
% save('SparseData.mat','SparseData');
%Reconstructing Training Data Set with sparse representation
load('Dictionary.mat','Dictionary');
load('SparseData.mat','SparseData');
derivedTrainingData = Dictionary*SparseData;

%reconstructing training images with sparse representation
derivedStackedIm1=derivedTrainingData(:,1:size(stackedIm1,2));
derivedC1=makecell(derivedStackedIm1,patchSize,size(C1));
reconstrucedIm1=reconstr(derivedC1,patchSize,percentageOverlap,N1);
e1=norm(double(Im1)-reconstrucedIm1); % error in representation
figure,imshow(uint8(reconstrucedIm1));


derivedStackedIm2=derivedTrainingData(:,size(stackedIm1,2)+1:size(stackedIm1,2)+size(stackedIm2,2));
derivedC2=makecell(derivedStackedIm2,patchSize,size(C1));
reconstrucedIm2=reconstr(derivedC2,patchSize,percentageOverlap,N2);
e2=norm(double(Im2)-reconstrucedIm2);
figure,imshow(uint8(reconstrucedIm2));

derivedStackedIm3=derivedTrainingData(:,size(stackedIm1,2)+size(stackedIm2,2)+1:size(stackedIm1,2)+size(stackedIm2,2)+size(stackedIm3,2));
derivedC3=makecell(derivedStackedIm3,patchSize,size(C3));
reconstrucedIm3=reconstr(derivedC3,patchSize,percentageOverlap,N3);
e3=norm(double(Im3)-reconstrucedIm3);
figure,imshow(uint8(reconstrucedIm3));