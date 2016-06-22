function er = getCellImCached(cache,image)
% sample (1. valotozo): getSampleWingm 1. kimenete
% I (2. valotoz): mintavenni kivant kep
% sulyim (3. valtozo): getSampleWingm 2. kimenete 

corners = cache.cellCorners;
weights = cache.weights;

image=image.*double(weights);
intim=zeros(size(image)+1,'double');
intim(2:end,2:end)=cumsum(cumsum(image,1),2);
[Nl,Ml,~]=size(corners);
er=NaN(Nl,Ml,'double');
ind=find(~isnan(corners(:,:,1))); w=corners(:,:,1); w=w(ind);
bs=corners(:,:,2); bs=bs(ind); bo=corners(:,:,3); bo=bo(ind);
js=corners(:,:,4); js=js(ind); jo=corners(:,:,5); jo=jo(ind);
[Nl,Ml]=size(image); Nl=Nl+1;
indbf=(bo-1).*Nl+bs; indjf=jo.*Nl+bs; indba=(bo-1).*Nl+js+1; indja=jo.*Nl+js+1;
er(ind)=(intim(indbf)+intim(indja)-intim(indjf)-intim(indba))./w;