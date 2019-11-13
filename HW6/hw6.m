%clear workspaces
clear
clc

%%Problem 1
    %a)
    %load data sets as our variabls
    CO2=load ('GlobalCO2.txt');
    GT=load ('AnnualGlobalT_Celsius.txt');
    
    %b)
    %create vectors of CO2 to split the years and the CO2 measurements 
    Years=CO2(:,1);
    CO2=CO2(:,2);
    
    %c)
    %compute the mean
    CO2avg=mean(CO2);
    
    %d)
    %compute the mean
    GTavg=mean(GT);
    
    %e)
    %compute the median
    CO2median=median(CO2);
    
    %f)
    %compute the median
    GTmedian=median(GT);
    
    %h)
    %compute the standard deviation
    CO2std=std(CO2);
    
    %i)
    %compute the standard deviation
    GTstd=std(GT);
    
    %k)
    %compute the variance
    CO2var=var(CO2);
    
    %l)
    %compute the variance
    GTvar=var(GT);
    
    %n)
    %compute the covariance
    CO2cov_years=cov(CO2,Years);
    
    %o)
    %compute the correlation coefficient
    CO2cor_years=corrcoef(CO2,Years);
    
    %q)
    %compute the covariance
    CO2cov_gt=cov(CO2,GT);
    
    %r)
    %compute the correlation coefficient
    CO2cor_gt=corrcoef(CO2,GT);
    
    
%%Problem 2
    %a)
    %take the first 41 years of data only
    CO2_1960_2000=CO2(1:41);
    Year_1960_2000=Years(1:41);
    
    %b)
    %make a scatter plot of the data
    figure(1)
    scatter(Year_1960_2000,CO2_1960_2000)
        xlabel('Years') % label the x axis
        ylabel('CO2') % label the y axis
        title('CO2 Change from 1960 to 2000') % label the title

    %c) 
    %compute the slope line by line
    z=Year_1960_2000-CO2_1960_2000;
    m=Year_1960_2000./z;
    slope=mean(m); %1.2073, fairly close to polyfit
    y=CO2_1960_2000-slope.*Year_1960_2000;
    y_int=mean(y); %-2.0505e+03, also fairly close to polyfit
    
    
    %d)
    %perform linear regression to find the slope and y-intercept with the
    %polyfit command
    RegCO2_1960_2000=polyfit(Year_1960_2000,CO2_1960_2000,1);
    %note: when I did a rough estimate (1960-2000), I used 
    %CO2(41,1)-CO2(1,1)/Year(41,1)-Year(1,1), and got 1.33875 as my slope.
    %This is pretty close to the polyfit 1.3602, so it's in the right area
    
    %f)
    %manually compute the CO2 data using the function
    ManualCO2_1960_2000=m.*Year_1960_2000+y;
    
    %g)
    %compute the coefficient of determination for the manually
    %calculated line: very bad estimate... -63.37%??
    R_reg = 1 - sum((CO2_1960_2000 - ManualCO2_1960_2000).^2)/sum((CO2_1960_2000 - mean(CO2_1960_2000)).^2);
    
    %calculate the coefficient of determination for the polyfit line,
    %utilizing polyval: very good! 99.09%
    yfit=polyval(RegCO2_1960_2000,Year_1960_2000);
    yresid=CO2_1960_2000-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(CO2_1960_2000)-1)*var(CO2_1960_2000);
    R_poly=1-SSresid/SStotal;
    
    %i)
    %y_star is the manual version of yfit
    y_star=RegCO2_1960_2000(1,1)*Year_1960_2000+RegCO2_1960_2000(1,2);

    m_str = num2str(slope); % make your value of m a number string
    b_str = num2str(y_int); % make your value of b a number string
    eqnstr = ['Manual = (',m_str,')*x + (',b_str,')']; % make your equation a number string
    r2str = ['r^2 = (',num2str(R_reg),')']; % make your r^2 a number string
     
    m_str2 = num2str(RegCO2_1960_2000(1,1)); % make your value of m a number string
    b_str2 = num2str(RegCO2_1960_2000(1,2)); % make your value of b a number string
    eqnstr2 = ['LinReg = (',m_str2,')*x + (',b_str2,')']; % make your equation a number string
    r2str2 = ['r^2 = (',num2str(R_poly),')']; % make your r^2 a number string
    
    figure(2)
    scatter(Year_1960_2000,CO2_1960_2000); hold on;
        xlabel('Years') % label the x axis
        ylabel('CO2') % label the y axis
        title('CO2 Change from 1960 to 2000, with Forecasted Change from 2001-2014') % label the title
        
        %%%%%SEE PROBLEM 3 FOR THE PLOTS
    
  
%%Problem 3
    %a)
    %create the second part of the years data
    Year_2001_2014=Years(42:55);
    
    %calculate the forecasted values using our polyfit equation
    FCO2_2001_2014=polyval(RegCO2_1960_2000,Year_2001_2014);

    %b/h) see end of problem
        
    %c) 
    %create the second part of the CO2 data
    CO2_2001_2014=CO2(42:55);
    
    %d)
    RegCO2_2001_2014=polyfit(Year_2001_2014,CO2_2001_2014,1);
    
    %f)
    %calculate the coefficient of determination for the new polyfit line,
    %utilizing polyval: very good! 99.90%
    yfit2=polyval(RegCO2_2001_2014,Year_2001_2014);
    yresid2=CO2_2001_2014-yfit2;
    SSresid2=sum(yresid2.^2);
    SStotal2=(length(CO2_2001_2014)-1)*var(CO2_2001_2014);
    R_poly2=1-SSresid2/SStotal2;
    
    
    %%FINISHED GRAPH FOR PROBLEMS 2-3
    gtext({eqnstr,r2str;eqnstr2,r2str2}) %This last command will give you a crosshair on your figure
        plot(Year_1960_2000,ManualCO2_1960_2000,'rx-','markerfacecolor','r'); 
        plot(Year_1960_2000,yfit,'gx-','markerfacecolor','g'); 
        plot(Year_2001_2014,FCO2_2001_2014,'bx-','markerfacecolor','b');
        plot(Year_2001_2014,yfit2,'mx-','markerfacecolor','m');
    legend('Original Data, 1960-2000','Manual Linear Regression, 1960-2000','Polyfit Linear Regression, 1960-2000','Forecast Data for 2001-2014 Based on Poly1900','Polyfit Linear Regression, 2001-2014')
    
    %i)
    RMSE=sqrt(sum(Year_2001_2014-CO2_2001_2014).^2)./Year_2001_2014;
    RMSE_avg=mean(RMSE);
    bias=mean(sum(CO2_2001_2014)/Year_2001_2014);
    
%%Problem 4
    %a-c)
    %find the departure from average for both data sets
    CO2_anom=CO2-CO2avg;
    GT_anom=GT-GTavg;
    
    %d)
    %finish the graph from previous problems
    figure(3)
    scatter(Years,GT_anom,'ro'); hold on;
    scatter(Years,CO2_anom,'go')
        xlabel('Years') % label the x axis
        ylabel('Anomalies') % label the y axis
        title('Global Temp and CO2 Anomalies from 1960 to 2014') % label the title
    legend('Global Temperature','CO2')
         
   %e)
   %find slope and y-intercept using polyfit
   RegCO2_anom=polyfit(CO2_anom,GT_anom,1);
   
   %f)
   %find the slope using the centering data method
   CDM_GT_anom=(cov(GT_anom,CO2_anom))./var(CO2_anom);
   
   %h)
   %double CO2 to see the change in temperature
   CO2_d2014=2*(CO2(end));
   
   %i)
   %predict the temperature change
   t_inc=CO2_d2014*CDM_GT_anom(1,2);
   
   %j)
   %predict the forecasted temperature with a doubled CO2
   T_future=t_inc+GT(end);

    
    