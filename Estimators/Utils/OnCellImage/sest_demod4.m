function [ESC]=sest_demod4(I,svf,Mk,ver)
%I a modulalt, szorodassal terhelt kep
%svf: vagasi frekvenciaja a Gauss szuronek felul/alul ateresztesnel
%Mk: modulacios racs flood filed kepenek alulminatavetelezettje normalizalva
%ver: 0 - extrapolacio, frekvenciaterbeli hadamard szorzas a konvolucio helyett
%     1 - nincs extrapolacio, kepterbeli szures, kep szelenel megfeleloen sulyozva
if (ver==0)
  [Blck,Thr]=decompPModulator(I); N=size(I,1);
  [BMk,TMk]=decompPModulator(Mk);
  BMkE=extrap(BMk); TMkE=extrap(TMk);
  BlE=extrap(Blck); ThE=extrap(Thr);
  M=mod(((1:N).')*ones(1,N)+ones(N,1)*(1:N),2);
  t1=mean(I(M==1)); t2=mean(I(M==0));
  if (t2<t1) %Racs 1,1-es eleme modulalt volt.
    if (mod(N/2,2))
      MkE=composePModulator(TMkE,BMkE);
      IE=composePModulator(ThE,BlE);
    else
      MkE=composePModulator(BMkE,TMkE);
      IE=composePModulator(BlE,ThE);
    end;
  else
  if (mod(N/2,2))
      MkE=composePModulator(BMkE,TMkE);
      IE=composePModulator(BlE,ThE);
  else
      MkE=composePModulator(TMkE,BMkE);
      IE=composePModulator(ThE,BlE);
  end; 
  end;
  [ESC]=scatest2(IE,N.*svf*2/3,MkE);
  ESC=ESC(N/2+1:end-N/2,N/2+1:end-N/2);
else
  N=size(I,1);  
  [ESC]=scatest2conv(I,N*svf/3,Mk);
end;