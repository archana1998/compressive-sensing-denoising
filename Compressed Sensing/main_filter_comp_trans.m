clc;
clear all;
close all;
%%%%%%%%%%%%%Jai Jagannath%%%%%%%%%%%%
%%%%%%ECG filtering, compression and transmission%%%%%%%%%
%%%%%compression-using compressive sensing
%%%%%% transmission-UWB TX/RX with BPSK modulation scheme%%%%%%
%%%%%Author- Rajesh Tripathy, PhD, IIT Guwahati
fs=1000;
load hc1.mat;
val=val((1:12),:);
sigs=val(:,(2894:4794));
originalbits=2000*16;
x=sigs';
for i=1:12
   x1(:,i)=rajeshbwremoval(x(:,i));%%%base line wandering removal
%   x1(:,i)=rajeshhfnoiseremove(x1(:,i),fs);
   pp(:,i)=max(abs(x1(:,i)));
   x1(:,i)=x1(:,i)/pp(:,i);%%%%%amplitude normalization
end
%%%%%%original ECG signal
org=x1(:,1); %%%1,2, 6, 10, 11,12
org1=org;
subplot(221), plot(org1);
hold on 
%%%%%%%%sparse signal in DWT domain%%%%%%%%%%%%%
[weights,A11,D11,D12,D13,D14,D15,D16,C1,L1]=wavecoffweigh(org1);
xws=[A11;D11;D12;D13;D14;D15;D16];%%%%sparse signal
subplot(222), plot(xws);
%%%%%%%%measurement stage%%%%%%%%%%%%%
q=size(xws,1);
mreq=500;
disp('Creating measurment matrix...');
A=randonbsm(mreq,q); %%%%randn(mreq,q)
A = orth(A')';
y = A*xws;
%%%%%%%quantization%%%%%%%%%%
y11=y(:);
bits=6;
[quantResults1,levelNumbers1,base1,high1,range1] = quantaize(y11,bits);
%%%%%%huffman encoding)%%%%%%%%%%%
disp('Compressed bit stream................');
[encoded_s1,dict1,prob1,avglen1,entropy1,eff1]=huff_encoding(levelNumbers1);
compbit1=((length(encoded_s1))+length(dict1));
cr=originalbits/(compbit1+100)
disp('UWB transmission................');
%%%%%%%%%%%%%UWB transmition%%%%%%%%%%%%%%
[f_c,f_c1]=uwb_transmit(encoded_s1);

%%%%%%%%%%%%%%%%%%receiver section%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('UWB reception................');
%%%%%%%UWB reception%%%%%%%%%%%
decoded_s1=UWB_receive(f_c,f_c1);
%%%%%%%%%%%%%%huffman decoding and inverse quantaization%%%%%%%%%%
disp('signal reconstruction................');
dsig1 = huffmandeco(decoded_s1,dict1);
vect1 = inversequantaize(dsig1,bits,base1,high1,range1);
yr=reshape(vect1,[mreq 1]);
%%%%%%%%%%%omp reconstruction 
y=yr;
ll=100;%iteration time
alphar=omp_ra(A,q,mreq,ll,y);
xwsr=alphar';
subplot(223), plot(xwsr);
rec = waverec(xwsr,L1,'bior6.8');
rec1=rec;
subplot(224),plot(rec1);
prd_intrusive=(norm(org1-rec1)/norm(org1))*100
wedd_intrusive=weddmeasure(org1,rec1)
wddmeasure_intru=wdd(org1,rec1)
% % %%%%%%%%%%%%%%%%%%%%%%testing of the model%%%%%%%%%%%%
% % addpath('ECG_LS_SVM');
% % load model_hc1.mat;
% % xot=rec1;
% % Xdo=dct(xot);
% % Xdo=Xdo((1:300),1);
% % Yt = simlssvm(model,Xdo);
% % Yt1=[Yt; zeros(((length(rec1))-300),1)];
% % xr=idct(Yt1);
% % % xr1=xr*pp(:,1);
% % xr1=xr;
% prd_non_intrusive=norm(xr1-rec1)/norm(xr1)*100
% wedd_non_intrusive=weddmeasure(xr1,rec1)
% % prd_synthesis=(norm(org1-xr1)/norm(org1))*100;
% % wedd_synthesis=weddmeasure(org1,xr1);
% wddmeasure_intru=wdd(org1,rec1)
% %  wddmeasure_nonintru=wdd(xr1,rec1)

figure,
subplot(311),plot(org1);
title('original ECG signal');
subplot(312), plot(rec1);
title('Processed ECG signal');
% subplot(313),plot(xr1);
% title('synthesized ECG signal');
% 




