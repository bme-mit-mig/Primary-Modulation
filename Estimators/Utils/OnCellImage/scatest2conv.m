function [ESC]=scatest2conv(inp,sgm,Mk)
%inp: input, alulmintavetelezett modulatoros rontgen felvetel. Merete 2n*2n, ahol n, m egesz (kulonben biztosan rossz a becsles :)).
%sgm: frekvenciaterbeli gauss sigmaja (ez hasznalt alul es felulatereszteshez is).
%Mk: Amplitudo modulacios racs alulmintavetelezett flood-field vetulete
%kepterbeli atlagoloszureses valtozat
N=size(inp,1);
%Gauss szuro konstrualasa:
L=zeros(N,N); L(2:end,2:end)=fspecial('gaussian',N-1,sgm); L=fftshift(L); L=L./max(L(:));
H=zeros(N,N); H(2:end,2:end)=fspecial('gaussian',N-1,sgm); H=H./max(H(:));
L=fftshift(real(ifft2(L))); H=fftshift(real(ifft2(H))); H2=fftshift(real(ifft2(ones(N,N))))-H;
FS=conv2(ones(N,N),L,'same'); HS=conv2(ones(N,N),H2,'same');
MH=Mk-conv2(Mk,H2,'same')./HS; ML=conv2(Mk,L,'same')./FS;
Pest=(inp-conv2(inp,H2,'same')./HS)./MH; ESC=conv2(inp,L,'same')./FS-Pest.*ML;

%MH=conv2(Mk,H,'same'); ML=conv2(Mk,L,'same')./FS;
%Pest=(conv2(inp,H,'same'))./MH; ESC=conv2(inp,L,'same')./FS-Pest.*ML;