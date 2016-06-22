function [ESC]=scatest2(inp,sgm,Mk)
%inp: input, alulmintavetelezett modulatoros rontgen felvetel. Merete 2n*2n, ahol n, m egesz (kulonben biztosan rossz a becsles :)).
%alfa: csillapitasi tenyezo, multiplikativ.
%sgm: frekvenciaterbeli gauss sigmaja (ez hasznalt alul es felulatereszteshez is).
%Mk: Amplitudo modulacios racs alulmintavetelezett flat-field vetulete
N=size(inp,1);
%Gauss szuro konstrualasa:
L=zeros(N,N); L(2:end,2:end)=fspecial('gaussian',N-1,sgm); L=fftshift(L); L=L./max(L(:));
H=zeros(N,N); H(2:end,2:end)=fspecial('gaussian',N-1,sgm); H=H./max(H(:));
MH=ifft2(fft2(Mk).*H); ML=ifft2(fft2(Mk).*L);
Pest=ifft2(fft2(inp).*H)./MH;
ESC=ifft2(fft2(inp).*L)-Pest.*ML;
