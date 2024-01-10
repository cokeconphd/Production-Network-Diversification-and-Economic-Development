%-----------------------------I-O measures-------------------------%

%------Domestic I-O-----%



load iodom1995
load outputdom1995

load iodom1996
load outputdom1996

load iodom1997
load outputdom1997

load iodom1998
load outputdom1998

load iodom1999
load outputdom1999

load iodom2000
load outputdom2000

load iodom2001
load outputdom2001

load iodom2002
load outputdom2002

load iodom2003
load outputdom2003

load iodom2004
load outputdom2004

load iodom2005
load outputdom2005

load iodom2006
load outputdom2006

load iodom2007
load outputdom2007

load iodom2008
load outputdom2008

load iodom2009
load outputdom2009

load iodom2010
load outputdom2010

load iodom2011
load outputdom2011

[N1,N2,M]=size(matdom2011);


iodom11=zeros(N1,N1,M);
iodom10=zeros(N1,N1,M);
iodom09=zeros(N1,N1,M);
iodom08=zeros(N1,N1,M);
iodom07=zeros(N1,N1,M);
iodom06=zeros(N1,N1,M);
iodom05=zeros(N1,N1,M);
iodom04=zeros(N1,N1,M);
iodom03=zeros(N1,N1,M);
iodom02=zeros(N1,N1,M);
iodom01=zeros(N1,N1,M);
iodom00=zeros(N1,N1,M);
iodom99=zeros(N1,N1,M);
iodom98=zeros(N1,N1,M);
iodom97=zeros(N1,N1,M);
iodom96=zeros(N1,N1,M);
iodom95=zeros(N1,N1,M);

%Input-Ouput Matrix

for i=1:M
totout11(:,:,i)=kron(output2011(:,:,i),ones(N1,1));
totout10(:,:,i)=kron(output2010(:,:,i),ones(N1,1));
totout09(:,:,i)=kron(output2009(:,:,i),ones(N1,1));
totout08(:,:,i)=kron(output2008(:,:,i),ones(N1,1));
totout07(:,:,i)=kron(output2007(:,:,i),ones(N1,1));
totout06(:,:,i)=kron(output2006(:,:,i),ones(N1,1));
totout05(:,:,i)=kron(output2005(:,:,i),ones(N1,1));
totout04(:,:,i)=kron(output2004(:,:,i),ones(N1,1));
totout03(:,:,i)=kron(output2003(:,:,i),ones(N1,1));
totout02(:,:,i)=kron(output2002(:,:,i),ones(N1,1));
totout01(:,:,i)=kron(output2001(:,:,i),ones(N1,1));
totout00(:,:,i)=kron(output2000(:,:,i),ones(N1,1));
totout99(:,:,i)=kron(output1999(:,:,i),ones(N1,1));
totout98(:,:,i)=kron(output1998(:,:,i),ones(N1,1));
totout97(:,:,i)=kron(output1997(:,:,i),ones(N1,1));
totout96(:,:,i)=kron(output1996(:,:,i),ones(N1,1));
totout95(:,:,i)=kron(output1995(:,:,i),ones(N1,1));
end

for i=1:M
iodom11(:,:,i)=matdom2011(:,:,i)./totout11(:,:,i);
iodom10(:,:,i)=matdom2010(:,:,i)./totout10(:,:,i);
iodom09(:,:,i)=matdom2009(:,:,i)./totout09(:,:,i);
iodom08(:,:,i)=matdom2008(:,:,i)./totout08(:,:,i);
iodom07(:,:,i)=matdom2007(:,:,i)./totout07(:,:,i);
iodom06(:,:,i)=matdom2006(:,:,i)./totout06(:,:,i);
iodom05(:,:,i)=matdom2005(:,:,i)./totout05(:,:,i);
iodom04(:,:,i)=matdom2004(:,:,i)./totout04(:,:,i);
iodom03(:,:,i)=matdom2003(:,:,i)./totout03(:,:,i);
iodom02(:,:,i)=matdom2002(:,:,i)./totout02(:,:,i);
iodom01(:,:,i)=matdom2001(:,:,i)./totout01(:,:,i);
iodom00(:,:,i)=matdom2000(:,:,i)./totout00(:,:,i);
iodom99(:,:,i)=matdom1999(:,:,i)./totout99(:,:,i);
iodom98(:,:,i)=matdom1998(:,:,i)./totout98(:,:,i);
iodom97(:,:,i)=matdom1997(:,:,i)./totout97(:,:,i);
iodom96(:,:,i)=matdom1996(:,:,i)./totout96(:,:,i);
iodom95(:,:,i)=matdom1995(:,:,i)./totout95(:,:,i);
end

%How many sectors above threshold in-out-shares

for i=1:M
dio1_11(:,:,i)=iodom11(:,:,i)-0.0005;

dio1_10(:,:,i)=iodom10(:,:,i)-0.0005;

dio1_09(:,:,i)=iodom09(:,:,i)-0.0005;

dio1_08(:,:,i)=iodom08(:,:,i)-0.0005;

dio1_07(:,:,i)=iodom07(:,:,i)-0.0005;

dio1_06(:,:,i)=iodom06(:,:,i)-0.0005;

dio1_05(:,:,i)=iodom05(:,:,i)-0.0005;

dio1_04(:,:,i)=iodom04(:,:,i)-0.0005;

dio1_03(:,:,i)=iodom03(:,:,i)-0.0005;

dio1_02(:,:,i)=iodom02(:,:,i)-0.0005;

dio1_01(:,:,i)=iodom01(:,:,i)-0.0005;

dio1_00(:,:,i)=iodom00(:,:,i)-0.0005;

dio1_99(:,:,i)=iodom99(:,:,i)-0.0005;

dio1_98(:,:,i)=iodom98(:,:,i)-0.0005;

dio1_97(:,:,i)=iodom97(:,:,i)-0.0005;

dio1_96(:,:,i)=iodom96(:,:,i)-0.0005;

dio1_95(:,:,i)=iodom95(:,:,i)-0.0005;

end

dens1dom_11=zeros(1,M)';

dens1dom_10=zeros(1,M)';

dens1dom_09=zeros(1,M)';

dens1dom_08=zeros(1,M)';

dens1dom_07=zeros(1,M)';

dens1dom_06=zeros(1,M)';

dens1dom_05=zeros(1,M)';

dens1dom_04=zeros(1,M)';

dens1dom_03=zeros(1,M)';

dens1dom_02=zeros(1,M)';

dens1dom_01=zeros(1,M)';

dens1dom_00=zeros(1,M)';

dens1dom_99=zeros(1,M)';

dens1dom_98=zeros(1,M)';

dens1dom_97=zeros(1,M)';

dens1dom_96=zeros(1,M)';

dens1dom_95=zeros(1,M)';


for i=1:M
abovio1_11(:,:,i)=(dio1_11(:,:,i)>0);

abovio1_10(:,:,i)=(dio1_10(:,:,i)>0);

abovio1_09(:,:,i)=(dio1_09(:,:,i)>0);

abovio1_08(:,:,i)=(dio1_08(:,:,i)>0);

abovio1_07(:,:,i)=(dio1_07(:,:,i)>0);

abovio1_06(:,:,i)=(dio1_06(:,:,i)>0);

abovio1_05(:,:,i)=(dio1_05(:,:,i)>0);

abovio1_04(:,:,i)=(dio1_04(:,:,i)>0);

abovio1_03(:,:,i)=(dio1_03(:,:,i)>0);

abovio1_02(:,:,i)=(dio1_02(:,:,i)>0);

abovio1_01(:,:,i)=(dio1_01(:,:,i)>0);

abovio1_00(:,:,i)=(dio1_00(:,:,i)>0);

abovio1_99(:,:,i)=(dio1_99(:,:,i)>0);

abovio1_98(:,:,i)=(dio1_98(:,:,i)>0);

abovio1_97(:,:,i)=(dio1_97(:,:,i)>0);

abovio1_96(:,:,i)=(dio1_96(:,:,i)>0);

abovio1_95(:,:,i)=(dio1_95(:,:,i)>0);

end

for i=1:M
abio1_11(i)=sum(sum(abovio1_11(:,:,i)));

abio1_10(i)=sum(sum(abovio1_10(:,:,i)));

abio1_09(i)=sum(sum(abovio1_09(:,:,i)));

abio1_08(i)=sum(sum(abovio1_08(:,:,i)));

abio1_07(i)=sum(sum(abovio1_07(:,:,i)));

abio1_06(i)=sum(sum(abovio1_06(:,:,i)));

abio1_05(i)=sum(sum(abovio1_05(:,:,i)));

abio1_04(i)=sum(sum(abovio1_04(:,:,i)));

abio1_03(i)=sum(sum(abovio1_03(:,:,i)));

abio1_02(i)=sum(sum(abovio1_02(:,:,i)));

abio1_01(i)=sum(sum(abovio1_01(:,:,i)));

abio1_00(i)=sum(sum(abovio1_00(:,:,i)));

abio1_99(i)=sum(sum(abovio1_99(:,:,i)));

abio1_98(i)=sum(sum(abovio1_98(:,:,i)));

abio1_97(i)=sum(sum(abovio1_97(:,:,i)));

abio1_96(i)=sum(sum(abovio1_96(:,:,i)));

abio1_95(i)=sum(sum(abovio1_95(:,:,i)));

end

for i=1:M
dens1dom_11(i)=(abio1_11(i)-N1)/(N1*(N1-1));

dens1dom_10(i)=(abio1_10(i)-N1)/(N1*(N1-1));

dens1dom_09(i)=(abio1_09(i)-N1)/(N1*(N1-1));

dens1dom_08(i)=(abio1_08(i)-N1)/(N1*(N1-1));

dens1dom_07(i)=(abio1_07(i)-N1)/(N1*(N1-1));

dens1dom_06(i)=(abio1_06(i)-N1)/(N1*(N1-1));

dens1dom_05(i)=(abio1_05(i)-N1)/(N1*(N1-1));

dens1dom_04(i)=(abio1_04(i)-N1)/(N1*(N1-1));

dens1dom_03(i)=(abio1_03(i)-N1)/(N1*(N1-1));

dens1dom_02(i)=(abio1_02(i)-N1)/(N1*(N1-1));

dens1dom_01(i)=(abio1_01(i)-N1)/(N1*(N1-1));

dens1dom_00(i)=(abio1_00(i)-N1)/(N1*(N1-1));

dens1dom_99(i)=(abio1_99(i)-N1)/(N1*(N1-1));

dens1dom_98(i)=(abio1_98(i)-N1)/(N1*(N1-1));

dens1dom_97(i)=(abio1_97(i)-N1)/(N1*(N1-1));

dens1dom_96(i)=(abio1_96(i)-N1)/(N1*(N1-1));

dens1dom_95(i)=(abio1_95(i)-N1)/(N1*(N1-1));

end




Tnetwork2=table(dens1dom_95,dens1dom_96,dens1dom_97,dens1dom_98,dens1dom_99,dens1dom_00,dens1dom_01,dens1dom_02,dens1dom_03,dens1dom_04,dens1dom_05,dens1dom_06,dens1dom_07,dens1dom_08,dens1dom_09,dens1dom_10,dens1dom_11);
filename = 'domestic_dens_JEBO.xlsx';
writetable(Tnetwork2,filename,'Sheet',1)