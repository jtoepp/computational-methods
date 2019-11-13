%clear workspaces
clear
clc

%%Problem 1
%%Part I
    %a)
    %loading the pressure data
    load ('p_surf.dat')
    load ('press_1km.dat')
    load ('press_2km.dat')
    load ('press_3km.dat')
    load ('press_4km.dat')
    load ('press_8km.dat')
    load ('press_11km.dat')
    load ('press_14km.dat')
    load ('press_15km.dat')
    load ('press_16km.dat')
    load ('press_17km.dat')
    
    %loading the temperature data
    load ('t_surf.dat')
    load ('temp_1km.dat')
    load ('temp_2km.dat')
    load ('temp_3km.dat')
    load ('temp_4km.dat')
    load ('temp_8km.dat')
    load ('temp_11km.dat')
    load ('temp_14km.dat')
    load ('temp_15km.dat')
    load ('temp_16km.dat')
    load ('temp_17km.dat')
    
    
    %b)
    size_psfc=size(p_surf); %creating a 1x2 matrix of the size of sfc pressure
    size_tsfc=size(t_surf); %creating a 1x2 matrix of the size of sfc temp

    % create nlat/nlon for proper grid spacing
    [nlat,nlon] = size(p_surf);
    
    % create the degrees for lat and lon
    dlat = 180/nlat;
    dlon = 360/nlon;
    
    % create the lon and lat variables
    lat = [-90:dlat:90-dlat];
    lon = [-180:dlon:180-dlon];
    
    size_lon=size(lon); % check to see if it matches the columns of p1
    size_lat=size(lat); % check to see if it matches the rows of p1
    
    ocean_lat=find(lat==-30); %find the cell that equals -30
    ocean_lon=find(lon==-150); %find the cell that equals -150
    
    amazon_lat=find(lat==-13.125); %find the cell that equals -13.125
    amazon_lon=find(lon==-70.0); %find the cell that equals -70.0
    
    everest_lat=find(lat==28.125); %find the cell that equals 28.125
    everest_lon=find(lon==87.5); %find the cell that equals 87.5
    
    australia_lat=find(lat==-26.25); %find the cell that equals -26.25
    australia_lon=find(lon==130); %find the cell that equals 130
    
    antarctica_lat=find(lat==-78.75); %find the cell that equals -78.75
    antarctica_lon=find(lon==107.5); %find the cell that equals 107.5
    
    
    %c)
    %concatenate temperature and pressure into a 3d matrix, both are 96x144x10
    P3D=cat(3,press_1km,press_2km,press_3km,press_4km,press_8km,press_11km,press_14km,press_15km,press_16km,press_17km);
    T3D=cat(3,temp_1km,temp_2km,temp_3km,temp_4km,temp_8km,temp_11km,temp_14km,temp_15km,temp_16km,temp_17km);
    
    
    %d)
    %extract the pressure vectors for each location
    P_ocean=P3D(33,13,:);
    P_amazon=P3D(42,45,:);
    P_everest=P3D(64,108,:);
    P_australia=P3D(35,125,:);
    P_antarctica=P3D(7,116,:);
    
    %extract the temperature vectors for each location
    T_ocean=T3D(33,13,:);
    T_amazon=T3D(42,45,:);
    T_everest=T3D(64,108,:);
    T_australia=T3D(35,125,:);
    T_antarctica=T3D(7,116,:);
    
    %convert from 3d array to 2d, column vector
    T2_ocean=reshape(T_ocean,10,1);
    T2_amazon=reshape(T_amazon,10,1);
    T2_everest=reshape(T_everest,10,1);
    T2_australia=reshape(T_australia,10,1);
    T2_antarctica=reshape(T_antarctica,10,1);
    
    P2_ocean=reshape(P_ocean,10,1);
    P2_amazon=reshape(P_amazon,10,1);
    P2_everest=reshape(P_everest,10,1);
    P2_australia=reshape(P_australia,10,1);
    P2_antarctica=reshape(P_antarctica,10,1);
    
    %find the sfc pressure for each location
    p_0=101.325; %standard surface pressure
    psurf_ocean=p_surf(33,13); %1000.8
    psurf_amazon=p_surf(42,45); %860.7872
    psurf_everest=p_surf(64,108); %580.7378
    psurf_australia=p_surf(35,125); %935.9680
    psurf_antarctica=p_surf(7,116); %617.0573
    
    %e)
    %load standard pressure and height
    load ('P_S.txt')
    load ('z_s.txt')
    
    %f)
    %load the height vectors for each location
    load ('z_ocean.txt')
    load ('z_amazon.txt')
    load ('z_everest.txt')
    load ('z_australia.txt')
    load ('z_antarctica.txt')
    
    
    %g)
    figure(1)
        plot(z_s,P_S,'-yo',z_ocean,P2_ocean,'-mo',z_amazon,P2_amazon,'-co',z_everest,P2_everest,'-ro',z_australia,P2_australia,'-go',z_antarctica,P2_antarctica,'-bo')
            xlabel('Height (km)') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            title('Pressure as a Function of Height') % label the title
            set(gca,'Ydir','reverse')
            legend('Standard Atmosphere','Ocean','Amazon','Everest','Australia','Antarctica')
        shg % display the graph
        
    
    %h)
    logP_standard=log(P_S/101.325);
    logP_ocean=log(P2_ocean/101.325);
    logP_amazon=log(P2_amazon/101.325);
    logP_everest=log(P2_everest/101.325);
    logP_australia=log(P2_australia/101.325);
    logP_antarctica=log(P2_antarctica/101.325);
    
    %i)
    %perform linear regression to find the slope and y-intercept with the
    %polyfit command
    linreg_standard=polyfit(z_s,logP_standard,1);
    linreg_ocean=polyfit(z_ocean,logP_ocean,1);
    linreg_amazon=polyfit(z_amazon,logP_amazon,1);
    linreg_everest=polyfit(z_everest,logP_everest,1);
    linreg_australia=polyfit(z_australia,logP_australia,1);
    linreg_antarctica=polyfit(z_antarctica,logP_antarctica,1);
    
    
    %)j
    %calculate the coefficient of determination for the polyfit line for
    %each site
    
    yfit=polyval(linreg_standard,z_s);
    yresid=logP_standard-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_standard)-1)*var(logP_standard);
    r2standard=1-SSresid/SStotal; %99.83%
    
    yfit=polyval(linreg_ocean,z_ocean);
    yresid=logP_ocean-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_ocean)-1)*var(logP_ocean);
    r2ocean=1-SSresid/SStotal; %99.85%
    
    yfit=polyval(linreg_amazon,z_amazon);
    yresid=logP_amazon-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_amazon)-1)*var(logP_amazon);
    r2amazon=1-SSresid/SStotal; %99.93%
    
    yfit=polyval(linreg_everest,z_everest);
    yresid=logP_everest-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_everest)-1)*var(logP_everest);
    r2everest=1-SSresid/SStotal; %99.91%
    
    yfit=polyval(linreg_australia,z_australia);
    yresid=logP_australia-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_australia)-1)*var(logP_australia);
    r2australia=1-SSresid/SStotal; %99.73
    
    yfit=polyval(linreg_antarctica,z_antarctica);
    yresid=logP_antarctica-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(logP_antarctica)-1)*var(logP_antarctica);
    r2antarctica=1-SSresid/SStotal; %99.86
    
    
    %l)
    %define the y=mx+b equations for each variable, based on the line
    %of best fit of pressure as a function of height for standard and
    %each of the 5 locations
    eq_standard=(linreg_standard(1,1))*z_s+(linreg_standard(1,2));
    eq_ocean=(linreg_ocean(1,1))*z_s+(linreg_ocean(1,2));
    eq_amazon=(linreg_amazon(1,1))*z_s+(linreg_amazon(1,2));
    eq_everest=(linreg_everest(1,1))*z_s+(linreg_everest(1,2));
    eq_australia=(linreg_australia(1,1))*z_s+(linreg_australia(1,2));
    eq_antarctica=(linreg_antarctica(1,1))*z_s+(linreg_antarctica(1,2));
    
    
    m_str = num2str(linreg_standard(1,1)); % make your value of m a number string
    b_str = num2str(linreg_standard(1,2)); % make your value of b a number string
    eqnstr = ['Standard = (',m_str,')*x + (',b_str,')']; % make your equation a number string
    r2str = ['Coefficient of Determination = (',num2str(r2standard),')']; % make your r^2 a number string
     
    m_str2 = num2str(linreg_ocean(1,1)); % make your value of m a number string
    b_str2 = num2str(linreg_ocean(1,2)); % make your value of b a number string
    eqnstr2 = ['Ocean = (',m_str2,')*x + (',b_str2,')']; % make your equation a number string
    r2str2 = ['Coefficient of Determination = (',num2str(r2ocean),')']; % make your r^2 a number string
    
    m_str3 = num2str(linreg_amazon(1,1)); % make your value of m a number string
    b_str3 = num2str(linreg_amazon(1,2)); % make your value of b a number string
    eqnstr3 = ['Amazon = (',m_str2,')*x + (',b_str3,')']; % make your equation a number string
    r2str3 = ['Coefficient of Determination = (',num2str(r2amazon),')']; % make your r^2 a number string
    
    m_str4 = num2str(linreg_everest(1,1)); % make your value of m a number string
    b_str4 = num2str(linreg_everest(1,2)); % make your value of b a number string
    eqnstr4 = ['Everest = (',m_str2,')*x + (',b_str4,')']; % make your equation a number string
    r2str4 = ['Coefficient of Determination = (',num2str(r2everest),')']; % make your r^2 a number string
    
    m_str5 = num2str(linreg_australia(1,1)); % make your value of m a number string
    b_str5 = num2str(linreg_australia(1,2)); % make your value of b a number string
    eqnstr5 = ['Australia = (',m_str2,')*x + (',b_str5,')']; % make your equation a number string
    r2str5 = ['Coefficient of Determination = (',num2str(r2australia),')']; % make your r^2 a number string
    
    m_str6 = num2str(linreg_antarctica(1,1)); % make your value of m a number string
    b_str6 = num2str(linreg_antarctica(1,2)); % make your value of b a number string
    eqnstr6 = ['Antarctica = (',m_str2,')*x + (',b_str6,')']; % make your equation a number string
    r2str6 = ['Coefficient of Determination = (',num2str(r2antarctica),')']; % make your r^2 a number string

    figure(2)
        plot(z_s,eq_standard,'rx-','markerfacecolor','r'); hold on;
        plot(z_s,logP_standard,'bo-','markerfacecolor','b');
            xlabel('Height (km)') % label the x axis
            ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Standard Atmospheric Pressure with Height') % label the y axis
            title('LinReg LogP vs. True LogP of Standard Compared to Standard')
        gtext({eqnstr,r2str}) %This last command will give you a crosshair on your figure
    legend('LinReg Standard LogP','Standard Atmosphere LogP')
        
    figure(3)
        plot(z_ocean,eq_ocean,'rx-','markerfacecolor','r'); hold on;
        plot(z_ocean,logP_ocean,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Pressure with Height over Ocean') % label the y axis
        title('LinReg LogP vs. True LogP of Ocean Compared to Standard')
        gtext({eqnstr2,r2str2})
    legend('LinReg Ocean LogP','Ocean LogP')
        
    figure(4)
        plot(z_amazon,eq_amazon,'rx-','markerfacecolor','r'); hold on;
        plot(z_amazon,logP_amazon,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Pressure with Height over Amazon') % label the y axis
        title('LinReg LogP vs. True LogP of Amazon Compared to Standard')
        gtext({eqnstr3,r2str3})
    legend('LinReg Amazon LogP','Amazon LogP')
        
    figure(5)
        plot(z_everest,eq_everest,'rx-','markerfacecolor','r'); hold on;
        plot(z_everest,logP_everest,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Pressure with Height over Everest') % label the y axis
        title('LinReg LogP vs. True LogP of Everest Compared to Standard')
        gtext({eqnstr4,r2str4})
    legend('LinReg Everest LogP','Everest LogP')
        
    figure(6)
        plot(z_australia,eq_australia,'rx-','markerfacecolor','r'); hold on;
        plot(z_australia,logP_australia,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Pressure with Height over Australia') % label the y axis
        title('LinReg LogP vs. True LogP of Australia Compared to Standard')
        gtext({eqnstr5,r2str5})
    legend('LinReg Australia LogP','Australia LogP')
        
    figure(7)
        plot(z_antarctica,eq_antarctica,'rx-','markerfacecolor','r'); hold on;
        plot(z_antarctica,logP_antarctica,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Pressure vs. Pressure over Antarctica') % label the y axis
        title('LinReg LogP vs. True LogP of Antarctica Compared to Standard')
        gtext({eqnstr6,r2str6})
    legend('LinReg Antarctica LogP','Antarctica LogP')

        
%%Problem 1
%%Part II
    %n)
    load ('T_S.txt')
    
    %o)
    figure(8)
        plot(z_s,T_S,'-yo',z_ocean,T2_ocean,'-mo',z_amazon,T2_amazon,'-co',z_everest,T2_everest,'-ro',z_australia,T2_australia,'-go',z_antarctica,T2_antarctica,'-bo')
            xlabel('Height (km)') % label the x axis
            ylabel('Temperature (K)') % label the y axis
            title('Temperature as a Function of Height') % label the title
            set(gca,'Ydir','reverse')
            legend('Standard Atmosphere','Ocean','Amazon','Everest','Australia','Antarctica')
        shg % display the graph
    
    %p)
    %perform linear regression to find the slope and y-intercept with the
    %polyfit command
    lapse_linreg_standard=polyfit(z_s,T_S,1);
    lapse_linreg_ocean=polyfit(z_ocean,T2_ocean,1);
    lapse_linreg_amazon=polyfit(z_amazon,T2_amazon,1);
    lapse_linreg_everest=polyfit(z_everest,T2_everest,1);
    lapse_linreg_australia=polyfit(z_australia,T2_australia,1);
    lapse_linreg_antarctica=polyfit(z_antarctica,T2_antarctica,1);
    
    %q)
    %calculate the coefficient of determination for the polyfit line for
    %each site
    
    yfit=polyval(lapse_linreg_standard,z_s);
    yresid=T_S-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T_S)-1)*var(T_S);
    lapse_r2standard=1-SSresid/SStotal; % 88.31%
    
    yfit=polyval(lapse_linreg_ocean,z_ocean);
    yresid=T2_ocean-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T2_ocean)-1)*var(T2_ocean);
    lapse_r2ocean=1-SSresid/SStotal; % 98.79%
    
    yfit=polyval(lapse_linreg_amazon,z_amazon);
    yresid=T2_amazon-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T2_amazon)-1)*var(T2_amazon);
    lapse_r2amazon=1-SSresid/SStotal; % 98.88%
    
    yfit=polyval(lapse_linreg_everest,z_everest);
    yresid=T2_everest-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T2_everest)-1)*var(T2_everest);
    lapse_r2everest=1-SSresid/SStotal; % 98.47%
    
    yfit=polyval(lapse_linreg_australia,z_australia);
    yresid=T2_australia-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T2_australia)-1)*var(T2_australia);
    lapse_r2australia=1-SSresid/SStotal; % 98.87%
    
    yfit=polyval(lapse_linreg_antarctica,z_antarctica);
    yresid=T2_antarctica-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(T2_antarctica)-1)*var(T2_antarctica);
    lapse_r2antarctica=1-SSresid/SStotal; % 94.98%
    
    %s)
    %define the y=mx+b equations for each variable, based on the line
    %of best fit of pressure as a function of height for standard and
    %each of the 5 locations
    lapse_eq_standard=(lapse_linreg_standard(1,1))*z_s+(lapse_linreg_standard(1,2));
    lapse_eq_ocean=(lapse_linreg_ocean(1,1))*z_s+(lapse_linreg_ocean(1,2));
    lapse_eq_amazon=(lapse_linreg_amazon(1,1))*z_s+(lapse_linreg_amazon(1,2));
    lapse_eq_everest=(lapse_linreg_everest(1,1))*z_s+(lapse_linreg_everest(1,2));
    lapse_eq_australia=(lapse_linreg_australia(1,1))*z_s+(lapse_linreg_australia(1,2));
    lapse_eq_antarctica=(lapse_linreg_antarctica(1,1))*z_s+(lapse_linreg_antarctica(1,2));
    
    
    m_str = num2str(lapse_linreg_standard(1,1)); % make your value of m a number string
    b_str = num2str(lapse_linreg_standard(1,2)); % make your value of b a number string
    eqnstr = ['Standard = (',m_str,')*x + (',b_str,')']; % make your equation a number string
    r2str = ['Coefficient of Determination = (',num2str(lapse_r2standard),')']; % make your r^2 a number string
     
    m_str2 = num2str(lapse_linreg_ocean(1,1)); % make your value of m a number string
    b_str2 = num2str(lapse_linreg_ocean(1,2)); % make your value of b a number string
    eqnstr2 = ['Ocean = (',m_str2,')*x + (',b_str2,')']; % make your equation a number string
    r2str2 = ['Coefficient of Determination = (',num2str(lapse_r2ocean),')']; % make your r^2 a number string
    
    m_str3 = num2str(lapse_linreg_amazon(1,1)); % make your value of m a number string
    b_str3 = num2str(lapse_linreg_amazon(1,2)); % make your value of b a number string
    eqnstr3 = ['Amazon = (',m_str3,')*x + (',b_str3,')']; % make your equation a number string
    r2str3 = ['Coefficient of Determination = (',num2str(lapse_r2amazon),')']; % make your r^2 a number string
    
    m_str4 = num2str(lapse_linreg_everest(1,1)); % make your value of m a number string
    b_str4 = num2str(lapse_linreg_everest(1,2)); % make your value of b a number string
    eqnstr4 = ['Everest = (',m_str4,')*x + (',b_str4,')']; % make your equation a number string
    r2str4 = ['Coefficient of Determination = (',num2str(lapse_r2everest),')']; % make your r^2 a number string
    
    m_str5 = num2str(lapse_linreg_australia(1,1)); % make your value of m a number string
    b_str5 = num2str(lapse_linreg_australia(1,2)); % make your value of b a number string
    eqnstr5 = ['Australia = (',m_str5,')*x + (',b_str5,')']; % make your equation a number string
    r2str5 = ['Coefficient of Determination = (',num2str(lapse_r2australia),')']; % make your r^2 a number string
    
    m_str6 = num2str(lapse_linreg_antarctica(1,1)); % make your value of m a number string
    b_str6 = num2str(lapse_linreg_antarctica(1,2)); % make your value of b a number string
    eqnstr6 = ['Antarctica = (',m_str6,')*x + (',b_str6,')']; % make your equation a number string
    r2str6 = ['Coefficient of Determination = (',num2str(lapse_r2antarctica),')']; % make your r^2 a number string

    figure(9)
        plot(z_s,lapse_eq_standard,'rx-','markerfacecolor','r'); hold on;
        plot(z_s,T_S,'bo-','markerfacecolor','b');
            xlabel('Height (km)') % label the x axis
            ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Standard Atmospheric Lapse Rate with Height') % label the y axis
            title('LinReg Lapse vs. True Lapse of Standard Compared to Standard')
        gtext({eqnstr,r2str}) %This last command will give you a crosshair on your figure
    legend('LinReg Standard Lapse','Standard Atmosphere Lapse')
        
    figure(10)
        plot(z_ocean,lapse_eq_ocean,'rx-','markerfacecolor','r'); hold on;
        plot(z_ocean,T2_ocean,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Lapse Rate over Ocean') % label the y axis
        title('LinReg Lapse vs. True Lapse of Ocean Compared to Standard')
        gtext({eqnstr2,r2str2})
    legend('LinReg Ocean Lapse','Ocean Lapse')
        
    figure(11)
        plot(z_amazon,lapse_eq_amazon,'rx-','markerfacecolor','r'); hold on;
        plot(z_amazon,T2_amazon,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Lapse Rate over Amazon') % label the y axis
        title('LinReg Lapse vs. True Lapse of Amazon Compared to Standard')
        gtext({eqnstr3,r2str3})
    legend('LinReg Amazon Lapse','Amazon Lapse')
        
    figure(12)
        plot(z_everest,lapse_eq_everest,'rx-','markerfacecolor','r'); hold on;
        plot(z_everest,T2_everest,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Lapse Rate over Everest') % label the y axis
        title('LinReg Lapse vs. True Lapse of Everest Compared to Standard')
        gtext({eqnstr4,r2str4})
    legend('LinReg Everest Lapse','Everest Lapse')
        
    figure(13)
        plot(z_australia,lapse_eq_australia,'rx-','markerfacecolor','r'); hold on;
        plot(z_australia,T2_australia,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('Log of the Ratio of Standard Atmospheric SFC Pressure vs. Lapse Rate over Australia') % label the y axis
        title('LinReg Lapse vs. True Lapse of Australia Compared to Standard')
        gtext({eqnstr5,r2str5})
    legend('LinReg Australia Lapse','Australia Lapse')
        
    figure(14)
        plot(z_antarctica,lapse_eq_antarctica,'rx-','markerfacecolor','r'); hold on;
        plot(z_antarctica,T2_antarctica,'bo-','markerfacecolor','b');
        xlabel('Height (km)') % label the x axis
        ylabel('LinReg Lapse Rate vs. Lapse Rate over Antarctica') % label the y axis
        title('LinReg Lapse vs. True Lapse of Antarctica Compared to Standard')
        gtext({eqnstr6,r2str6})
    legend('LinReg Antarctica Lapse','Antarctica Lapse')
    

%%Problem 2
    %a)
    %load in the horizontal wind speed in the x direction
    uwind_s=load ('uwind_surface.dat');
    uwind_4=load ('uwind_4km.dat');
    
    %b)
    %load in the horizontal wind speed in the y direction
    vwind_s=load ('vwind_surface.dat');
    vwind_4=load ('vwind_4km.dat');
    
    %c)
    %load in the lat and lon wind vectors and rename them
    w_lat=load ('wind_lat.txt');
    w_lon=load ('wind_lon.txt');
    
    %d)
    %solve Equation 2 for wind speed at the surface and 500MB (4km)
    Ws_Sqrt_Surf=sqrt(uwind_s.^2+vwind_s.^2);
    Ws_Sqrt_4km=sqrt(uwind_4.^2+vwind_4.^2);
    
    %e)
    %define two variables as the size of the columns of lat and lon
    size_lat=size(w_lat,1);
    size_lon=size(w_lon,1);
    
    %define the upper and lower limits, in addition to the tolerance
    %level. Winds will most likely be less than 100 and more than 0, 
    %so it made sense to set them to that.
    a=0;
    b=100;
    tol=0.00000000001;
    
    %calculate our wind "map" based on the bisection method to solve
    %equation 2
    syms ws
    
    %create a matrix of zeros for values to be added to
    xm=zeros(size_lat,size_lon);
    
    %create a nested for loop in a for loop to calculate each value
    %in 'xm' with the Bisection Method, based on Equation 2 for the 
    %SFC
    for i=1:size_lat;
        for j=1:size_lon;
            u=uwind_s(i,j);
            v=vwind_s(i,j);
            f=@(ws)ws^2-u^2-v^2;
            [xm(i,j),count(i,j)]=bisection(f,a,b,tol);
        end
    end
    
    %set the values into their own array
    Ws_Bi_Surf=xm;
    
    %now the same, but for 500MB (4km)
    for i=1:size_lat;
        for j=1:size_lon;
            u=uwind_4(i,j);
            v=vwind_4(i,j);
            f=@(ws)ws^2-u^2-v^2;
            [xm(i,j),count(i,j)]=bisection(f,a,b,tol);
        end
    end
    
    %set the values into their own array
    Ws_Bi_4km=xm;
    
    %g)
    %compute the difference between the Sqrt and Bisection methods
    Ws_diff_Surf=(Ws_Sqrt_Surf-Ws_Bi_Surf);
    Ws_diff_4km=(Ws_Sqrt_4km-Ws_Bi_4km);
    
    %h)
    %find the min and max of the difference so that it can be plotted
    cmin = min(Ws_diff_Surf(:));
    cmax = max(Ws_diff_Surf(:));
    
    % prepare your arguments for the function
            figure(15)
            variable=Ws_diff_Surf; % variable you want to plot
            units='m/s'; % units of your variable
            figure_number=15; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);
    
    %the same is below, just for 4km
    %find the min and max of the difference so that it can be plotted
    cmin = min(Ws_diff_4km(:));
    cmax = max(Ws_diff_4km(:));
    
    % prepare your arguments for the function
            figure(16)
            variable=Ws_diff_4km; % variable you want to plot
            units='m/s'; % units of your variable
            figure_number=16; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);
    
    %j)
    %find the min and max of the SFC winds so that they can be plotted
    cmin = min(Ws_Bi_Surf(:));
    cmax = max(Ws_Bi_Surf(:));
    
    % prepare your arguments for the function
            figure(17)
            variable=Ws_Bi_Surf; % variable you want to plot
            units='m/s'; % units of your variable
            figure_number=17; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);
    
    %k)
    %find the min and max of the 4km winds so that they can be plotted
    cmin = min(Ws_Bi_4km(:));
    cmax = max(Ws_Bi_4km(:));
    
    % prepare your arguments for the function
            figure(18)
            variable=Ws_Bi_4km; % variable you want to plot
            units='m/s'; % units of your variable
            figure_number=18; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);

    
%%Problem 3
%%Part I
    %a)
    %load p_surf and t_surf
    load ('p_surf.dat')
    load ('t_surf.dat')
    
    %b)
    %convert hPa to Pa
    p_surf=p_surf*100;
    
    %c)
    %Calculate SFC density based on Equation 3: Density=Pressure/(R_s*Temperature)
    den_surf=p_surf./(287*t_surf);
    
    %d)
    %find the corners of each rectangle and extract the data (similar
    %to in hw7 Problem 1c)
    %South America
    SAN=find(lat==11.25); %55
    SAS=find(lat==-60); %17
    SAW=find(lon==-90); %37
    SAE=find(lon==-30); %61

    %North America
    NAN=find(lat==71.25); %87
    NAS=find(lat==20.625); %60
    NAW=find(lon==-157.5); %10
    NAE=find(lon==-22.5); %64
    
    %Asia
    AN=find(lat==80.625); %92
    AS=find(lat==9.375); %54
    AW=find(lon==50); %93
    AE=find(lon==140); %129
    
    %Pacific
    PN=find(lat==76.8750); %90
    PS=find(lat==-60); %17
    PW=find(lon==140); %129
    PE=find(lon==-120); %25
    
    %extract the pressure field based on the four corners defined 
    %above for each of the fields
    SAp_surf=p_surf(SAS:SAN,SAW:SAE);
    NAp_surf=p_surf(NAS:NAN,NAW:NAE);
    Ap_surf=p_surf(AS:AN,AW:AE);
    Pp_surf=p_surf(PS:PN,PE:PW);
    
    %extract the density field based on the four corners defined 
    %above for each of the fields
    SAt_surf=t_surf(SAS:SAN,SAW:SAE);
    NAt_surf=t_surf(NAS:NAN,NAW:NAE);
    At_surf=t_surf(AS:AN,AW:AE);
    Pt_surf=t_surf(PS:PN,PE:PW);
    
    %extract the temperature field based on the four corners defined 
    %above for each of the fields
    SAden_surf=den_surf(SAS:SAN,SAW:SAE);
    NAden_surf=den_surf(NAS:NAN,NAW:NAE);
    Aden_surf=den_surf(AS:AN,AW:AE);
    Pden_surf=den_surf(PS:PN,PE:PW);
    
    %e)
    %correlate pressure and temperature for the four locations
    corr_PT_SA = corrcoef(SAp_surf,SAt_surf);
    corr_PT_NA = corrcoef(NAp_surf,NAt_surf);
    corr_PT_A = corrcoef(Ap_surf,At_surf);
    corr_PT_P = corrcoef(Pp_surf,Pt_surf);
    
    %f)
    %correlate pressure and temperature for the four locations
    corr_PDEN_SA = corrcoef(SAp_surf,SAden_surf);
    corr_PDEN_NA = corrcoef(NAp_surf,NAden_surf);
    corr_PDEN_A = corrcoef(Ap_surf,Aden_surf);
    corr_PDEN_P = corrcoef(Pp_surf,Pden_surf);
    
    %g)
    %calculate the standard deviation for pressure for each location
    SA_stdP = std(SAp_surf(:));
    NA_stdP = std(NAp_surf(:));
    A_stdP = std(Ap_surf(:));
    P_stdP = std(Pp_surf(:));
    
    %calculate the standard deviation for temperature for each location
    SA_stdT = std(SAt_surf(:));
    NA_stdT = std(NAt_surf(:));
    A_stdT = std(At_surf(:));
    P_stdT = std(Pt_surf(:));
    
    %calculate the standard deviation for density for each location
    SA_stdDEN = std(SAden_surf(:));
    NA_stdDEN = std(NAden_surf(:));
    A_stdDEN = std(Aden_surf(:));
    P_stdDEN = std(Pden_surf(:));
    
   
%%Problem 3
%%Part II
    %j)
    %will do!!
    
    %k)
    %multiply density and temperature together for NA
    NAden_T=(NAden_surf.*NAt_surf);
    
    %l)
    %convert NA pressure and density to vectors
    v_NAp_surf=NAp_surf(:);
    v_NAden_T=NAden_T(:);
    
    %m)
    %plot NA pressure and density
    %to be continued in %p)
    figure(19)
        plot(v_NAden_T,v_NAp_surf,'bo-','markerfacecolor','b'); hold on;
        
    %n)
    %perform linear regression on the vectors NAden_T and NAp_surf
    linreg_NA=polyfit(v_NAden_T,v_NAp_surf,1);
    
    %o)
    %calculate the coefficient of determination for the linear regression
    %equation calculated above
    yfit=polyval(linreg_NA,v_NAden_T);
    yresid=v_NAp_surf-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(v_NAp_surf)-1)*var(v_NAp_surf);
    r2_NA=1-SSresid/SStotal; %100
    
    %p)
    m_str7 = num2str(linreg_NA(1,1)); % make your value of m a number string
    b_str7 = num2str(linreg_NA(1,2)); % make your value of b a number string
    eqnstr7 = ['North America = (',m_str7,')*x + (',b_str7,')']; % make your equation a number string
    r2str7 = ['Coefficient of Determination = (',num2str(r2_NA),')']; % make your r^2 a number string
    
    
    %define the y=mx+b equation for the linear regression equation
    eq_NA=(linreg_NA(1,1))*v_NAden_T+(linreg_NA(1,2));
    
    %finish the plot!!
        plot(v_NAden_T,v_NAp_surf,'rx-','markerfacecolor','r');
        xlabel('NA Density (kg/m^3)') % label the x axis
        ylabel('NA Pressure (Pa)') % label the y axis
        title('North America Density vs. Pressure')
        gtext({eqnstr7,r2str7})
    legend('North America', 'LinReg North America')
    
    
    %q)
    %k2)
    %multiply density and temperature together for AA
    SAden_T=(SAden_surf.*SAt_surf);
    
    %l2)
    %convert SA pressure and density to vectors
    v_SAp_surf=SAp_surf(:);
    v_SAden_T=SAden_T(:);
    
    %m2)
    %plot SA pressure and density
    %to be continued in %p2)
    figure(20)
        plot(v_SAden_T,v_SAp_surf,'bo-','markerfacecolor','b'); hold on;
        
    %n2)
    %perform linear regression on the vectors SAden_T and SAp_surf
    linreg_SA=polyfit(v_SAden_T,v_SAp_surf,1);
    
    %o2)
    %calculate the coefficient of determination for the linear regression
    %equation calculated above
    yfit=polyval(linreg_SA,v_SAden_T);
    yresid=v_SAp_surf-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(v_SAp_surf)-1)*var(v_SAp_surf);
    r2_SA=1-SSresid/SStotal; %100
    
    %p2)
    m_str8 = num2str(linreg_SA(1,1)); % make your value of m a number string
    b_str8 = num2str(linreg_SA(1,2)); % make your value of b a number string
    eqnstr8 = ['South America = (',m_str8,')*x + (',b_str8,')']; % make your equation a number string
    r2str8 = ['Coefficient of Determination = (',num2str(r2_NA),')']; % make your r^2 a number string
    
    
    %define the y=mx+b equation for the linear regression equation
    eq_SA=(linreg_SA(1,1))*v_SAden_T+(linreg_SA(1,2));
    
    %finish the plot!!
        plot(v_SAden_T,v_SAp_surf,'rx-','markerfacecolor','r');
        xlabel('SA Density (kg/m^3)') % label the x axis
        ylabel('SA Pressure (Pa)') % label the y axis
        title('South America Density vs. Pressure')
        gtext({eqnstr8,r2str8})
    legend('South America', 'LinReg South America')
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    