function [ESC]=scatest2conv(proj,sigma,FF)
%Implementation of the ADASE algorithm
%{ 
 The inputs of the function:
 proj:  cell image of the input projection
 sigma: sigma parameter of the lowpass and the highpass filter in frequency domain
 FF:    cell image of the modulator
%}
% ESC: is the estimated scatter.


N=size(proj,1);
%% Generates the filters of the demodulation
Fx=[0:N/2,-N/2+1:-1]; Fmask=((Fx.'*ones(1,N)).^2+(ones(N,1)*Fx).^2);
L=exp(-Fmask./(2*sigma^2)); H=exp(-fftshift(Fmask)./(2*sigma^2));
L=fftshift(ifft2(L,'symmetric')); H=fftshift(ifft2(H,'symmetric')); 
H2=zeros(N,N); H2(N/2+1,N/2+1)=1; H2=H2-H;
%% Calculates the demodulation
FS=conv2(ones(N,N),L,'same'); HS=conv2(ones(N,N),H2,'same');
MH=FF-conv2(FF,H2,'same')./HS; ML=conv2(FF,L,'same')./FS;
Pest=(proj-conv2(proj,H2,'same')./HS)./MH; ESC=conv2(proj,L,'same')./FS-Pest.*ML;

