function [ESC]=sest_demod4(proj,cutOffFreq,FF,ver)
%proj: modulated projection
%cutOffFreq: cutoff freq for gauss filter
%FF: modulacios racs flood filed kepenek alulminatavetelezettje normalizalva
%ver: 0 - extrapolation, hadamard multiplication in place of convolution
%     1 - no extrapolation, filtering in image domain, handling  border
%     effects with weighting
if (ver==0)
  [Blck,Thr]=decompPModulator(proj); N=size(proj,1);
  [BMk,TMk]=decompPModulator(FF);
  BMkE=extrap(BMk); TMkE=extrap(TMk);
  BlE=extrap(Blck); ThE=extrap(Thr);
  M=mod(((1:N).')*ones(1,N)+ones(N,1)*(1:N),2);
  t1=mean(proj(M==1)); t2=mean(proj(M==0));
  if (t2<t1) %cell(1,1) was attenuated
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
  [ESC]=scatest2(IE,N.*cutOffFreq*2/3,MkE);
  ESC=ESC(N/2+1:end-N/2,N/2+1:end-N/2);
else
  N=size(proj,1);  
  [ESC]=scatest2conv(proj,N*cutOffFreq/3,FF);
end;