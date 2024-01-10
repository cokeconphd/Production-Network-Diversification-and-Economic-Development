 

fulldata = xlsread("master_dom1.xlsx","OECD.Stat export","G5:AM74668");


M=61; %number of countries
N=33; %number of industries
K=16;
% mat1995=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
% 
% mat2011=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
% 
% matrices organised by year
supermat = zeros(N,N,M,16);
finish = -39; %to be consistent
for country = 1:M
    for year = 1:K+1
        start = finish+40;
        finish = start+N-1;
        supermat(:,:,country,year) = fulldata(start:finish,:);
    end
end

for year = 0:16
    % create matrix with correct name
    matrixname= strjoin({'matdom',num2str(1995+year)},'');
    % memory allocation
    eval([matrixname,' = zeros(N,N,M)']);
    eval([matrixname,' = supermat(:,:,:,year+1)']);
    % create output filename
    out=strjoin({'iodom',num2str(1995+year),'.mat'},'');
    save(out,matrixname);
end