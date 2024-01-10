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

%Countries in the sample
keep=[1 2 3 4 5 6 7 8 9 10 11 12 13 15 16 17 18 19 20 22 23 24 25 26 27 28 29 30 31 32 ...
    33 34 35 36 37 39 40 41 42 43 44 46 47 48 49 50 52 53 54 55 56 57 59 60 61];

matdom=matdom1995(:,:,keep);
output=output1995(1,:,keep);
consum=cons1995(:,1,keep);
zeros = find(sum(output == 0));
output(:,:, zeros) = [];
matdom(:,:, zeros) = [];
consum(:,:, zeros) = [];

error=1e-7;  
[N,N2,M]=size(matdom);
clear consum1995 cons1995 mat1995 iodom1995 output1995 N2 keep zeros

% -------------------------------------------------------------------------
%                        Set Parameters
% -------------------------------------------------------------------------

% Production function elasticities
epsQ = 1.1;
rhoQ = (epsQ-1)/epsQ;
varrhoQ = 1/epsQ;

epsM =epsQ;
rhoM=(epsM-1)/epsM;

G=50; %grid size VarrhoM
%varrhoM=0.746;
varrhoM= linspace((1/epsQ)*0.8, (1/epsQ)*0.9, G);  % varrhoM grid
LoV=epsQ*varrhoM;

[K,K2]=size(varrhoM');
z=ones(N,1);

% -------------------------------------------------------------------------
% Calibration of IO shares, consumption shares, and distribution parameter
% -------------------------------------------------------------------------
logGDP0_0_=zeros(M,1);
logGDP0_k=zeros(M,K);
b_calib = zeros(N,M);
omega_calib = zeros(N,N,M);
model_share_ss = zeros(N,M);
opt_prices = ones(N, 1, M);
dens_data=zeros(M,1);
betas_ols=zeros(K,1);
ses_ols=zeros(K,1);
ttest_ols=zeros(K,1);
th1=0.0005;

for k=1:K
    
    varrhoM_it=varrhoM(k);

    for i=1:M
    
    % 1. gamma0: purchases from i to j / i's production (buyer relevance)
    
    gamma0 = (matdom(:,:,i)+error)./((output(1,:,i)'+error)*ones(1,N))';
    dens0   = (gamma0>th1);
    dens0   = sum(dens0);
    dens_data(i) = (sum(dens0)-N)/(N*(N-1));


    % 2. omega: purchases from i to j / i's total intermediate purchases
    
    omega_data = (matdom(:,:,i)+error)./(sum(matdom(:,:,i)+error)'*ones(1,N))';
    omega0=omega_data;
    
    % 3. betas
    
    betta= (consum(:,1,i)+error)./sum(consum(:,1,i)+error);
    Beta(:,i) = betta;

    % b0 = total intermediate purchases / production
    
    b0=sum(gamma0)'; %initial guess
    data_shares=b0;
    Data_shares(:,i)=data_shares;
    a0=1-b0;    % labor participation

    %Initial conditions (epsq=epsm case)
    epsq0=epsQ; epsm0=epsq0;
    varrhoq0 = 1./epsq0;
    varrhom0 = varrhoM_it;

    % Formula for P_j when epsQ=epsM
    lnpp0 = 1./(1-epsq0).*(log(inv(eye(N)-(z*ones(1,N)).^(epsq0-1)...
          .*((((1-a0).^(varrhoq0*epsq0))*ones(1,N)).*(omega0').^(varrhom0*epsq0)))...
          *(z.^(epsq0-1).*a0.^(varrhoq0*epsq0))));
    pp0 = exp(lnpp0);

    % global solution for more general cases 
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
    %            Loop to find vector of a and matriz Omega 
    % -----------------------------------------------------------------
    

error=10E-6;
    % distance between data shares and model implicated shares
     while (abs(max(max((imp_shares_0-omega_data)))) > error) || isnan(max(max((imp_shares_0-omega_data)))) || (abs(max((imp_share0-data_shares)))>error) ||  isnan(max((imp_share0-data_shares)))
          a0=a1;
          omega0=omega1;
          
        options = optimoptions('fsolve', 'MaxFunEvals',50000, 'MaxIter', 50000,...
            'OptimalityTolerance', 1.0000e-10);
        
           % Formula for P_j when epsQ=epsM
        lnpp0 = 1./(1-epsQ).*(log(inv(eye(N)-(z*ones(1,N)).^(epsQ-1)...
          .*((((1-a0).^(varrhoQ*epsQ))*ones(1,N)).*(omega0').^(varrhoM_it*epsQ)))...
          *(z.^(epsQ-1).*a0.^(varrhoQ*epsQ))));
        pp0 = exp(lnpp0);


        x0=pp0;
       
        [x_sol,fvalue, exitflag] = fsolve(@(x) prices_RR(x,z,omega0,epsQ,epsM,...
            varrhoQ,varrhoM_it,a0),x0,options);
        if exitflag > 0
            disp('Solution found')
            
            pp = x_sol;
            pm = ( (omega0.^(varrhoM_it.*epsM))'* pp.^(1-epsM) ).^(1./(1-epsM)); 
            pm_ss(:,i) = pm;
        
            %Model implied vector of total intermediates, as a share of gross output

            imp_share = (1-a0).^(varrhoQ.*epsQ).*(pp.*z).^(epsQ-1).*pm.^(1-epsQ); % imp_share (for loop) is the intermediate share 
            b1 = data_shares.*(pp.*z).^(1-epsQ).*pm.^(epsQ-1);
            a1=1-b1;
                       
            % code for model implied shares

            imp_shares= ( pp*ones(1,N)).^(1-epsQ).*((pm*ones(1,N))').^(epsQ-1).*(omega0.^(varrhoM_it.*epsQ) );

            % code for next iteration's Omega1
            
            omega1 = (omega_data.^(1./(varrhoM_it.*epsQ))).*((pp*ones(1,N)).^((epsQ-1)./(varrhoM_it.*epsQ))).*(((pm*ones(1,N))').^((1-epsQ)./(varrhoM_it.*epsQ)));
       
             %Reset
            
             imp_share0=imp_share;
             imp_shares_0=imp_shares;
             pp0=pp;

          
        else
            disp('Not solution found =(')
            disp([i varrhoM_it])

            pp = ones(N,1)*0.001;   % new guess
            pm = ( (omega0.^(varrhoM_it.*epsM))'* pp.^(1-epsM) ).^(1./(1-epsM));
            pm_ss(:,i) = pm;
            
            %Model implied vector of total intermediates, as a share of gross output

            imp_share = (1-a0).^(varrhoQ.*epsQ).*(pp.*z).^(epsQ-1).*pm.^(1-epsQ);
            b1 = data_shares.*(pp.*z).^(1-epsQ).*pm.^(epsQ-1);
            a1=1-b1;
                       
            % code for model implied shares
            imp_shares= ( pp*ones(1,N)).^(1-epsQ).*((pm*ones(1,N))').^(epsQ-1).*(omega0.^(varrhoM_it.*epsQ) );

            % code for re calibrated omega1
            omega1 = (omega_data.^(1./(varrhoM_it.*epsQ))).*((pp*ones(1,N)).^((epsQ-1)./(varrhoM_it.*epsQ))).*(((pm*ones(1,N))').^((1-epsQ)./(varrhoM_it.*epsQ)));

            pp0=pp;
            imp_share0=imp_share;
            imp_shares_0=imp_shares;
        end
    end

    pp_eq(:,i)=pp0;
    b_calib(:,i)=b0;
    omega_calib(:,:,i)=omega0;
    imp_share_ss(:,i)=imp_share0;
    
    ssh(:,i)= inv(eye(N)- pp0.^(1-epsQ).*((z.*pp0).^(epsQ-1)*ones(1,N))'.*...
        ((1-a0)*ones(1,N))'.^(varrhoQ.*epsQ).*omega0.^(varrhoM(end).*epsQ))*betta;

    logGDP0_0(i,1) = Beta(:,i)'*log(Beta(:,i)./pp_eq(:,i));

    end

    logGDP0_k(i,k) = Beta(:,i)'*log(Beta(:,i)./pp_eq(:,i));

    Y = logGDP0_0(logGDP0_0 ~= 0);
    X = [ones(length(Y),1) dens_data(logGDP0_0 ~= 0)];
    beta_ols = inv(X'*X)*(X'*Y);
    resid = (Y - X*beta_ols);
    s2 = resid'*resid/(M-length(beta_ols));
    se_ols = sqrt(diag(s2*inv(X'*X)));
    ttest = beta_ols./se_ols;
    betas_ols(k)=beta_ols(2);
    ttest_ols(k)=ttest(2);
    ses_ols(k)=se_ols(2);



end

beta_data=2.102;
%beta_data=0.37;
difference=abs(betas_ols-beta_data);
min_loc=min(difference);

loc= find(difference==min_loc);
varrhoM_calib=varrhoM(loc);

display("varrhoM  model-implied alpha_1")
display([varrhoM_calib betas_ols(loc)]);


%Figure for calibrated varrhoM

  f = figure('visible', 'on')
  f = scatter(dens_data, logGDP0_0(:,loc),'filled')
  h = lsline
  set(h(1), 'color', 'r')
  set(gcf,'color','w');
  %title('Network density and development' ) 
  %subtitle(strcat('Love of Diversification = ', sprintf('%0.3f',varrhoM_it), '; \epsilon_Q = ', ...
  %sprintf('%0.2f',epsQ(1)), '; \epsilon_M = ', sprintf('%0.2f',epsM(1)) ))
  xlabel('Network Density') 
  ylabel('log GDP')
  legend(strcat('\alpha_1^{model}  =', sprintf('%0.2f',betas_ols(loc)), "(",...
         sprintf('%0.2f',ses_ols(loc)), ")"))
    %saveas(f, strcat('./figures/model_gdp_density_ss', string(find(varrhoM_it == varrhoM)), '.png')) 


