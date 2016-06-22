function [T]=extrap(I)
% input: I: N*N-es kep, ahol N paros.
% output: T: 2N*2N-es kep, ami az I cirkularis extrapolaltja.

N=size(I,1);
%1-es kiterjesztett kep eloallitasa:
A=zeros(2*(N+2)*(N-2),(N+4)*N); %Celfuggveny segedmatrixa
for x=2:N+3
    for y=2:N-1
        i=(y-2)*(N+2)+x-1; %Matrix sorindexe
        A(i,(y-1)*(N+4)+x)=-2; A(i,(y-1)*(N+4)+x-1)=1; A(i,(y-1)*(N+4)+x+1)=1;
        i=(y-2)*(N+2)+x-1+(N+2)*(N-2); %Matrix sorindexe
        A(i,(y-1)*(N+4)+x)=-2; A(i,(y-2)*(N+4)+x)=1; A(i,y*(N+4)+x)=1;
    end;
end;
Q=A.'*A; Q=Q+eye(size(Q)).*1e-12; %Ez a celfuggveny matrixa, akar offline kiszamolas utan elegendo lenne csak betolteni.
B=zeros(4*N,(N+4)*N); %Kenyszerek matrixa.
C=zeros(4*N,1); %Kenyszeregyenlet jobboldalanak vektora.
for x=1:2
    for y=1:N
        i=(x-1)*N+y;
        B(i,(y-1)*(N+4)+x)=1; C(i)=I(N-2+x,y);
    end;
end;
for x=N+3:N+4
    for y=1:N
        i=2*N+(x-N-3)*N+y;
        B(i,(y-1)*(N+4)+x)=1; C(i)=I(x-N-2,y);
    end;
end;
M1=[[Q,B.'];[B,zeros(4*N,4*N)]]; %Itt akar Q-t lehet regularizalni.
ter1=M1\[zeros(N*(N+4),1);C]; mlp1=ter1(end-4*N+1:end); ter1=ter1(1:end-4*N);
ter1=reshape(ter1,N+4,N); %Az 1-es kiegeszites.

%2-es kiterjesztett kep szamolasa:
A=zeros((N-2)*(N+2)*2,N*(N+4)); %Celfuggveny segedmatrixa
for x=2:N-1
    for y=2:N+3
        i=(y-2)*(N-2)+x-1; %Matrix sorindexe
        A(i,(y-1)*N+x)=-2; A(i,(y-1)*N+x-1)=1; A(i,(y-1)*N+x+1)=1;
        i=(y-2)*(N-2)+x-1+(N-2)*(N+2);
        A(i,(y-1)*N+x)=-2; A(i,(y-2)*N+x)=1; A(i,y*N+x)=1;
    end;
end;
Q=A.'*A; Q=Q+eye(size(Q)).*1e-12;
B=zeros(4*N,(N+4)*N); C=zeros(4*N,1);
for y=1:2
    for x=1:N
        i=(y-1)*N+x;
        B(i,(y-1)*N+x)=1; C(i)=I(x,N-2+y);
    end;
end;
for y=N+3:N+4
    for x=1:N
        i=2*N+(y-(N+3))*N+x;
        B(i,(y-1)*N+x)=1; C(i)=I(x,y-N-2);
    end;
end;
M2=[[Q,B.'];[B,zeros(4*N,4*N)]]; %Itt majd Q-t nagyvalsz regularizalni kell.
ter2=M2\[zeros(N*(N+4),1);C]; mlp2=ter2(end-4*N+1:end); ter2=ter2(1:end-4*N);
ter2=reshape(ter2,N,N+4); %A 2-es kiterjesztett csempe.

%3-as csempe szamolasa:
A=zeros((N+2)*(N+2)*2,(N+4)*(N+4)); %Celfuggveny segedmatrixa
for x=2:N+3
    for y=2:N+3
        i=(y-2)*(N+2)+x-1;
        A(i,(y-1)*(N+4)+x)=-2; A(i,(y-2)*(N+4)+x)=1; A(i,y*(N+4)+x)=1;
        i=(y-2)*(N+2)+x-1+(N+2)*(N+2);
        A(i,(y-1)*(N+4)+x)=-2; A(i,(y-1)*(N+4)+x-1)=1; A(i,(y-1)*(N+4)+x+1)=1;
    end;
end;
Q=A.'*A;
B=zeros(4*(N+4)+4*N,(N+4)*(N+4)); C=zeros(4*(N+4)+4*N,1);
for y=1:2
    for x=1:N+4
        i=(y-1)*(N+4)+x;
        B(i,(y-1)*(N+4)+x)=1; C(i)=ter1(x,N-2+y);
    end;
end;
for y=N+3:N+4
    for x=1:N+4
        i=2*(N+4)+(y-N-3)*(N+4)+x;
        B(i,(y-1)*(N+4)+x)=1; C(i)=ter1(x,y-N-2);
    end;
end;
for x=1:2
    for y=3:N+2
        i=4*(N+4)+(x-1)*N+y-2;
        B(i,(y-1)*(N+4)+x)=1; C(i)=ter2(N-2+x,y);
    end;
end;
for x=N+3:N+4
    for y=3:N+2
        i=4*(N+4)+2*N+(x-N-3)*N+y-2;
        B(i,(y-1)*(N+4)+x)=1; C(i)=ter2(x-N-2,y);
    end;
end;
M3=[[Q,B.'];[B,zeros(4*(N+4)+4*N)]]; ter3=M3\[zeros((N+4)*(N+4),1);C];
mlp3=ter3(end-(4*(N+4)+4*N)+1:end); ter3=ter3(1:end-(4*(N+4)+4*N));
ter3=reshape(ter3,N+4,N+4);
ter1=ter1(3:end-2,:); ter2=ter2(:,3:end-2); ter3=ter3(3:end-2,3:end-2);
T=[ter3,ter1,ter3;ter2,I,ter2;ter3,ter1,ter3]; T=T(N/2+1:end-N/2,N/2+1:end-N/2);