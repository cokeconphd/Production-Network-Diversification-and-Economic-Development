%-------------------------------------------------------------------------%
%-----------Gloria, Miranda-Pinto, Fleming-Munoz%(2023)-------------------%
%------Production Network Diversification and Economic Development--------%
%----Prepared for Journal of Economic Behavior and Organization (A*)------%
%-------------------------------------------------------------------------%

clear all; close all; clc

cd 'C:\Users\uqjmira1\Dropbox\Development_Diversification\JEBO\ReplicationFiles_JEBO\'
addpath('C:\Users\uqjmira1\Dropbox\Development_Diversification\JEBO\ReplicationFiles_JEBO\')

% -------------------------------------------------------------------------
%-----------------------Load OECD IO data---------------------------------- 
% -------------------------------------------------------------------------

load 'iodom1995'
load 'output1995'
load 'cons1995'

%Sample of countries in the paper

% Countries for counterfactual are \

%Thailand vs Denmark
keep=[59 7]'; 

%Canada vs Denmark
%keep=[4 7]'; 

%Canada vs Germany
%keep=[4 11]'; 

%Mexico vs USA 
%keep=[22 35]'; 

%Phillipines vs Australia
%keep=[52 1]'; 

%Indonesia vs Australia
%keep=[48 1]'; 

%Indonesia vs USA
%keep=[48 1]'; 

%Mexico vs Australia
%keep=[22 1]'; 

matdom=matdom1995(:,:,keep);
output=output1995(1,:,keep);
consum=cons1995(:,1,keep);
zeros = find(sum(output == 0));
output(:,:, zeros) = [];
matdom(:,:, zeros) = [];
consum(:,:, zeros) = [];

error=1e-7;  
T=1000;
[N,N2,M]=size(matdom);
clear consum1995 cons1995 mat1995 iodom1995 output1995 N2 keep zeros

% -------------------------------------------------------------------------
%                        Set Parameters
% -------------------------------------------------------------------------

% Production function elasticities
epsQ = 1.3; 
rhoQ = (epsQ-1)/epsQ;
varrhoQ = 1/epsQ;

epsM =epsQ;
rhoM=(epsM-1)/epsM;

varrhoM=0.5923; 
z=ones(N,1);

% -------------------------------------------------------------------------
% Calibration of IO shares, consumption shares, and distribution parameter
% -------------------------------------------------------------------------
logGDP0_0_=zeros(M,1);
b_calib = zeros(N,M);
a_calib = zeros(N,M);
omega_calib = zeros(N,N,M);
model_share_ss = zeros(N,M);
opt_prices = ones(N, 1, M);
varrhoM_it = varrhoM; 
dens_data=zeros(M,1);
th1=0.0005;
varrhoM_it=varrhoM;

    for i=1:M
    % 1. gamma0: purchases from i to j / i's production (buyer relevance)
    gamma0 = (matdom(:,:,i)+error)./((output(1,:,i)'+error)*ones(1,N))';

    dens0   = (gamma0>th1);
    dens0   = sum(dens0);
    dens_data(i) = (sum(dens0)-N)/(N*(N-1));

    % COUNTERFACTUAL ALL i=1
    gamma0 = (matdom(:,:,1)+error)./((output(1,:,1)'+error)*ones(1,N))';

    % 2. omega: purchases from i to j / i's total intermediate purchases
    omega_data = (matdom(:,:,i)+error)./(sum(matdom(:,:,i)+error)'*ones(1,N))';
    
    % COUNTERFACTUAL ALL i=1
    %omega_data = (matdom(:,:,1)+error)./(sum(matdom(:,:,1)+error)'*ones(1,N))';
    
    omega0=omega_data;
    
    % 3. betas
    %betta= (consum(:,1,i)+error)./sum(consum(:,1,i)+error);
    %Beta(:,i) = betta;

    %counterfactual all i==1
    betta= (consum(:,1,1)+error)./sum(consum(:,1,1)+error);
    Beta(:,i) = betta;

    % b0 = total intermediate purchases / production
    b0=sum(gamma0)'; %initial guess

    data_shares=b0;
    Data_shares(:,i)=data_shares;
    a0=1-b0;    % labor participation

    %Initial conditions (epsq=epsm=1.01 case) -----------------------------
    epsq0=epsQ; epsm0=epsq0;
    varrhoq0 = 1./epsq0;
    varrhom0 = varrhoM_it;

    % Formula for P_j when epsQ=epsM (eq. 12)
    lnpp0 = 1./(1-epsq0).*(log(inv(eye(N)-(z*ones(1,N)).^(epsq0-1)...
          .*((((1-a0).^(varrhoq0*epsq0))*ones(1,N)).*(omega0').^(varrhom0*epsq0)))...
          *(z.^(epsq0-1).*a0.^(varrhoq0*epsq0))));
    pp0 = exp(lnpp0);

    % or ... find prices
    options = optimoptions('fsolve', 'MaxFunEvals',50000, 'MaxIter', 50000,...
        'OptimalityTolerance', 1.0000e-6);
    x0 = pp0;
    [x_sol,fvalue, exitflag] = fsolve(@(x) prices_RR(x,z,omega0,epsQ,epsM,...
        varrhoQ,varrhoM_it,a0),x0,options);
        if exitflag > 0
            disp('Solution found')
            opt_prices(:,i) = x_sol;
        else
            disp('Solution not found')
            opt_prices(:,i) = nan*ones(N,1);
        end
        pp0 = opt_prices(:,i);
        pm0 = ( (omega0.^(varrhoM_it.*epsM))'* pp0.^(1-epsM) ).^(1./(1-epsM)); % equation 15

    % Total intermediate input shares from the model (fraction of total output) 
    imp_share0 = (1-a0).*(pp0.*z).^(epsQ-1).*pm0.^(1-epsQ); % imp_share0 is the intermediate share equation on page 32, first one below section 6.2 title
    
    b1 = imp_share0.*(pp0.*z).^(1-epsQ).*pm0.^(epsQ-1);
    a1=1-b1;
            

    % Specific intermediate input shares (fraction of total intermediates) page 34 top, use initial value omega 0
    imp_shares_0 = (pp0 *ones(1,N)).^(1-epsQ).*((pm0*ones(1,N))').^(epsQ-1).*(omega0.^(varrhoM_it.*epsQ) );

    omega1 = (omega_data.^(1./(varrhoM_it.*epsQ))).*((pp0*ones(1,N)).^((epsQ-1)./(varrhoM_it.*epsQ))).*(((pm0*ones(1,N))').^((1-epsQ)./(varrhoM_it.*epsQ)));
    
    % -----------------------------------------------------------------
    %               Loop to find sectoral dist. parameters  
    % -----------------------------------------------------------------
    
error=10E-6;

     while (abs(max(max((imp_shares_0-omega_data)))) > error) || isnan(max(max((imp_shares_0-omega_data)))) || (abs(max((imp_share0-data_shares)))>error) ||  isnan(max((imp_share0-data_shares)))
        a0=a1;
        omega0=omega1;
          
        % fsolve %
        options = optimoptions('fsolve', 'MaxFunEvals',50000, 'MaxIter', 50000,...
            'OptimalityTolerance', 1.0000e-10);
        x0=pp0;

        
        [x_sol,fvalue, exitflag] = fsolve(@(x) prices_RR(x,z,omega0,epsQ,epsM,...
            varrhoQ,varrhoM_it,a0),x0,options);
        if exitflag > 0
            disp('Solution found')
            
            pp = x_sol;
            pm = ( (omega0.^(varrhoM_it.*epsM))'* pp.^(1-epsM) ).^(1./(1-epsM)); % equation 15
            pm_ss(:,i) = pm;
        
            %Model implied vector of total intermediates, as a share of gross output

            imp_share = (1-a0).^(varrhoQ.*epsQ).*(pp.*z).^(epsQ-1).*pm.^(1-epsQ); % imp_share (for loop) is the intermediate share 
            b1 = data_shares.*(pp.*z).^(1-epsQ).*pm.^(epsQ-1);
            a1=1-b1;
                       
            % code for model implied share, use initial value omega 0
            imp_shares= ( pp*ones(1,N)).^(1-epsQ).*((pm*ones(1,N))').^(epsQ-1).*(omega0.^(varrhoM_it.*epsQ) );

            % code for calibarted omega1
            omega1 = (omega_data.^(1./(varrhoM_it.*epsQ))).*((pp*ones(1,N)).^((epsQ-1)./(varrhoM_it.*epsQ))).*(((pm*ones(1,N))').^((1-epsQ)./(varrhoM_it.*epsQ)));
       
             %Reset
            
             imp_share0=imp_share;
             imp_shares_0=imp_shares;
             pp0=pp;

          
        else
            disp('Not solution found =(')
            pp = ones(N,1)*0.001;   % new guess
            pm = ( (omega0.^(varrhoM_it.*epsM))'* pp.^(1-epsM) ).^(1./(1-epsM));
            pm_ss(:,i) = pm;
            
            %Model implied vector of total intermediates, as a share of gross output

            imp_share = (1-a0).^(varrhoQ.*epsQ).*(pp.*z).^(epsQ-1).*pm.^(1-epsQ); 
            b1 = data_shares.*(pp.*z).^(1-epsQ).*pm.^(epsQ-1);
            a1=1-b1;
                       
            % code for model implied share,use initial value omega 0
            imp_shares= ( pp*ones(1,N)).^(1-epsQ).*((pm*ones(1,N))').^(epsQ-1).*(omega0.^(varrhoM_it.*epsQ) );

            % code for calibarted omega1
            omega1 = (omega_data.^(1./(varrhoM_it.*epsQ))).*((pp*ones(1,N)).^((epsQ-1)./(varrhoM_it.*epsQ))).*(((pm*ones(1,N))').^((1-epsQ)./(varrhoM_it.*epsQ)));

            pp0=pp;
            imp_share0=imp_share;
            imp_shares_0=imp_shares;
%         end
        end
    end

    pp_eq(:,i)=pp0;
    a_calib(:,i)=a0;
    omega_calib(:,:,i)=omega0;
    imp_share_ss(:,i)=imp_share0;
    
    ssh(:,i)= inv(eye(N)- pp0.^(1-epsQ).*((z.*pp0).^(epsQ-1)*ones(1,N))'.*...
        ((1-a0)*ones(1,N))'.^(varrhoQ.*epsQ).*omega0.^(varrhoM_it.*epsQ))*betta;

  logGDP0_0(i,1) = Beta(:,i)'*log(Beta(:,i)./pp_eq(:,i));

    end

pp_eq = zeros(N,M);
logGDPsim=zeros(M,T);
density=zeros(M,1);
forward=zeros(M,1);

th1=0.0005;

pp_eq_0=pp_eq; 

%Simulations

% Productivity process
sd_z=[0.21 0.21]'; %Australia 0.15, Indonesia-Thailand 0.4, mexico 0.18, Denmark 0.21
Z_z=zeros(N,T,M);

for i=1:M
    Z_z(:,:,i)= sd_z(i)*randn(N,T); 
end

Z_z=exp(Z_z);
z=Z_z;


for k=1:M
    for j=1:T


 lnpp0 = 1./(1-epsQ).*(log(inv(eye(N)-(z(:,j,k)*ones(1,N)).^(epsQ-1)...
           .*((((1-a_calib(:,k)).^(varrhoQ*epsQ))*ones(1,N)).*(omega_calib(:,:,k)').^(varrhoM_it*epsQ)))...
           *(z(:,j,k).^(epsQ-1).*a_calib(:,k).^(varrhoQ*epsQ))));
         pp0 = exp(lnpp0);
 
              options = optimoptions('fsolve', 'MaxFunEvals',100000, 'MaxIter', 100000,...
             'OptimalityTolerance', 1.0000e-7);
         x0=pp0;
         [x_sol,fvalue, exitflag] = fsolve(@(x) prices_RR(x,z(:,j,k),omega_calib(:,:,k),epsQ,epsM,...
             varrhoQ,varrhoM_it,a_calib(:,k)),x0,options);
             
         if exitflag > 0
             disp('Wujuu! Solution found')
             pp_eq(:,k) = x_sol;
         
             % Log GDP
             logGDPsim(k,j) = Beta(:,k)'*log(Beta(:,k)./pp_eq(:,k));
         else
             disp('Not solution found =(')
             pp_eq(:,k) = zeros(N,1);
              logGDPsim(k,j) = 0;
         end
        
    end
end


logGDP1=mean(logGDPsim')';
logGDP1_median=median(logGDPsim')';

    % OLS coefficients
    Y = logGDP1(logGDP1 ~= 0);
    X = [ones(length(Y),1) dens_data(logGDP1 ~= 0)];
    beta_ols = inv(X'*X)*(X'*Y);
    resid = (Y - X*beta_ols);
    s2 = resid'*resid/(M-length(beta_ols));
    se_ols = sqrt(diag(s2*inv(X'*X)));
    ttest = beta_ols./se_ols;
    %display("Beta_model")
    %display(beta_ols(2))
    %scatter(dens_data(logGDP1 ~= 0), logGDP1(logGDP1 ~= 0),'filled')

display("Density: country 1; country 2")
display([dens_data' (log(dens_data(2))-log(dens_data(1)))])
display("GDP: Country 1 Country 2")
display([logGDP1' (logGDP1(2)-logGDP1(1))])

