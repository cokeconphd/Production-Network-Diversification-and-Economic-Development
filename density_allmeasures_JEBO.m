%-----------------------------I-O measures-------------------------%


%Density over time 1995 - 2011


load io1995
load output1995

load io1996
load output1996

load io1997 
load output1997

load io1998
load output1998

load io1999
load output1999

load io2000
load output2000

load io2001
load output2001

load io2002
load output2002

load io2003
load output2003

load io2004
load output2004

load io2005
load output2005

load io2006
load output2006

load io2007
load output2007

load io2008
load output2008

load io2009
load output2009

load io2010
load output2010

load io2011
load output2011

[N1,N2,M]=size(mat2011);

io11=zeros(N1,N1,M);
io10=zeros(N1,N1,M);
io09=zeros(N1,N1,M);
io08=zeros(N1,N1,M);
io07=zeros(N1,N1,M);
io06=zeros(N1,N1,M);
io05=zeros(N1,N1,M);
io04=zeros(N1,N1,M);
io03=zeros(N1,N1,M);
io02=zeros(N1,N1,M);
io01=zeros(N1,N1,M);
io00=zeros(N1,N1,M);
io99=zeros(N1,N1,M);
io98=zeros(N1,N1,M);
io97=zeros(N1,N1,M);
io96=zeros(N1,N1,M);
io95=zeros(N1,N1,M);

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

%IO Shares for Forward IO linkages 
%then do this below but with totout' - put in loop 

for i=1:M
io11_tilde(:,:,i)=mat2011(:,:,i)./(totout11(:,:,i)');
io10_tilde(:,:,i)=mat2010(:,:,i)./(totout10(:,:,i)');
io09_tilde(:,:,i)=mat2009(:,:,i)./(totout09(:,:,i)');
io08_tilde(:,:,i)=mat2008(:,:,i)./(totout08(:,:,i)');
io07_tilde(:,:,i)=mat2007(:,:,i)./(totout07(:,:,i)');
io06_tilde(:,:,i)=mat2006(:,:,i)./(totout06(:,:,i)');
io05_tilde(:,:,i)=mat2005(:,:,i)./(totout05(:,:,i)');
io04_tilde(:,:,i)=mat2004(:,:,i)./(totout04(:,:,i)');
io03_tilde(:,:,i)=mat2003(:,:,i)./(totout03(:,:,i)');
io02_tilde(:,:,i)=mat2002(:,:,i)./(totout02(:,:,i)');
io01_tilde(:,:,i)=mat2001(:,:,i)./(totout01(:,:,i)');
io00_tilde(:,:,i)=mat2000(:,:,i)./(totout00(:,:,i)');
io99_tilde(:,:,i)=mat1999(:,:,i)./(totout99(:,:,i)');
io98_tilde(:,:,i)=mat1998(:,:,i)./(totout98(:,:,i)');
io97_tilde(:,:,i)=mat1997(:,:,i)./(totout97(:,:,i)');
io96_tilde(:,:,i)=mat1996(:,:,i)./(totout96(:,:,i)');
io95_tilde(:,:,i)=mat1995(:,:,i)./(totout95(:,:,i)');
end

for i=1:M
io11(:,:,i)=mat2011(:,:,i)./totout11(:,:,i);
io10(:,:,i)=mat2010(:,:,i)./totout10(:,:,i);
io09(:,:,i)=mat2009(:,:,i)./totout09(:,:,i);
io08(:,:,i)=mat2008(:,:,i)./totout08(:,:,i);
io07(:,:,i)=mat2007(:,:,i)./totout07(:,:,i);
io06(:,:,i)=mat2006(:,:,i)./totout06(:,:,i);
io05(:,:,i)=mat2005(:,:,i)./totout05(:,:,i);
io04(:,:,i)=mat2004(:,:,i)./totout04(:,:,i);
io03(:,:,i)=mat2003(:,:,i)./totout03(:,:,i);
io02(:,:,i)=mat2002(:,:,i)./totout02(:,:,i);
io01(:,:,i)=mat2001(:,:,i)./totout01(:,:,i);
io00(:,:,i)=mat2000(:,:,i)./totout00(:,:,i);
io99(:,:,i)=mat1999(:,:,i)./totout99(:,:,i);
io98(:,:,i)=mat1998(:,:,i)./totout98(:,:,i);
io97(:,:,i)=mat1997(:,:,i)./totout97(:,:,i);
io96(:,:,i)=mat1996(:,:,i)./totout96(:,:,i);
io95(:,:,i)=mat1995(:,:,i)./totout95(:,:,i);
end

%How many sectors above threshold in-out-shares

for i=1:M
dio1_11(:,:,i)=io11(:,:,i)-0.0005;
dio2_11(:,:,i)=io11(:,:,i)-0.001;
dio3_11(:,:,i)=io11(:,:,i)-0.005;
dio4_11(:,:,i)=io11(:,:,i)-0.00001;


dio1_10(:,:,i)=io10(:,:,i)-0.0005;
dio2_10(:,:,i)=io10(:,:,i)-0.001;
dio3_10(:,:,i)=io10(:,:,i)-0.005;
dio4_10(:,:,i)=io10(:,:,i)-0.00001;

dio1_09(:,:,i)=io09(:,:,i)-0.0005;
dio2_09(:,:,i)=io09(:,:,i)-0.001;
dio3_09(:,:,i)=io09(:,:,i)-0.005;
dio4_09(:,:,i)=io09(:,:,i)-0.00001;

dio1_08(:,:,i)=io08(:,:,i)-0.0005;
dio2_08(:,:,i)=io08(:,:,i)-0.001;
dio3_08(:,:,i)=io08(:,:,i)-0.005;
dio4_08(:,:,i)=io08(:,:,i)-0.00001;

dio1_07(:,:,i)=io07(:,:,i)-0.0005;
dio2_07(:,:,i)=io07(:,:,i)-0.001;
dio3_07(:,:,i)=io07(:,:,i)-0.005;
dio4_07(:,:,i)=io07(:,:,i)-0.00001;

dio1_06(:,:,i)=io06(:,:,i)-0.0005;
dio2_06(:,:,i)=io06(:,:,i)-0.001;
dio3_06(:,:,i)=io06(:,:,i)-0.005;
dio4_06(:,:,i)=io06(:,:,i)-0.00001;

dio1_05(:,:,i)=io05(:,:,i)-0.0005;
dio2_05(:,:,i)=io05(:,:,i)-0.001;
dio3_05(:,:,i)=io05(:,:,i)-0.005;
dio4_05(:,:,i)=io05(:,:,i)-0.00001;

dio1_04(:,:,i)=io04(:,:,i)-0.0005;
dio2_04(:,:,i)=io04(:,:,i)-0.001;
dio3_04(:,:,i)=io04(:,:,i)-0.005;
dio4_04(:,:,i)=io04(:,:,i)-0.00001;

dio1_03(:,:,i)=io03(:,:,i)-0.0005;
dio2_03(:,:,i)=io03(:,:,i)-0.001;
dio3_03(:,:,i)=io03(:,:,i)-0.005;
dio4_03(:,:,i)=io03(:,:,i)-0.00001;

dio1_02(:,:,i)=io02(:,:,i)-0.0005;
dio2_02(:,:,i)=io02(:,:,i)-0.001;
dio3_02(:,:,i)=io02(:,:,i)-0.005;
dio4_02(:,:,i)=io02(:,:,i)-0.00001;

dio1_01(:,:,i)=io01(:,:,i)-0.0005;
dio2_01(:,:,i)=io01(:,:,i)-0.001;
dio3_01(:,:,i)=io01(:,:,i)-0.005;
dio4_01(:,:,i)=io01(:,:,i)-0.00001;

dio1_00(:,:,i)=io00(:,:,i)-0.0005;
dio2_00(:,:,i)=io00(:,:,i)-0.001;
dio3_00(:,:,i)=io00(:,:,i)-0.005;
dio4_00(:,:,i)=io00(:,:,i)-0.00001;

dio1_99(:,:,i)=io99(:,:,i)-0.0005;
dio2_99(:,:,i)=io99(:,:,i)-0.001;
dio3_99(:,:,i)=io99(:,:,i)-0.005;
dio4_99(:,:,i)=io99(:,:,i)-0.00001;

dio1_98(:,:,i)=io98(:,:,i)-0.0005;
dio2_98(:,:,i)=io98(:,:,i)-0.001;
dio3_98(:,:,i)=io98(:,:,i)-0.005;
dio4_98(:,:,i)=io98(:,:,i)-0.00001;

dio1_97(:,:,i)=io97(:,:,i)-0.0005;
dio2_97(:,:,i)=io97(:,:,i)-0.001;
dio3_97(:,:,i)=io97(:,:,i)-0.005;
dio4_97(:,:,i)=io97(:,:,i)-0.00001;

dio1_96(:,:,i)=io96(:,:,i)-0.0005;
dio2_96(:,:,i)=io96(:,:,i)-0.001;
dio3_96(:,:,i)=io96(:,:,i)-0.005;
dio4_96(:,:,i)=io96(:,:,i)-0.00001;

dio1_95(:,:,i)=io95(:,:,i)-0.0005;
dio2_95(:,:,i)=io95(:,:,i)-0.001;
dio3_95(:,:,i)=io95(:,:,i)-0.005;
dio4_95(:,:,i)=io95(:,:,i)-0.00001;

end

dens1_11=zeros(1,M)';
dens2_11=zeros(1,M)';
dens3_11=zeros(1,M)';
dens4_11=zeros(1,M)';

dens1_10=zeros(1,M)';
dens2_10=zeros(1,M)';
dens3_10=zeros(1,M)';
dens4_10=zeros(1,M)';

dens1_09=zeros(1,M)';
dens2_09=zeros(1,M)';
dens3_09=zeros(1,M)';
dens4_09=zeros(1,M)';

dens1_08=zeros(1,M)';
dens2_08=zeros(1,M)';
dens3_08=zeros(1,M)';
dens4_08=zeros(1,M)';

dens1_07=zeros(1,M)';
dens2_07=zeros(1,M)';
dens3_07=zeros(1,M)';
dens4_07=zeros(1,M)';

dens1_06=zeros(1,M)';
dens2_06=zeros(1,M)';
dens3_06=zeros(1,M)';
dens4_06=zeros(1,M)';

dens1_05=zeros(1,M)';
dens2_05=zeros(1,M)';
dens3_05=zeros(1,M)';
dens4_05=zeros(1,M)';

dens1_04=zeros(1,M)';
dens2_04=zeros(1,M)';
dens3_04=zeros(1,M)';
dens4_04=zeros(1,M)';

dens1_03=zeros(1,M)';
dens2_03=zeros(1,M)';
dens3_03=zeros(1,M)';
dens4_03=zeros(1,M)';

dens1_02=zeros(1,M)';
dens2_02=zeros(1,M)';
dens3_02=zeros(1,M)';
dens4_02=zeros(1,M)';

dens1_01=zeros(1,M)';
dens2_01=zeros(1,M)';
dens3_01=zeros(1,M)';
dens4_01=zeros(1,M)';

dens1_00=zeros(1,M)';
dens2_00=zeros(1,M)';
dens3_00=zeros(1,M)';
dens4_00=zeros(1,M)';

dens1_99=zeros(1,M)';
dens2_99=zeros(1,M)';
dens3_99=zeros(1,M)';
dens4_99=zeros(1,M)';

dens1_98=zeros(1,M)';
dens2_98=zeros(1,M)';
dens3_98=zeros(1,M)';
dens4_98=zeros(1,M)';

dens1_97=zeros(1,M)';
dens2_97=zeros(1,M)';
dens3_97=zeros(1,M)';
dens4_97=zeros(1,M)';

dens1_96=zeros(1,M)';
dens2_96=zeros(1,M)';
dens3_96=zeros(1,M)';
dens4_96=zeros(1,M)';

dens1_95=zeros(1,M)';
dens2_95=zeros(1,M)';
dens3_95=zeros(1,M)';
dens4_95=zeros(1,M)';

for i=1:M
abovio1_11(:,:,i)=(dio1_11(:,:,i)>0);
abovio2_11(:,:,i)=(dio2_11(:,:,i)>0);
abovio3_11(:,:,i)=(dio3_11(:,:,i)>0);
abovio4_11(:,:,i)=(dio4_11(:,:,i)>0);

abovio1_10(:,:,i)=(dio1_10(:,:,i)>0);
abovio2_10(:,:,i)=(dio2_10(:,:,i)>0);
abovio3_10(:,:,i)=(dio3_10(:,:,i)>0);
abovio4_10(:,:,i)=(dio4_10(:,:,i)>0);

abovio1_09(:,:,i)=(dio1_09(:,:,i)>0);
abovio2_09(:,:,i)=(dio2_09(:,:,i)>0);
abovio3_09(:,:,i)=(dio3_09(:,:,i)>0);
abovio4_09(:,:,i)=(dio4_09(:,:,i)>0);

abovio1_08(:,:,i)=(dio1_08(:,:,i)>0);
abovio2_08(:,:,i)=(dio2_08(:,:,i)>0);
abovio3_08(:,:,i)=(dio3_08(:,:,i)>0);
abovio4_08(:,:,i)=(dio4_08(:,:,i)>0);

abovio1_07(:,:,i)=(dio1_07(:,:,i)>0);
abovio2_07(:,:,i)=(dio2_07(:,:,i)>0);
abovio3_07(:,:,i)=(dio3_07(:,:,i)>0);
abovio4_07(:,:,i)=(dio4_07(:,:,i)>0);

abovio1_06(:,:,i)=(dio1_06(:,:,i)>0);
abovio2_06(:,:,i)=(dio2_06(:,:,i)>0);
abovio3_06(:,:,i)=(dio3_06(:,:,i)>0);
abovio4_06(:,:,i)=(dio4_06(:,:,i)>0);

abovio1_05(:,:,i)=(dio1_05(:,:,i)>0);
abovio2_05(:,:,i)=(dio2_05(:,:,i)>0);
abovio3_05(:,:,i)=(dio3_05(:,:,i)>0);
abovio4_05(:,:,i)=(dio4_05(:,:,i)>0);

abovio1_04(:,:,i)=(dio1_04(:,:,i)>0);
abovio2_04(:,:,i)=(dio2_04(:,:,i)>0);
abovio3_04(:,:,i)=(dio3_04(:,:,i)>0);
abovio4_04(:,:,i)=(dio4_04(:,:,i)>0);

abovio1_03(:,:,i)=(dio1_03(:,:,i)>0);
abovio2_03(:,:,i)=(dio2_03(:,:,i)>0);
abovio3_03(:,:,i)=(dio3_03(:,:,i)>0);
abovio4_03(:,:,i)=(dio4_03(:,:,i)>0);

abovio1_02(:,:,i)=(dio1_02(:,:,i)>0);
abovio2_02(:,:,i)=(dio2_02(:,:,i)>0);
abovio3_02(:,:,i)=(dio3_02(:,:,i)>0);
abovio4_02(:,:,i)=(dio4_02(:,:,i)>0);

abovio1_01(:,:,i)=(dio1_01(:,:,i)>0);
abovio2_01(:,:,i)=(dio2_01(:,:,i)>0);
abovio3_01(:,:,i)=(dio3_01(:,:,i)>0);
abovio4_01(:,:,i)=(dio4_01(:,:,i)>0);

abovio1_00(:,:,i)=(dio1_00(:,:,i)>0);
abovio2_00(:,:,i)=(dio2_00(:,:,i)>0);
abovio3_00(:,:,i)=(dio3_00(:,:,i)>0);
abovio4_00(:,:,i)=(dio4_00(:,:,i)>0);

abovio1_99(:,:,i)=(dio1_99(:,:,i)>0);
abovio2_99(:,:,i)=(dio2_99(:,:,i)>0);
abovio3_99(:,:,i)=(dio3_99(:,:,i)>0);
abovio4_99(:,:,i)=(dio4_99(:,:,i)>0);

abovio1_98(:,:,i)=(dio1_98(:,:,i)>0);
abovio2_98(:,:,i)=(dio2_98(:,:,i)>0);
abovio3_98(:,:,i)=(dio3_98(:,:,i)>0);
abovio4_98(:,:,i)=(dio4_98(:,:,i)>0);

abovio1_97(:,:,i)=(dio1_97(:,:,i)>0);
abovio2_97(:,:,i)=(dio2_97(:,:,i)>0);
abovio3_97(:,:,i)=(dio3_97(:,:,i)>0);
abovio4_97(:,:,i)=(dio4_97(:,:,i)>0);

abovio1_96(:,:,i)=(dio1_96(:,:,i)>0);
abovio2_96(:,:,i)=(dio2_96(:,:,i)>0);
abovio3_96(:,:,i)=(dio3_96(:,:,i)>0);
abovio4_96(:,:,i)=(dio4_96(:,:,i)>0);

abovio1_95(:,:,i)=(dio1_95(:,:,i)>0);
abovio2_95(:,:,i)=(dio2_95(:,:,i)>0);
abovio3_95(:,:,i)=(dio3_95(:,:,i)>0);
abovio4_95(:,:,i)=(dio4_95(:,:,i)>0);

end

for i=1:M
abio1_11(i)=sum(sum(abovio1_11(:,:,i)));
abio2_11(i)=sum(sum(abovio2_11(:,:,i)));
abio3_11(i)=sum(sum(abovio3_11(:,:,i)));
abio4_11(i)=sum(sum(abovio4_11(:,:,i)));

abio1_10(i)=sum(sum(abovio1_10(:,:,i)));
abio2_10(i)=sum(sum(abovio2_10(:,:,i)));
abio3_10(i)=sum(sum(abovio3_10(:,:,i)));
abio4_10(i)=sum(sum(abovio4_10(:,:,i)));

abio1_09(i)=sum(sum(abovio1_09(:,:,i)));
abio2_09(i)=sum(sum(abovio2_09(:,:,i)));
abio3_09(i)=sum(sum(abovio3_09(:,:,i)));
abio4_09(i)=sum(sum(abovio4_09(:,:,i)));

abio1_08(i)=sum(sum(abovio1_08(:,:,i)));
abio2_08(i)=sum(sum(abovio2_08(:,:,i)));
abio3_08(i)=sum(sum(abovio3_08(:,:,i)));
abio4_08(i)=sum(sum(abovio4_08(:,:,i)));

abio1_07(i)=sum(sum(abovio1_07(:,:,i)));
abio2_07(i)=sum(sum(abovio2_07(:,:,i)));
abio3_07(i)=sum(sum(abovio3_07(:,:,i)));
abio4_07(i)=sum(sum(abovio4_07(:,:,i)));

abio1_06(i)=sum(sum(abovio1_06(:,:,i)));
abio2_06(i)=sum(sum(abovio2_06(:,:,i)));
abio3_06(i)=sum(sum(abovio3_06(:,:,i)));
abio4_06(i)=sum(sum(abovio4_06(:,:,i)));

abio1_05(i)=sum(sum(abovio1_05(:,:,i)));
abio2_05(i)=sum(sum(abovio2_05(:,:,i)));
abio3_05(i)=sum(sum(abovio3_05(:,:,i)));
abio4_05(i)=sum(sum(abovio4_05(:,:,i)));

abio1_04(i)=sum(sum(abovio1_04(:,:,i)));
abio2_04(i)=sum(sum(abovio2_04(:,:,i)));
abio3_04(i)=sum(sum(abovio3_04(:,:,i)));
abio4_04(i)=sum(sum(abovio4_04(:,:,i)));

abio1_03(i)=sum(sum(abovio1_03(:,:,i)));
abio2_03(i)=sum(sum(abovio2_03(:,:,i)));
abio3_03(i)=sum(sum(abovio3_03(:,:,i)));
abio4_03(i)=sum(sum(abovio4_03(:,:,i)));

abio1_02(i)=sum(sum(abovio1_02(:,:,i)));
abio2_02(i)=sum(sum(abovio2_02(:,:,i)));
abio3_02(i)=sum(sum(abovio3_02(:,:,i)));
abio4_02(i)=sum(sum(abovio4_02(:,:,i)));

abio1_01(i)=sum(sum(abovio1_01(:,:,i)));
abio2_01(i)=sum(sum(abovio2_01(:,:,i)));
abio3_01(i)=sum(sum(abovio3_01(:,:,i)));
abio4_01(i)=sum(sum(abovio4_01(:,:,i)));

abio1_00(i)=sum(sum(abovio1_00(:,:,i)));
abio2_00(i)=sum(sum(abovio2_00(:,:,i)));
abio3_00(i)=sum(sum(abovio3_00(:,:,i)));
abio4_00(i)=sum(sum(abovio4_00(:,:,i)));

abio1_99(i)=sum(sum(abovio1_99(:,:,i)));
abio2_99(i)=sum(sum(abovio2_99(:,:,i)));
abio3_99(i)=sum(sum(abovio3_99(:,:,i)));
abio4_99(i)=sum(sum(abovio4_99(:,:,i)));

abio1_98(i)=sum(sum(abovio1_98(:,:,i)));
abio2_98(i)=sum(sum(abovio2_98(:,:,i)));
abio3_98(i)=sum(sum(abovio3_98(:,:,i)));
abio4_98(i)=sum(sum(abovio4_98(:,:,i)));

abio1_97(i)=sum(sum(abovio1_97(:,:,i)));
abio2_97(i)=sum(sum(abovio2_97(:,:,i)));
abio3_97(i)=sum(sum(abovio3_97(:,:,i)));
abio4_97(i)=sum(sum(abovio4_97(:,:,i)));

abio1_96(i)=sum(sum(abovio1_96(:,:,i)));
abio2_96(i)=sum(sum(abovio2_96(:,:,i)));
abio3_96(i)=sum(sum(abovio3_96(:,:,i)));
abio4_96(i)=sum(sum(abovio4_96(:,:,i)));

abio1_95(i)=sum(sum(abovio1_95(:,:,i)));
abio2_95(i)=sum(sum(abovio2_95(:,:,i)));
abio3_95(i)=sum(sum(abovio3_95(:,:,i)));
abio4_95(i)=sum(sum(abovio4_95(:,:,i)));

end

for i=1:M
dens1_11(i)=(abio1_11(i)-N1)/(N1*(N1-1));
dens2_11(i)=(abio2_11(i)-N1)/(N1*(N1-1));
dens3_11(i)=(abio3_11(i)-N1)/(N1*(N1-1));
dens4_11(i)=(abio4_11(i)-N1)/(N1*(N1-1));


dens1_10(i)=(abio1_10(i)-N1)/(N1*(N1-1));
dens2_10(i)=(abio2_10(i)-N1)/(N1*(N1-1));
dens3_10(i)=(abio3_10(i)-N1)/(N1*(N1-1));
dens4_10(i)=(abio4_10(i)-N1)/(N1*(N1-1));

dens1_09(i)=(abio1_09(i)-N1)/(N1*(N1-1));
dens2_09(i)=(abio2_09(i)-N1)/(N1*(N1-1));
dens3_09(i)=(abio3_09(i)-N1)/(N1*(N1-1));
dens4_09(i)=(abio4_09(i)-N1)/(N1*(N1-1));

dens1_08(i)=(abio1_08(i)-N1)/(N1*(N1-1));
dens2_08(i)=(abio2_08(i)-N1)/(N1*(N1-1));
dens3_08(i)=(abio3_08(i)-N1)/(N1*(N1-1));
dens4_08(i)=(abio4_08(i)-N1)/(N1*(N1-1));

dens1_07(i)=(abio1_07(i)-N1)/(N1*(N1-1));
dens2_07(i)=(abio2_07(i)-N1)/(N1*(N1-1));
dens3_07(i)=(abio3_07(i)-N1)/(N1*(N1-1));
dens4_07(i)=(abio4_07(i)-N1)/(N1*(N1-1));

dens1_06(i)=(abio1_06(i)-N1)/(N1*(N1-1));
dens2_06(i)=(abio2_06(i)-N1)/(N1*(N1-1));
dens3_06(i)=(abio3_06(i)-N1)/(N1*(N1-1));
dens4_06(i)=(abio4_06(i)-N1)/(N1*(N1-1));

dens1_05(i)=(abio1_05(i)-N1)/(N1*(N1-1));
dens2_05(i)=(abio2_05(i)-N1)/(N1*(N1-1));
dens3_05(i)=(abio3_05(i)-N1)/(N1*(N1-1));
dens4_05(i)=(abio4_05(i)-N1)/(N1*(N1-1));

dens1_04(i)=(abio1_04(i)-N1)/(N1*(N1-1));
dens2_04(i)=(abio2_04(i)-N1)/(N1*(N1-1));
dens3_04(i)=(abio3_04(i)-N1)/(N1*(N1-1));
dens4_04(i)=(abio4_04(i)-N1)/(N1*(N1-1));

dens1_03(i)=(abio1_03(i)-N1)/(N1*(N1-1));
dens2_03(i)=(abio2_03(i)-N1)/(N1*(N1-1));
dens3_03(i)=(abio3_03(i)-N1)/(N1*(N1-1));
dens4_03(i)=(abio4_03(i)-N1)/(N1*(N1-1));

dens1_02(i)=(abio1_02(i)-N1)/(N1*(N1-1));
dens2_02(i)=(abio2_02(i)-N1)/(N1*(N1-1));
dens3_02(i)=(abio3_02(i)-N1)/(N1*(N1-1));
dens4_02(i)=(abio4_02(i)-N1)/(N1*(N1-1));

dens1_01(i)=(abio1_01(i)-N1)/(N1*(N1-1));
dens2_01(i)=(abio2_01(i)-N1)/(N1*(N1-1));
dens3_01(i)=(abio3_01(i)-N1)/(N1*(N1-1));
dens4_01(i)=(abio4_01(i)-N1)/(N1*(N1-1));

dens1_00(i)=(abio1_00(i)-N1)/(N1*(N1-1));
dens2_00(i)=(abio2_00(i)-N1)/(N1*(N1-1));
dens3_00(i)=(abio3_00(i)-N1)/(N1*(N1-1));
dens4_00(i)=(abio4_00(i)-N1)/(N1*(N1-1));

dens1_99(i)=(abio1_99(i)-N1)/(N1*(N1-1));
dens2_99(i)=(abio2_99(i)-N1)/(N1*(N1-1));
dens3_99(i)=(abio3_99(i)-N1)/(N1*(N1-1));
dens4_99(i)=(abio4_99(i)-N1)/(N1*(N1-1));

dens1_98(i)=(abio1_98(i)-N1)/(N1*(N1-1));
dens2_98(i)=(abio2_98(i)-N1)/(N1*(N1-1));
dens3_98(i)=(abio3_98(i)-N1)/(N1*(N1-1));
dens4_98(i)=(abio4_98(i)-N1)/(N1*(N1-1));

dens1_97(i)=(abio1_97(i)-N1)/(N1*(N1-1));
dens2_97(i)=(abio2_97(i)-N1)/(N1*(N1-1));
dens3_97(i)=(abio3_97(i)-N1)/(N1*(N1-1));
dens4_97(i)=(abio4_97(i)-N1)/(N1*(N1-1));

dens1_96(i)=(abio1_96(i)-N1)/(N1*(N1-1));
dens2_96(i)=(abio2_96(i)-N1)/(N1*(N1-1));
dens3_96(i)=(abio3_96(i)-N1)/(N1*(N1-1));
dens4_96(i)=(abio4_96(i)-N1)/(N1*(N1-1));

dens1_95(i)=(abio1_95(i)-N1)/(N1*(N1-1));
dens2_95(i)=(abio2_95(i)-N1)/(N1*(N1-1));
dens3_95(i)=(abio3_95(i)-N1)/(N1*(N1-1));
dens4_95(i)=(abio4_95(i)-N1)/(N1*(N1-1));

end

%Other features of production structure



fin11=zeros(M,1);
fin10=zeros(M,1);
fin09=zeros(M,1);
fin08=zeros(M,1);
fin07=zeros(M,1);
fin06=zeros(M,1);
fin05=zeros(M,1);
fin04=zeros(M,1);
fin03=zeros(M,1);
fin02=zeros(M,1);
fin01=zeros(M,1);
fin00=zeros(M,1);
fin99=zeros(M,1);
fin98=zeros(M,1);
fin97=zeros(M,1);
fin96=zeros(M,1);
fin95=zeros(M,1);

for i=1:M
fin11(i)=(output2011(1,25,i))/sum(output2011(1,:,i));
fin10(i)=(output2010(1,25,i))/sum(output2010(1,:,i));
fin09(i)=(output2009(1,25,i))/sum(output2009(1,:,i));
fin08(i)=(output2008(1,25,i))/sum(output2008(1,:,i));
fin07(i)=(output2007(1,25,i))/sum(output2007(1,:,i));
fin06(i)=(output2006(1,25,i))/sum(output2006(1,:,i));
fin05(i)=(output2005(1,25,i))/sum(output2005(1,:,i));
fin04(i)=(output2004(1,25,i))/sum(output2004(1,:,i));
fin03(i)=(output2003(1,25,i))/sum(output2003(1,:,i));
fin02(i)=(output2002(1,25,i))/sum(output2002(1,:,i));
fin01(i)=(output2001(1,25,i))/sum(output2001(1,:,i));
fin00(i)=(output2000(1,25,i))/sum(output2000(1,:,i));
fin99(i)=(output1999(1,25,i))/sum(output1999(1,:,i));
fin98(i)=(output1998(1,25,i))/sum(output1998(1,:,i));
fin97(i)=(output1997(1,25,i))/sum(output1997(1,:,i));
fin96(i)=(output1996(1,25,i))/sum(output1996(1,:,i));
fin95(i)=(output1995(1,25,i))/sum(output1995(1,:,i));
end

nr11=zeros(M,1);
nr10=zeros(M,1);
nr09=zeros(M,1);
nr08=zeros(M,1);
nr07=zeros(M,1);
nr06=zeros(M,1);
nr05=zeros(M,1);
nr04=zeros(M,1);
nr03=zeros(M,1);
nr02=zeros(M,1);
nr01=zeros(M,1);
nr00=zeros(M,1);
nr99=zeros(M,1);
nr98=zeros(M,1);
nr97=zeros(M,1);
nr96=zeros(M,1);
nr95=zeros(M,1);

for i=1:M
nr11(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2011(1,:,i));
nr10(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2010(1,:,i));
nr09(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2009(1,:,i));
nr08(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2008(1,:,i));
nr07(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2007(1,:,i));
nr06(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2006(1,:,i));
nr05(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2005(1,:,i));
nr04(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2004(1,:,i));
nr03(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2003(1,:,i));
nr02(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2002(1,:,i));
nr01(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2001(1,:,i));
nr00(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output2000(1,:,i));
nr99(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output1999(1,:,i));
nr98(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output1998(1,:,i));
nr97(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output1997(1,:,i));
nr96(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output1996(1,:,i));
nr95(i)=(output2011(1,1,i)+output2011(1,2,i)+output2011(1,3,i))/sum(output1995(1,:,i));
end



service11=zeros(M,1);
service10=zeros(M,1);
service09=zeros(M,1);
service08=zeros(M,1);
service07=zeros(M,1);
service06=zeros(M,1);
service05=zeros(M,1);
service04=zeros(M,1);
service03=zeros(M,1);
service02=zeros(M,1);
service01=zeros(M,1);
service00=zeros(M,1);
service99=zeros(M,1);
service98=zeros(M,1);
service97=zeros(M,1);
service96=zeros(M,1);
service95=zeros(M,1);

for i=1:M
service11(i)=(sum(output2011(1,19:N1,i))/sum(output2011(1,:,i)));
service10(i)=(sum(output2010(1,19:N1,i))/sum(output2010(1,:,i)));
service09(i)=(sum(output2009(1,19:N1,i))/sum(output2009(1,:,i)));
service08(i)=(sum(output2008(1,19:N1,i))/sum(output2008(1,:,i)));
service07(i)=(sum(output2007(1,19:N1,i))/sum(output2007(1,:,i)));
service06(i)=(sum(output2006(1,19:N1,i))/sum(output2006(1,:,i)));
service05(i)=(sum(output2005(1,19:N1,i))/sum(output2005(1,:,i)));
service04(i)=(sum(output2004(1,19:N1,i))/sum(output2004(1,:,i)));
service03(i)=(sum(output2003(1,19:N1,i))/sum(output2003(1,:,i)));
service02(i)=(sum(output2002(1,19:N1,i))/sum(output2002(1,:,i)));
service01(i)=(sum(output2001(1,19:N1,i))/sum(output2001(1,:,i)));
service00(i)=(sum(output2000(1,19:N1,i))/sum(output2000(1,:,i)));
service99(i)=(sum(output1999(1,19:N1,i))/sum(output1999(1,:,i)));
service98(i)=(sum(output1998(1,19:N1,i))/sum(output1998(1,:,i)));
service97(i)=(sum(output1997(1,19:N1,i))/sum(output1997(1,:,i)));
service96(i)=(sum(output1996(1,19:N1,i))/sum(output1996(1,:,i)));
service95(i)=(sum(output1995(1,19:N1,i))/sum(output1995(1,:,i)));
end

for i=1:M
matsh11(:,i)=sum(mat2011(:,:,i),1)./output2011(:,:,i);
totmat11(i)=sum(sum(mat2011(:,:,i),1));
tout11(i)=sum(output2011(:,:,i));

matsh10(:,i)=sum(mat2010(:,:,i),1)./output2010(:,:,i);
totmat10(i)=sum(sum(mat2010(:,:,i),1));
tout10(i)=sum(output2010(:,:,i));

matsh09(:,i)=sum(mat2009(:,:,i),1)./output2009(:,:,i);
totmat09(i)=sum(sum(mat2009(:,:,i),1));
tout09(i)=sum(output2009(:,:,i));

matsh08(:,i)=sum(mat2008(:,:,i),1)./output2008(:,:,i);
totmat08(i)=sum(sum(mat2008(:,:,i),1));
tout08(i)=sum(output2008(:,:,i));

matsh07(:,i)=sum(mat2007(:,:,i),1)./output2007(:,:,i);
totmat07(i)=sum(sum(mat2007(:,:,i),1));
tout07(i)=sum(output2007(:,:,i));

matsh06(:,i)=sum(mat2006(:,:,i),1)./output2006(:,:,i);
totmat06(i)=sum(sum(mat2006(:,:,i),1));
tout06(i)=sum(output2006(:,:,i));

matsh05(:,i)=sum(mat2005(:,:,i),1)./output2005(:,:,i);
totmat05(i)=sum(sum(mat2005(:,:,i),1));
tout05(i)=sum(output2005(:,:,i));

matsh04(:,i)=sum(mat2004(:,:,i),1)./output2004(:,:,i);
totmat04(i)=sum(sum(mat2004(:,:,i),1));
tout04(i)=sum(output2004(:,:,i));

matsh03(:,i)=sum(mat2003(:,:,i),1)./output2003(:,:,i);
totmat03(i)=sum(sum(mat2003(:,:,i),1));
tout03(i)=sum(output2003(:,:,i));

matsh02(:,i)=sum(mat2002(:,:,i),1)./output2002(:,:,i);
totmat02(i)=sum(sum(mat2002(:,:,i),1));
tout02(i)=sum(output2002(:,:,i));

matsh01(:,i)=sum(mat2001(:,:,i),1)./output2001(:,:,i);
totmat01(i)=sum(sum(mat2001(:,:,i),1));
tout01(i)=sum(output2001(:,:,i));

matsh00(:,i)=sum(mat2000(:,:,i),1)./output2000(:,:,i);
totmat00(i)=sum(sum(mat2000(:,:,i),1));
tout00(i)=sum(output2000(:,:,i));

matsh99(:,i)=sum(mat1999(:,:,i),1)./output1999(:,:,i);
totmat99(i)=sum(sum(mat1999(:,:,i),1));
tout99(i)=sum(output1999(:,:,i));

matsh98(:,i)=sum(mat1998(:,:,i),1)./output1998(:,:,i);
totmat98(i)=sum(sum(mat1998(:,:,i),1));
tout98(i)=sum(output1998(:,:,i));

matsh97(:,i)=sum(mat1997(:,:,i),1)./output1997(:,:,i);
totmat97(i)=sum(sum(mat1997(:,:,i),1));
tout97(i)=sum(output1997(:,:,i));

matsh96(:,i)=sum(mat1996(:,:,i),1)./output1996(:,:,i);
totmat96(i)=sum(sum(mat1996(:,:,i),1));
tout96(i)=sum(output1996(:,:,i));

matsh95(:,i)=sum(mat1995(:,:,i),1)./output1995(:,:,i);
totmat95(i)=sum(sum(mat1995(:,:,i),1));
tout95(i)=sum(output1995(:,:,i));
end

avmatsh11=(totmat11./tout11)';
avmatsh10=(totmat10./tout10)';
avmatsh09=(totmat09./tout09)';
avmatsh08=(totmat08./tout08)';
avmatsh07=(totmat07./tout07)';
avmatsh06=(totmat06./tout06)';
avmatsh05=(totmat05./tout05)';
avmatsh04=(totmat04./tout04)';
avmatsh03=(totmat03./tout03)';
avmatsh02=(totmat02./tout02)';
avmatsh01=(totmat01./tout01)';
avmatsh00=(totmat00./tout00)';
avmatsh99=(totmat99./tout99)';
avmatsh98=(totmat98./tout98)';
avmatsh97=(totmat97./tout97)';
avmatsh96=(totmat96./tout96)';
avmatsh95=(totmat95./tout95)';

%Asymmetry in and out

doutio11=zeros(N1,M);
dinio11=zeros(N1,M);
doutio10=zeros(N1,M);
dinio10=zeros(N1,M);
doutio09=zeros(N1,M);
dinio09=zeros(N1,M);
doutio08=zeros(N1,M);
dinio08=zeros(N1,M);
doutio07=zeros(N1,M);
dinio07=zeros(N1,M);
doutio06=zeros(N1,M);
dinio06=zeros(N1,M);
doutio05=zeros(N1,M);
dinio05=zeros(N1,M);
doutio04=zeros(N1,M);
dinio04=zeros(N1,M);
doutio03=zeros(N1,M);
dinio03=zeros(N1,M);
doutio02=zeros(N1,M);
dinio02=zeros(N1,M);
doutio01=zeros(N1,M);
dinio01=zeros(N1,M);
doutio00=zeros(N1,M);
dinio00=zeros(N1,M);
doutio99=zeros(N1,M);
dinio99=zeros(N1,M);
doutio98=zeros(N1,M);
dinio98=zeros(N1,M);
doutio97=zeros(N1,M);
dinio97=zeros(N1,M);
doutio96=zeros(N1,M);
dinio96=zeros(N1,M);
doutio95=zeros(N1,M);
dinio95=zeros(N1,M);

for i=1:M
doutio11(:,i)=sum(io11(:,:,i),2); %importance as input supplier
doutio10(:,i)=sum(io10(:,:,i),2); %importance as input supplier
doutio09(:,i)=sum(io09(:,:,i),2); %importance as input supplier
doutio08(:,i)=sum(io08(:,:,i),2); %importance as input supplier
doutio07(:,i)=sum(io07(:,:,i),2); %importance as input supplier
doutio06(:,i)=sum(io06(:,:,i),2); %importance as input supplier
doutio05(:,i)=sum(io05(:,:,i),2); %importance as input supplier
doutio04(:,i)=sum(io04(:,:,i),2); %importance as input supplier
doutio03(:,i)=sum(io03(:,:,i),2); %importance as input supplier
doutio02(:,i)=sum(io02(:,:,i),2); %importance as input supplier
doutio01(:,i)=sum(io01(:,:,i),2); %importance as input supplier
doutio00(:,i)=sum(io00(:,:,i),2); %importance as input supplier
doutio99(:,i)=sum(io99(:,:,i),2); %importance as input supplier
doutio98(:,i)=sum(io98(:,:,i),2); %importance as input supplier
doutio97(:,i)=sum(io97(:,:,i),2); %importance as input supplier
doutio96(:,i)=sum(io96(:,:,i),2); %importance as input supplier
doutio95(:,i)=sum(io95(:,:,i),2); %importance as input supplier
end

for i=1:M
dinio11(:,i)=sum(io11(:,:,i),1); %total intermediate input shares across commodities
dinio10(:,i)=sum(io10(:,:,i),1); %total intermediate input shares across commodities
dinio09(:,i)=sum(io09(:,:,i),1); %total intermediate input shares across commodities
dinio08(:,i)=sum(io08(:,:,i),1); %total intermediate input shares across commodities
dinio07(:,i)=sum(io07(:,:,i),1); %total intermediate input shares across commodities
dinio06(:,i)=sum(io06(:,:,i),1); %total intermediate input shares across commodities
dinio05(:,i)=sum(io05(:,:,i),1); %total intermediate input shares across commodities
dinio04(:,i)=sum(io04(:,:,i),1); %total intermediate input shares across commodities
dinio03(:,i)=sum(io03(:,:,i),1); %total intermediate input shares across commodities
dinio02(:,i)=sum(io02(:,:,i),1); %total intermediate input shares across commodities
dinio01(:,i)=sum(io01(:,:,i),1); %total intermediate input shares across commodities
dinio00(:,i)=sum(io00(:,:,i),1); %total intermediate input shares across commodities
dinio99(:,i)=sum(io99(:,:,i),1); %total intermediate input shares across commodities
dinio98(:,i)=sum(io98(:,:,i),1); %total intermediate input shares across commodities
dinio97(:,i)=sum(io97(:,:,i),1); %total intermediate input shares across commodities
dinio96(:,i)=sum(io96(:,:,i),1); %total intermediate input shares across commodities
dinio95(:,i)=sum(io95(:,:,i),1); %total intermediate input shares across commodities
end






epsm=0.5;

for i=1:M
totinp11(:,:,i)=kron(sum(mat2011(:,:,i)),ones(N1,1));
totinp10(:,:,i)=kron(sum(mat2010(:,:,i)),ones(N1,1));
totinp09(:,:,i)=kron(sum(mat2009(:,:,i)),ones(N1,1));
totinp08(:,:,i)=kron(sum(mat2008(:,:,i)),ones(N1,1));
totinp07(:,:,i)=kron(sum(mat2007(:,:,i)),ones(N1,1));
totinp06(:,:,i)=kron(sum(mat2006(:,:,i)),ones(N1,1));
totinp05(:,:,i)=kron(sum(mat2005(:,:,i)),ones(N1,1));
totinp04(:,:,i)=kron(sum(mat2004(:,:,i)),ones(N1,1));
totinp03(:,:,i)=kron(sum(mat2003(:,:,i)),ones(N1,1));
totinp02(:,:,i)=kron(sum(mat2002(:,:,i)),ones(N1,1));
totinp01(:,:,i)=kron(sum(mat2001(:,:,i)),ones(N1,1));
totinp00(:,:,i)=kron(sum(mat2000(:,:,i)),ones(N1,1));
totinp99(:,:,i)=kron(sum(mat1999(:,:,i)),ones(N1,1));
totinp98(:,:,i)=kron(sum(mat1998(:,:,i)),ones(N1,1));
totinp97(:,:,i)=kron(sum(mat1997(:,:,i)),ones(N1,1));
totinp96(:,:,i)=kron(sum(mat1996(:,:,i)),ones(N1,1));
totinp95(:,:,i)=kron(sum(mat1995(:,:,i)),ones(N1,1));
end

%IO Omegas
for i=1:M
oio11(:,:,i)=mat2011(:,:,i)./totinp11(:,:,i);
oio10(:,:,i)=mat2010(:,:,i)./totinp10(:,:,i);
oio09(:,:,i)=mat2009(:,:,i)./totinp09(:,:,i);
oio08(:,:,i)=mat2008(:,:,i)./totinp08(:,:,i);
oio07(:,:,i)=mat2007(:,:,i)./totinp07(:,:,i);
oio06(:,:,i)=mat2006(:,:,i)./totinp06(:,:,i);
oio05(:,:,i)=mat2005(:,:,i)./totinp05(:,:,i);
oio04(:,:,i)=mat2004(:,:,i)./totinp04(:,:,i);
oio03(:,:,i)=mat2003(:,:,i)./totinp03(:,:,i);
oio02(:,:,i)=mat2002(:,:,i)./totinp02(:,:,i);
oio01(:,:,i)=mat2001(:,:,i)./totinp01(:,:,i);
oio00(:,:,i)=mat2000(:,:,i)./totinp00(:,:,i);
oio99(:,:,i)=mat1999(:,:,i)./totinp99(:,:,i);
oio98(:,:,i)=mat1998(:,:,i)./totinp98(:,:,i);
oio97(:,:,i)=mat1997(:,:,i)./totinp97(:,:,i);
oio96(:,:,i)=mat1996(:,:,i)./totinp96(:,:,i);
oio95(:,:,i)=mat1995(:,:,i)./totinp95(:,:,i);
end

divers11=zeros(N1,M);
divers10=zeros(N1,M);
divers09=zeros(N1,M);
divers08=zeros(N1,M);
divers07=zeros(N1,M);
divers06=zeros(N1,M);
divers05=zeros(N1,M);
divers04=zeros(N1,M);
divers03=zeros(N1,M);
divers02=zeros(N1,M);
divers01=zeros(N1,M);
divers00=zeros(N1,M);
divers99=zeros(N1,M);
divers98=zeros(N1,M);
divers97=zeros(N1,M);
divers96=zeros(N1,M);
divers95=zeros(N1,M);

for i=1:M
divers11(:,i)=(sum(oio11(:,:,i).^(epsm))).^(1/(1-epsm));
divers10(:,i)=(sum(oio10(:,:,i).^(epsm))).^(1/(1-epsm));
divers09(:,i)=(sum(oio09(:,:,i).^(epsm))).^(1/(1-epsm));
divers08(:,i)=(sum(oio08(:,:,i).^(epsm))).^(1/(1-epsm));
divers07(:,i)=(sum(oio07(:,:,i).^(epsm))).^(1/(1-epsm));
divers06(:,i)=(sum(oio06(:,:,i).^(epsm))).^(1/(1-epsm));
divers05(:,i)=(sum(oio05(:,:,i).^(epsm))).^(1/(1-epsm));
divers04(:,i)=(sum(oio04(:,:,i).^(epsm))).^(1/(1-epsm));
divers03(:,i)=(sum(oio03(:,:,i).^(epsm))).^(1/(1-epsm));
divers02(:,i)=(sum(oio02(:,:,i).^(epsm))).^(1/(1-epsm));
divers01(:,i)=(sum(oio01(:,:,i).^(epsm))).^(1/(1-epsm));
divers00(:,i)=(sum(oio00(:,:,i).^(epsm))).^(1/(1-epsm));
divers99(:,i)=(sum(oio99(:,:,i).^(epsm))).^(1/(1-epsm));
divers98(:,i)=(sum(oio98(:,:,i).^(epsm))).^(1/(1-epsm));
divers97(:,i)=(sum(oio97(:,:,i).^(epsm))).^(1/(1-epsm));
divers96(:,i)=(sum(oio96(:,:,i).^(epsm))).^(1/(1-epsm));
divers95(:,i)=(sum(oio95(:,:,i).^(epsm))).^(1/(1-epsm));
end

for i=1:M
ssh95(i,:)=output1995(1,:,i)./sum(output1995(1,:,i));
ssh96(i,:)=output1996(1,:,i)./sum(output1996(1,:,i));
ssh97(i,:)=output1997(1,:,i)./sum(output1997(1,:,i));
ssh98(i,:)=output1998(1,:,i)./sum(output1998(1,:,i));
ssh99(i,:)=output1999(1,:,i)./sum(output1999(1,:,i));
ssh00(i,:)=output2000(1,:,i)./sum(output2000(1,:,i));
ssh01(i,:)=output2001(1,:,i)./sum(output2001(1,:,i));
ssh02(i,:)=output2002(1,:,i)./sum(output2002(1,:,i));
ssh03(i,:)=output2003(1,:,i)./sum(output2003(1,:,i));
ssh04(i,:)=output2004(1,:,i)./sum(output2004(1,:,i));
ssh05(i,:)=output2005(1,:,i)./sum(output2005(1,:,i));
ssh06(i,:)=output2006(1,:,i)./sum(output2006(1,:,i));
ssh07(i,:)=output2007(1,:,i)./sum(output2007(1,:,i));
ssh08(i,:)=output2008(1,:,i)./sum(output2008(1,:,i));
ssh09(i,:)=output2009(1,:,i)./sum(output2009(1,:,i));
ssh10(i,:)=output2010(1,:,i)./sum(output2010(1,:,i));
ssh11(i,:)=output2011(1,:,i)./sum(output2011(1,:,i));
end

for i=1:M
wdiv11=mean(divers11)'; 
wdiv10=mean(divers10)';
wdiv09=mean(divers09)';
wdiv08=mean(divers08)';
wdiv07=mean(divers07)';
wdiv06=mean(divers06)';
wdiv05=mean(divers05)';
wdiv04=mean(divers04)';
wdiv03=mean(divers03)';
wdiv02=mean(divers02)';
wdiv01=mean(divers01)';
wdiv00=mean(divers00)';
wdiv99=mean(divers99)';
wdiv98=mean(divers98)';
wdiv97=mean(divers97)';
wdiv96=mean(divers96)';
wdiv95=mean(divers95)';
end


%Sectoral Dominance Acemolgu et al (2016) 

MULT11=zeros(1,M);
MULT10=zeros(1,M);
MULT09=zeros(1,M);
MULT08=zeros(1,M);
MULT07=zeros(1,M);
MULT06=zeros(1,M);
MULT05=zeros(1,M);
MULT04=zeros(1,M);
MULT03=zeros(1,M);
MULT02=zeros(1,M);
MULT01=zeros(1,M);
MULT00=zeros(1,M);
MULT99=zeros(1,M);
MULT98=zeros(1,M);
MULT97=zeros(1,M);
MULT96=zeros(1,M);
MULT95=zeros(1,M);


%Forward IO linkages 9 March 2023 - edit the code, Jose - put in loop
% 
for i=1:M
MULT11(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io11(:,:,i))*ones(N1,1);
MULT10(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io10(:,:,i))*ones(N1,1);
MULT09(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io09(:,:,i))*ones(N1,1);
MULT08(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io08(:,:,i))*ones(N1,1);
MULT07(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io07(:,:,i))*ones(N1,1);
MULT06(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io06(:,:,i))*ones(N1,1);
MULT05(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io05(:,:,i))*ones(N1,1);
MULT04(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io04(:,:,i))*ones(N1,1);
MULT03(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io03(:,:,i))*ones(N1,1);
MULT02(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io02(:,:,i))*ones(N1,1);
MULT01(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io01(:,:,i))*ones(N1,1);
MULT00(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io00(:,:,i))*ones(N1,1);
MULT99(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io99(:,:,i))*ones(N1,1);
MULT98(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io98(:,:,i))*ones(N1,1);
MULT97(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io97(:,:,i))*ones(N1,1);
MULT96(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io96(:,:,i))*ones(N1,1);
MULT95(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io95(:,:,i))*ones(N1,1);
end






MULT11_tilde = zeros(1, M);
MULT10_tilde = zeros(1, M);
MULT09_tilde = zeros(1, M);
MULT08_tilde = zeros(1, M);
MULT07_tilde = zeros(1, M);
MULT06_tilde = zeros(1, M);
MULT05_tilde = zeros(1, M);
MULT04_tilde = zeros(1, M);
MULT03_tilde = zeros(1, M);
MULT02_tilde = zeros(1, M);
MULT01_tilde = zeros(1, M);
MULT00_tilde = zeros(1, M);
MULT99_tilde = zeros(1, M);
MULT98_tilde = zeros(1, M);
MULT97_tilde = zeros(1, M);
MULT96_tilde = zeros(1, M);
MULT95_tilde = zeros(1, M);



%For IO linkages

for i=1:M
MULT11_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io11_tilde(:,:,i)')*ones(N1,1);
MULT10_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io10_tilde(:,:,i)')*ones(N1,1);
MULT09_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io09_tilde(:,:,i)')*ones(N1,1);
MULT08_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io08_tilde(:,:,i)')*ones(N1,1);
MULT07_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io07_tilde(:,:,i)')*ones(N1,1);
MULT06_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io06_tilde(:,:,i)')*ones(N1,1);
MULT05_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io05_tilde(:,:,i)')*ones(N1,1);
MULT04_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io04_tilde(:,:,i)')*ones(N1,1);
MULT03_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io03_tilde(:,:,i)')*ones(N1,1);
MULT02_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io02_tilde(:,:,i)')*ones(N1,1);
MULT01_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io01_tilde(:,:,i)')*ones(N1,1);
MULT00_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io00_tilde(:,:,i)')*ones(N1,1);
MULT99_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io99_tilde(:,:,i)')*ones(N1,1);
MULT98_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io98_tilde(:,:,i)')*ones(N1,1);
MULT97_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io97_tilde(:,:,i)')*ones(N1,1);
MULT96_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io96_tilde(:,:,i)')*ones(N1,1);
MULT95_tilde(:,i)=(1/N1)*ones(1, N1)*inv(eye(N1)-io95_tilde(:,:,i)')*ones(N1,1);
end


% Forward IO Linkages


for_11=MULT11';
for_10=MULT10';
for_09=MULT09';
for_08=MULT08';
for_07=MULT07';
for_06=MULT06';
for_05=MULT05';
for_04=MULT04';
for_03=MULT03';
for_02=MULT02';
for_01=MULT01';
for_00=MULT00';
for_99=MULT99';
for_98=MULT98';
for_97=MULT97';
for_96=MULT96';
for_95=MULT95';


% Backward IO Linkages



back_11=MULT11_tilde';
back_10=MULT10_tilde';
back_09=MULT09_tilde';
back_08=MULT08_tilde';
back_07=MULT07_tilde';
back_06=MULT06_tilde';
back_05=MULT05_tilde';
back_04=MULT04_tilde';
back_03=MULT03_tilde';
back_02=MULT02_tilde';
back_01=MULT01_tilde';
back_00=MULT00_tilde';
back_99=MULT99_tilde';
back_98=MULT98_tilde';
back_97=MULT97_tilde';
back_96=MULT96_tilde';
back_95=MULT95_tilde';



%Eliminates country outliers
keep=[1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20 22 23 24 25 26 27 28 29 30 ...
   31 32 33 34 35 36 37 39 40 41 42 43 44 46 47 48 49 50 52 53 54 55 56 57 59 60 61]';




natural_resource=[nr95 nr96 nr97 nr98 nr99 nr00 nr01 nr02 nr03 nr04 nr05 nr06 nr07 nr08 nr09 nr10 nr11];
density=[dens1_95 dens1_96 dens1_97 dens1_98 dens1_99 dens1_00 dens1_01 dens1_02 dens1_03 dens1_04 dens1_05 dens1_06 dens1_07 dens1_08 dens1_09 dens1_10 dens1_11];
dens2_95=[dens2_96 dens2_97 dens2_98 dens2_99 dens2_00 dens2_01 dens2_02 dens2_03 dens2_04 dens2_05 dens2_06 dens2_07 dens2_08 dens2_09 dens2_10 dens2_11]; 
dens3_95=[dens3_96 dens3_97 dens3_98 dens3_99 dens3_00 dens3_01 dens3_02 dens3_03 dens3_04 dens3_05 dens3_06 dens3_07 dens3_08 dens3_09 dens3_10 dens3_11];
%finance=[fin95 fin96 fin97 fin98 fin99 fin00 fin01 fin02 fin03 fin04 fin05 fin06 fin07 fin 08 fin09 fin10 fin11];
wdiv=[wdiv95 wdiv96 wdiv97 wdiv98 wdiv99 wdiv00 wdiv01 wdiv02 wdiv03 wdiv04 wdiv05 wdiv06 wdiv07 wdiv08 wdiv09 wdiv10 wdiv11];
avmat=[avmatsh95 avmatsh96 avmatsh97 avmatsh98 avmatsh99 avmatsh00 avmatsh01 avmatsh02 avmatsh03 avmatsh04 avmatsh05 avmatsh06 avmatsh07 avmatsh08 avmatsh09 avmatsh10 avmatsh11]; 
services=[service95 service96 service97 service98 service99 service00 service01 service02 service03 service04 service05 service06 service07 service08 service09 service10 service11];
%fo_link=[for_link95 for_link96 for_link97 for_link98 for_link99 for_link00 for_link01 for_link02 for_link03 for_link04 for_link05 for_link06 for_link07 for_link08 for_link09 for_link10 for_link11];
%back_link=[back_link95 back_link96 back_link97 back_link98 back_link99 back_link00 back_link01 back_link02 back_link03 back_link04 back_link05 back_link06 back_link07 back_link08 back_link09 back_link10 back_link11];
%divers=[divers95 divers96 divers97 divers98 divers99 divers00 divers01 divers02 divers03 divers04 divers05 divers06 divers07 divers08 divers09 divers10 divers11]
%impavmat=[impavmatsh95 impavmatsh96 impavmatsh97 impavmatsh98 impavmatsh99 impavmatsh00 impavmatsh01 impavmatsh02 impavmatsh03 impavmatsh04 impavmatsh05 impavmatsh06 impavmatsh07 impavmatsh08 impavmatsh09 impavmatsh10 impavmatsh11]; 
%servicesva=[serviceva95 serviceva96 serviceva97 serviceva98 serviceva99 serviceva00 serviceva01 serviceva02 serviceva03 serviceva04 serviceva05 serviceva06 serviceva07 serviceva08 serviceva09 serviceva10 serviceva11];



Tnetwork2=table(for_95,for_96,for_97,for_98,for_99,for_00,for_01,for_02,for_03,for_04,for_05,for_06,for_07,for_08,for_09,for_10,for_11,back_95,back_96,back_97,back_98,back_99,back_00,back_01,back_02,back_03,back_04,back_05,back_06,back_07,back_08,back_09,back_10,back_11,nr95, nr96, nr97, nr98, nr99, nr00, nr01, nr02, nr03, nr04, nr05, nr06, nr07, nr08, nr09, nr10, nr11,dens1_95,dens1_96,dens1_97,dens1_98,dens1_99,dens1_00,dens1_01,dens1_02,dens1_03,dens1_04,dens1_05,dens1_06,dens1_07,dens1_08,dens1_09,dens1_10,dens1_11,dens2_95,dens2_96,dens2_97,dens2_98,dens2_99,dens2_00,dens2_01,dens2_02,dens2_03,dens2_04,dens2_05,dens2_06,dens2_07,dens2_08,dens2_09,dens2_10,dens2_11,dens3_95,dens3_96,dens3_97,dens3_98,dens3_99,dens3_00,dens3_01,dens3_02,dens3_03,dens3_04,dens3_05,dens3_06,dens3_07,dens3_08,dens3_09,dens3_10,dens3_11,dens4_95,dens4_96,dens4_97,dens4_98,dens4_99,dens4_00,dens4_01,dens4_02,dens4_03,dens4_04,dens4_05,dens4_06,dens4_07,dens4_08,dens4_09,dens4_10,dens4_11,avmatsh95,avmatsh96,avmatsh97,avmatsh98,avmatsh99,avmatsh00,avmatsh01,avmatsh02,avmatsh03,avmatsh04,avmatsh05,avmatsh06,avmatsh07,avmatsh08,avmatsh09,avmatsh10,avmatsh11,service95,service96,service97,service98,service99,service00,service01,service02,service03,service04,service05,service06,service07,service08,service09,service10,service11,fin95,fin96,fin97,fin98,fin99,fin00,fin01,fin02,fin03,fin04,fin05,fin06,fin07,fin08,fin09,fin10,fin11,wdiv95,wdiv96,wdiv97,wdiv98,wdiv99,wdiv00,wdiv01,wdiv02,wdiv03,wdiv04,wdiv05,wdiv06,wdiv07,wdiv08,wdiv09,wdiv10,wdiv11);
filename = 'network_tot_JEBO.xlsx';
writetable(Tnetwork2,filename,'Sheet',1)

