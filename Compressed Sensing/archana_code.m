clc;
clear all;
close all;
img1 = imread('cameraman.tif');

double_img1 = double(img1);
gray_img = imresize(double_img1,[50 50]);
org_img = uint8(gray_img)
imshow(uint8(gray_img))
M = 2500;
load A.mat;

x = gray_img(:);
n = length(x);
z=A*x;
%___MEASUREMENT MATRIX___
m = 5000; % NOTE: small error still present after increasing m to 1500;
Phi = randn(m,n);
y = Phi*z;

ll=1700;%iteration time
alphar=omp_ra(Phi,n,m,ll,y);
xwsr=alphar';
plot(xwsr);
hold on
plot(z)
rec=inv(A)*xwsr;
imrec=reshape(rec,[50,50]);
final_img = uint8(imrec);
imshow(final_img)

peaksnr = psnr(final_img,org_img);
ssimval = ssim(final_img,org_img);
immseval = immse(final_img,org_img);
