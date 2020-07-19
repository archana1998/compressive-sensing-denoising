img1 = imread("lena_std.tif");

img2 = img1([50:99],[50:99]);
g_img = rgb2gray(img1);
double_img1 = double(rgb2gray(img1));
gray_img = imresize(double_img1,[50 50]);
M = 32; %dimension of Ramanujan matrix, to be specified
A2 = zeros([M,M]);
A2 = Rnew_A(M); 
save('A2.mat','A2');




