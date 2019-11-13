%clear workspaces
clear
clc

%%Problem 1
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
    %create the low res height values for later interpolation
    z = [0,1,2,3,4,8,11,14,15,16,17];
    z = z.*1000;
    
    %c)
    %concatenate temperature and pressure into a 3d matrix, both are
    %96x144x11
    p_LowRes=cat(3,p_surf,press_1km,press_2km,press_3km,press_4km,press_8km,press_11km,press_14km,press_15km,press_16km,press_17km);
    T_LowRes=cat(3,t_surf,temp_1km,temp_2km,temp_3km,temp_4km,temp_8km,temp_11km,temp_14km,temp_15km,temp_16km,temp_17km);
    
    %d)
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
    
    bangkok_lat=find(lat==13.1250); %56
    bangkok_lon=find(lon==100.0000); %113
    
    parinacota_lat=find(lat==18.7500); %59
    parinacota_lon=find(lon==-70.0); %45
    
    omsk_lat=find(lat==54.3750); %78
    omsk_lon=find(lon==72.5000); %102
    
    camden_lat=find(lat==33.7500); %67
    camden_lon=find(lon==-80.0000); %41
    
    timbuktu_lat=find(lat==16.8750); %58
    timbuktu_lon=find(lon==-2.5000); %72
    
    %extract the pressure vectors for each location
    P_bangkok=p_LowRes(56,113,:);
    P_parinacota=p_LowRes(59,45,:);
    P_omsk=p_LowRes(78,102,:);
    P_camden=p_LowRes(67,41,:);
    P_timbuktu=p_LowRes(58,72,:);
    
    %extract the temperature vectors for each location
    T_bangkok=T_LowRes(56,113,:);
    T_parinacota=T_LowRes(59,45,:);
    T_omsk=T_LowRes(78,102,:);
    T_camden=T_LowRes(67,41,:);
    T_timbuktu=T_LowRes(58,72,:);
    
    %convert from 3d array to 2d, column vector
    P_bangkok=reshape(P_bangkok,11,1);
    P_parinacota=reshape(P_parinacota,11,1);
    P_omsk=reshape(P_omsk,11,1);
    P_camden=reshape(P_camden,11,1);
    P_timbuktu=reshape(P_timbuktu,11,1);
    
    T_bangkok=reshape(T_bangkok,11,1);
    T_parinacota=reshape(T_parinacota,11,1);
    T_omsk=reshape(T_omsk,11,1);
    T_camden=reshape(T_camden,11,1);
    T_timbuktu=reshape(T_timbuktu,11,1);
    
    %e)
    figure(1)
        plot(T_bangkok,z,'-bo',T_parinacota,z,'-mo',T_omsk,z,'-co',T_camden,z,'-ro',T_timbuktu,z,'-go')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('Temperature as a Function of Height') % label the title
            legend('Bangkok, Thailand','Parinacota, Chile','Omsk, Russia','Camden, SC','Timbuktu, Mali')
        shg % display the graph
     
    %f)
    %create the higher resolution steps in preparation for interpolating
    z_interp = [0:50:17000];
    
    %interpolate in between our temperature data set, every 50 meters
    T_bangkok_interp = interp1(z,T_bangkok,z_interp);
    T_bangkok_interp = T_bangkok_interp.';
    
    T_parinacota_interp = interp1(z,T_parinacota,z_interp);
    T_parinacota_interp = T_parinacota_interp.';
    
    T_omsk_interp = interp1(z,T_omsk,z_interp);
    T_omsk_interp = T_omsk_interp.';
    
    T_camden_interp = interp1(z,T_camden,z_interp);
    T_camden_interp = T_camden_interp.';
    
    T_timbuktu_interp = interp1(z,T_timbuktu,z_interp);
    T_timbuktu_interp = T_timbuktu_interp.';
    
    figure(2)
        plot(T_bangkok_interp,z_interp,'-ro',T_bangkok,z,'-gx')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Temperature as a Function of Height') % label the title
            legend('Interpolated Bangkok','Original Bangkok')
        shg % display the graph
        
    figure(3)
        plot(T_parinacota_interp,z_interp,'-ro',T_parinacota,z,'-gx')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Temperature as a Function of Height') % label the title
            legend('Interpolated Parinacota','Original Parinacota')
        shg % display the graph
        
    figure(4)
        plot(T_omsk_interp,z_interp,'-ro',T_omsk,z,'-gx')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Temperature as a Function of Height') % label the title
            legend('Interpolated Omsk','Original Omsk')
        shg % display the graph
        
    figure(5)
        plot(T_camden_interp,z_interp,'-ro',T_camden,z,'-gx')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Temperature as a Function of Height') % label the title
            legend('Interpolated Camden','Original Camden')
        shg % display the graph
        
    figure(6)
        plot(T_timbuktu_interp,z_interp,'-ro',T_timbuktu,z,'-gx')
            xlabel('Temperature (k)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Temperature as a Function of Height') % label the title
            legend('Interpolated Timbuktu','Original Timbuktu')
        shg % display the graph
    
    %i)
    %interpolate in between our pressure data set, every 50 meters
    P_bangkok_interp = interp1(z,P_bangkok,z_interp);
    P_bangkok_interp = P_bangkok_interp.';
    
    P_parinacota_interp = interp1(z,P_parinacota,z_interp);
    P_parinacota_interp = P_parinacota_interp.';
    
    P_omsk_interp = interp1(z,P_omsk,z_interp);
    P_omsk_interp = P_omsk_interp.';
    
    P_camden_interp = interp1(z,P_camden,z_interp);
    P_camden_interp = P_camden_interp.';
    
    P_timbuktu_interp = interp1(z,P_timbuktu,z_interp);
    P_timbuktu_interp = P_timbuktu_interp.';
    
    %graph all with the overlay of the original values
    figure(7)
        plot(P_bangkok_interp,z_interp,'-ro',P_bangkok,z,'-gx')
            xlabel('Pressure (hPa)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Pressure as a Function of Height') % label the title
            legend('Interpolated Bangkok','Original Bangkok')
        shg % display the graph
    
    figure(8)
        plot(P_parinacota_interp,z_interp,'-ro',P_parinacota,z,'-gx')
            xlabel('Pressure (hPa)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Pressure as a Function of Height') % label the title
            legend('Interpolated Parinacota','Original Parinacota')
        shg % display the graph
        
    figure(9)
        plot(P_omsk_interp,z_interp,'-ro',P_omsk,z,'-gx')
            xlabel('Pressure (hPa)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Pressure as a Function of Height') % label the title
            legend('Interpolated Omsk','Original Omsk')
        shg % display the graph
        
    figure(10)
        plot(P_camden_interp,z_interp,'-ro',P_camden,z,'-gx')
            xlabel('Pressure (hPa)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Pressure as a Function of Height') % label the title
            legend('Interpolated Camden','Original Camden')
        shg % display the graph
        
    figure(11)
        plot(P_timbuktu_interp,z_interp,'-ro',P_timbuktu,z,'-gx')
            xlabel('Pressure (hPa)') % label the x axis
            ylabel('Height (m)') % label the y axis
            title('50m Interpolated Pressure as a Function of Height') % label the title
            legend('Interpolated Timbuktu','Original Timbuktu')
        shg % display the graph
        
        
%%Problem 3
    %a)%loading the density data
    load ('q_surf.dat')
    load ('q_1km.dat')
    load ('q_2km.dat')
    load ('q_3km.dat')
    load ('q_4km.dat')
    load ('q_8km.dat')
    load ('q_11km.dat')
    load ('q_14km.dat')
    load ('q_15km.dat')
    load ('q_16km.dat')
    load ('q_17km.dat')
    
    %b)
    q_LowRes=cat(3,q_surf,q_1km,q_2km,q_3km,q_4km,q_8km,q_11km,q_14km,q_15km,q_16km,q_17km);
    
    %c)
    q_lat1=find(lat==-28.1250); %34
    q_lat2=find(lat==0); %49
    q_lat3=find(lat==45.0000); %73
    
    %find the min and max of the 4km winds so that they can be plotted
    cmin = min(q_LowRes(:));
    cmax = max(q_LowRes(:));
    lon = lon';
    % prepare your arguments for the function
            figure(12)
            var=q_LowRes(34,:,:); % variable you want to plot
            units='g/kg'; % units of your variable
            ifig=12; % assign a figure number (integer)
            x=lon; % this is the lon vector you created
            y=z; % this is the pressure level
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d_vert(ifig,x,y,var,cmin,cmax,units);
            
    %d)
    %create the higher resolution steps in preparation for interpolating
    z_interp2 = [0:50:17000];
    
    %interpolate in between our specific humidity data set, every 100 meters
    q_interp = interp1(z,q_surf,z_interp2);