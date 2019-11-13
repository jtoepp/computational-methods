%clear workspaces
clear
clc

%%Problem 1
    %a)
    load ('p1.dat') %loading the pressure data
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
    
    load ('t1.dat') %loading the temperature data
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
    sp1 = size (p1); %checks the size of the p1 matrix: 
                    %96 rows x 144 columns
    
    % create nlat/nlon for proper grid spacing
    [nlat,nlon] = size(p1);
    
    % create the degrees for lat and lon
    dlat = 180/nlat;
    dlon = 360/nlon;
    
    % create the lon and lat variables
    lat = [-90:dlat:90-dlat];
    lon = [-180:dlon:180-dlon];
    
    size_lon=size(lon); % check to see if it matches the columns of p1
    size_lat=size(lat); % check to see if it matches the rows of p1
    
    %c)
    ocean_lat=find(lat==-30) %find the cell that equals -30
    ocean_lon=find(lon==-150) %find the cell that equals -150
    
    amazon_lat=find(lat==-13.125) %find the cell that equals -13.125
    amazon_lon=find(lon==-70.0) %find the cell that equals -70.0
    
    everest_lat=find(lat==28.125) %find the cell that equals 28.125
    everest_lon=find(lon==87.5) %find the cell that equals 87.5
    
    australia_lat=find(lat==-26.25) %find the cell that equals -26.25
    australia_lon=find(lon==130) %find the cell that equals 130
    
    antarctica_lat=find(lat==-78.75) %find the cell that equals -78.75
    antarctica_lon=find(lon==107.5) %find the cell that equals 107.5
    
    
    %d-e)
    %concatenate temperature and pressure into a 3d matrix, both are 96x144x10
    T3D=cat(3,temp_1km,temp_2km,temp_3km,temp_4km,temp_8km,temp_11km,temp_14km,temp_15km,temp_16km,temp_17km);
    P3D=cat(3,press_1km,press_2km,press_3km,press_4km,press_8km,press_11km,press_14km,press_15km,press_16km,press_17km);
    
    
    %f)
    [T_i,T_j,T_k] = size(T3D); %size produces 96x144x10
    [P_i,P_j,P_k] = size(P3D); %size produces 96x144x10
    
    %extract the temperature vectors for each location
    T_ocean=T3D(33,13,:);
    T_amazon=T3D(42,45,:);
    T_everest=T3D(64,108,:);%%Error when 108,64
    T_australia=T3D(35,125,:);
    T_antarctica=T3D(7,116,:);
    
    %extract the pressure vectors for each location
    P_ocean=P3D(33,13,:);
    P_amazon=P3D(42,45,:);
    P_everest=P3D(64,108,:);
    P_australia=P3D(35,125,:);
    P_antarctica=P3D(7,116,:);

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
    
    
    %g)
    load ('table_half_km.dat') %loading the geopotential height data
    
    
    %h)
    H=table_half_km(:,1); %extract the geopotential height
    
    
    %i)
    STemp_C=table_half_km(:,2); %extract the geopotential temperature
    
    
    %j)
    [H_STemp_C,L_STemp_C]=size(STemp_C); %find the size of STemp_C
    STemp_K=zeros(H_STemp_C,1); %prepare an empty matrix
    
    for k=1:H_STemp_C; %step through from 1 to 103 (height of STemp_C)
            STemp_K(k)=273.15+STemp_C(k); %convert from C to K
    end %end the for loop
    
    
    %k)
    [H_H,L_H]=size(H); %find the size of H, 103x1
    P_S=zeros(H_H,1); %prepare an empty matrix
    
    for k=1:H_H; %step through from 1 to 103
        if H(k)<11 %set conditions based on Equation Set 1
            P_S(k)=101.325*((288.15/STemp_K(k))^-5.255877); %assign the cell values
        elseif (11<=H(k)) && (H(k)<=20) %add conditions when previous aren't met
            P_S(k)=22.632*exp(-0.1577*(H(k)-11)); %assign the cell values
        elseif (20<=H(k)) && (H(k)<=32) %add conditions when previous aren't met
            P_S(k)=5.4749*((216.65/STemp_K(k))^34.16319); %assign the cell values
        elseif (32<=H(k)) && (H(k)<=47) %add conditions when previous aren't met
            P_S(k)=0.868*((228.65/STemp_K(k))^12.2011); %assign the cell values
        elseif (47<=H(k)) && (H(k)<=51) %add conditions when previous aren't met
            P_S(k)=0.1109*exp(-0.1262*(H(k)-47)); %assign the cell values
        end %end the if statement
    end %end the for loop
    
    for k=1:H_H; %step through from 1 to 103 (height of STemp_C)
        P_S(k)=10*P_S(k); %convert from kPa to hPa
    end %end the for loop
    
    
    %l)
    figure(1) %change the figure number so that it won't overwrite the previously graphed figure
        plot(STemp_K,P_S,'yo-','markerfacecolor','y'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(T2_ocean,P2_ocean,'mo-','markerfacecolor','m'); % plot it
        plot(T2_amazon,P2_amazon,'co-','markerfacecolor','c'); % plot it
        plot(T2_everest,P2_everest,'ro-','markerfacecolor','r'); % plot it
        plot(T2_australia,P2_australia,'go-','markerfacecolor','g'); % plot it
        plot(T2_antarctica,P2_antarctica,'bo-','markerfacecolor','b'); % plot it

%alternative solution:
    %plot(STemp_K,P_S,'-yo',T2_ocean,P2_ocean,'-mo',T2_amazon,P2_amazon,'-co',T2_everest,P2_everest,'-ro',T2_australia,P2_australia,'-go',T2_antarctica,P2_antarctica,'-bo')
            xlabel('Temperature (K)') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            title('Standard Atmopshere vs. Observed Soundings') % label the title
            set(gca,'Ydir','reverse')
            legend('Standard Atmosphere','Ocean','Amazon','Everest','Australia','Antarctica')
        shg % display the graph
    
    
%%Problem 2
    %a)
    %define a new vector of the rows of P_S that are the closest values to the P2 listed  
    K_ocean=dsearchn(P_S,P2_ocean); 
    K_amazon=dsearchn(P_S,P2_amazon);
    K_everest=dsearchn(P_S,P2_everest);
    K_australia=dsearchn(P_S,P2_australia);
    K_antarctica=dsearchn(P_S,P2_antarctica);

    %check to make sure that the values are close(ish) to each other
    display (P_S(K_ocean)-P2_ocean);
    display (P_S(K_amazon)-P2_amazon);
    display (P_S(K_everest)-P2_everest);
    display (P_S(K_australia)-P2_australia);
    display (P_S(K_antarctica)-P2_antarctica);
    
    
    %b)
    %prepare empty matrices for K_site
    STemp_K_ocean=zeros(10,1);
    STemp_K_amazon=zeros(10,1);
    STemp_K_everest=zeros(10,1);
    STemp_K_australia=zeros(10,1);
    STemp_K_antarctica=zeros(10,1);
    
    %using the new K_site variables, extract new vetors from STemp_K
    for k=1:10; %step through from 1 to 10
        z=K_ocean(k); %pull from K_site to set the cell that needs to be pulled from STemp_K
            STemp_K_ocean(k)=STemp_K(z); %set the new cell value based on the STemp_K cell that matches K_site
    end %end the for loop
    
    for k=1:10; %step through from 1 to 10
        z=K_amazon(k); %pull from K_site to set the cell that needs to be pulled from STemp_K
            STemp_K_amazon(k)=STemp_K(z); %set the new cell value based on the STemp_K cell that matches K_site
    end %end the for loop
    
    for k=1:10; %step through from 1 to 10
        z=K_everest(k); %pull from K_site to set the cell that needs to be pulled from STemp_K
            STemp_K_everest(k)=STemp_K(z); %set the new cell value based on the STemp_K cell that matches K_site
    end %end the for loop
    
    for k=1:10; %step through from 1 to 10
        z=K_australia(k); %pull from K_site to set the cell that needs to be pulled from STemp_K
            STemp_K_australia(k)=STemp_K(z); %set the new cell value based on the STemp_K cell that matches K_site
    end %end the for loop
    
    for k=1:10; %step through from 1 to 10
        z=K_antarctica(k); %pull from K_site to set the cell that needs to be pulled from STemp_K
            STemp_K_antarctica(k)=STemp_K(z); %set the new cell value based on the STemp_K cell that matches K_site
    end %end the for loop
    
    
    %c)
    %find the difference between STemp_K_site and T2_site
    D_STemp_K_ocean=(STemp_K_ocean-T2_ocean);
    D_STemp_K_amazon=(STemp_K_amazon-T2_amazon);
    D_STemp_K_everest=(STemp_K_everest-T2_everest);
    D_STemp_K_australia=(STemp_K_australia-T2_australia);
    D_STemp_K_antarctica=(STemp_K_antarctica-T2_antarctica);
    
    
    %d)
    figure(2) %change the figure number so that it won't overwrite the previously graphed figure
        plot(D_STemp_K_ocean,P2_ocean,'mo-','markerfacecolor','m'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(D_STemp_K_amazon,P2_amazon,'co-','markerfacecolor','c'); % plot it
        plot(D_STemp_K_everest,P2_everest,'ro-','markerfacecolor','r'); % plot it
        plot(D_STemp_K_australia,P2_australia,'go-','markerfacecolor','g'); % plot it
        plot(D_STemp_K_antarctica,P2_antarctica,'bo-','markerfacecolor','b'); % plot it
            xlabel('Deviance from Standard Atmospheric Temperature (K)') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            title('Difference Between Standard Atmosphere and Observed Soundings') % label the title
            set(gca,'Ydir','reverse')
            legend('Ocean','Amazon','Everest','Australia','Antarctica')
        shg % display the graph
    
    
%Problem 3
    %a)
    load ('h2o_press_surface.dat') %load in the data set
    e=h2o_press_surface; %set it to a variable
    
    
    %b)
    %convert to Pa, just like in 1f from hw 3
    for i=1:nlon
        for j=1:nlat
           p1_pa(j,i) = p1(j,i) * 100;
        end
    end
    
    
    %calculating the q matrix based on both e, a constant, and p1_pa
    q=zeros(nlat,nlon); %prepare an empty matrix
    for i=1:nlon %set the dimensions to step through
        for j=1:nlat
           q(j,i) = (.622*e(j,i))/p1_pa(j,i); %using the formula 
        end
    end    
    
    
    %c)
    q_array=(0.622.*e)./p1_pa; %the same as the for loop in 3b, just using array multiplication/division instead 
    
    
    %d)
    q_diff=q_array-q; %seeing if there is a difference between the two
    tf=isequal(q,q_array); %returns true
    
    
    %e)
    %find the min and max, and assign them to a variable
    qmin=min(q(:));
    qmax=max(q(:));
    
    figure(3) %change the figure number so that it won't overwrite the previously graphed figure
        variable=q; %variable to plot
        units='g_v/g_d'; %units of specific humudity
        figure_number=3; %assign a figure number (integer)
        x_axis=lon; %lon vector
        y_axis=lat; %lat vector
        qmin=qmin; %minimum value of q
        qmax=qmax; %maximum value of q

        %plot the variables
        plot_2d(figure_number,x_axis,y_axis,variable,qmin,qmax,units);
    
  
%Problem 4
    %a)
    arkansas_lat=find(lat==35.625) %find the cell that equals 35.625 (j=68)
    arkansas_lon=find(lon==-92.5) %find the cell that equals -92.5 (i=36)
    
    den1=zeros(nlat,nlon); %nlat and nlon is the size of the two dimensions of the p1 array: 96 and 144
    R_s=287;
    
    for i=1:nlon
        for j=1:nlat
           den1(j,i) = (p1_pa(j,i))/(R_s*(t1(j,i)));
        end
    end
    
    
    %b)
    %extract the lon data for each new vector
    p1_arkansas=p1(68,:);
    t1_arkansas=t1(68,:);
    d1_arkansas=den1(68,:);
    q1_arkansas=q(68,:);

    
    %c)
    figure(4) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lon,p1_arkansas,'bo-','markerfacecolor','b'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            set(gca,'Ydir','reverse')
            title('Pressure at Longitude 35.625') % label the title
        shg % display the graph
        
    figure(5) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lon,t1_arkansas,'ro-','markerfacecolor','r'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Temmperature (K)') % label the y axis
            title('Temperature at Longitude 35.625') % label the title
        shg % display the graph
        
    figure(6) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lon,d1_arkansas,'mo-','markerfacecolor','m'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Density (kg/m^3)') % label the y axis
            title('Density at Longitude 35.625') % label the title
        shg % display the graph
        
    figure(7) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lon,q1_arkansas,'go-','markerfacecolor','g'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Specific Humidity (g_v/g_d)') % label the y axis
            title('Specific Humidity at Longitude 35.625') % label the title
        shg % display the graph
    

    %d)
    %extract the lat data for each new vector
    p2_arkansas=p1(:,36); 
    t2_arkansas=t1(:,36);
    d2_arkansas=den1(:,36);
    q2_arkansas=q(:,36);
    
    
    %e)
    figure(8) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lat,p2_arkansas,'bo-','markerfacecolor','b'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            set(gca,'Ydir','reverse')
            title('Pressure at Latitude -92.5') % label the title
        shg % display the graph
         
    figure(9) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lat,t2_arkansas,'ro-','markerfacecolor','r'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Temmperature (K)') % label the y axis
            title('Temperature at Latitude -92.5') % label the title
        shg % display the graph
         
    figure(10) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lat,d2_arkansas,'mo-','markerfacecolor','m'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Density (kg/m^3)') % label the y axis
            title('Density at Latitude -92.5') % label the title
        shg % display the graph
        
    figure(11) %change the figure number so that it won't overwrite the previously graphed figure
        plot(lat,q2_arkansas,'go-','markerfacecolor','g'); hold on; % plot it, and keep the plot so that all can be graphed on it
            xlabel('Longitude') % label the x axis
            ylabel('Specific Humidity (g_v/g_d)') % label the y axis
            title('Specific Humidity at Latitude -92.5') % label the title
        shg % display the graph