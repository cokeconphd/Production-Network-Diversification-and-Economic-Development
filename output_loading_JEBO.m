fulldata = xlsread("master1.xlsx","OECD.Stat export","G5:AM39410");

%year 2011

M=61; %number of countries
N=33; %number of industries
K=16;
% mat1995=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
% 
% mat2011=zeros(N,N,M); %Creates a big array that contains M square matrices of dimension N
% 
% matrices organised by year
supermat = zeros(1,N,M,16);
finish = -5; %to be consistent
line = 0;
for country = 1:M
    for year = 1:K+1
        line = line + 38;
        supermat(:,:,country,year) = fulldata(line,:);
    end
end

    for year = 0:16
        % create matrix with correct name
        matrixname= strjoin({'output',num2str(1995+year)},'');
        % memory allocation
        eval([matrixname,' = zeros(1,N,M);']);
        eval([matrixname,' = supermat(:,:,:,year+1);']);
        % create output filename
        out=strjoin({'output',num2str(1995+year),'.mat'},'');
        save(out,matrixname);
    end
