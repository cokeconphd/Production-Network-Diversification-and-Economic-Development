fulldata = xlsread("master1.xlsx","OECD.Stat export","AO5:AO39410");

%year 2011

M=61; %number of countries
N=33; %number of industries
K=16;
% mat1995=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
% 
% mat2011=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
%   
% matrices organised by year
supermat = zeros(N,1,M,16);
finish = -5; %to be consistent
for country = 1:M
    for year = 1:K+1
        start = finish+6;
        finish = start+N-1;
        supermat(:,:,country,year) = fulldata(start:finish,:);
    end
end

for year = 0:16
    % create matrix with correct name
    matrixname= strjoin({'cons',num2str(1995+year)},'');
    % memory allocation
    eval([matrixname,' = zeros(N,1,M)']);
    eval([matrixname,' = supermat(:,:,:,year+1)']);
    % create output filename
    out=strjoin({'cons',num2str(1995+year),'.mat'},'');
    save(out,matrixname);
end
