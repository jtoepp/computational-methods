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
    %concatenate temperature and pressure into a 3d matrix, both are 96x144x10
    P_hpa=cat(3,press_1km,press_2km,press_3km,press_4km,press_8km,press_11km,press_14km,press_15km,press_16km,press_17km);
    T3D=cat(3,temp_1km,temp_2km,temp_3km,temp_4km,temp_8km,temp_11km,temp_14km,temp_15km,temp_16km,temp_17km);
    
    %convert from hPa to Pa
    P3D=P_hpa*100;
    p_surf=p_surf*100;
    
    %c)
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
    
    bangkok_lat=find(lat==13.1250); %find the cell that equals 13.250
    bangkok_lon=find(lon==100.0000); %find the cell that equals 100.0000  

    %extract the pressure vectors for the location
    P_bangkok=P3D(56,113,:);
    
    %extract the temperature vectors for the location
    T_bangkok=T3D(56,113,:);
    
    %convert from 3d array to 2d, column vector
    T2_bangkok=reshape(T_bangkok,10,1);
    P2_bangkok=reshape(P_bangkok,10,1);
    
    %d)
    %manually calculate linear interpolation
    T_manual(1,1)=T2_bangkok(4,1)+(((6-4)*(T2_bangkok(5,1)-T2_bangkok(4,1)))/(8-4));
    T_manual(2,1)=T2_bangkok(5,1)+(((9.5-8)*(T2_bangkok(6,1)-T2_bangkok(5,1)))/(11-8));
    T_manual(3,1)=T2_bangkok(5,1)+(((10-8)*(T2_bangkok(6,1)-T2_bangkok(5,1)))/(11-8));
    T_manual(4,1)=T2_bangkok(6,1)+(((12.5-11)*(T2_bangkok(7,1)-T2_bangkok(6,1)))/(14-11));
    T_manual(5,1)=T2_bangkok(6,1)+(((13-11)*(T2_bangkok(7,1)-T2_bangkok(6,1)))/(14-11));
    
    %e)
    %use the matlab interp() function
    x=[4,8,11,14]';
    y=T2_bangkok(4:7,1);
    x_int=[6,9.5,10,12.5,13]';
    T_interp=interp1(x,y,x_int);
    
    %f)
    figure(1)
        plot(x_int,T_manual,'ro-',x_int,T_interp,'bx-'); hold on;
        %plot(T_interp,'bx-','markerfacecolor','b');
            xlabel('Height (km)') % label the x axis
            ylabel('Temperature (K)') % label the y axis
            title('Manual Linear Interpolation vs. Interp() Function') % label the title
            set(gca,'Ydir','reverse')
            legend('Manual Interpolation','Interp() Function')
        shg % display the graph
    
    
    
%%Problem 2
    %a)
    %find the coordinates for the region around bangkok in the format x,y
    %i really could have had lat 1/2 and lon1/2, but it helped me to "see"
    %the coordinates that i drew out on paper to visualize it
    lat12=find(lat==15.0000); 
    lon12=find(lon==97.500); 
    
    lat22=find(lat==15.0000); 
    lon22=find(lon==102.5000); 
    
    lat21=find(lat==11.2500); 
    lon21=find(lon==102.5000); 
    
    lat11=find(lat==11.2500); 
    lon11=find(lon==97.500); 
    
    %b)
    Test_bangkok=[12,22;11,21]; %hooray! It works
    Pmat_bangkok=[p_surf(lat12,lon12),p_surf(lat22,lon22);p_surf(lat21,lon21),p_surf(lat11,lon11)];
    
    %c)
    %manually calculate the bilinear interpolation for bangkok using the
    %surrounding data
    P2_manual=(1/((lon22-lon11)*(lat22-lat11)))*( (Pmat_bangkok(2,2)*(lon22-bangkok_lon)*(lat22-bangkok_lat)) + (Pmat_bangkok(1,2)*(bangkok_lon-lon11)*(lat22-bangkok_lat)) + (Pmat_bangkok(2,1)*(lon22-bangkok_lon)*(bangkok_lat-lat11)) + (Pmat_bangkok(1,1)*(bangkok_lon-lon11)*(bangkok_lat-lat11)) );
    
    %d)
    %use the interp2 function to calculate the pressure at bangkok using
    %the surrounding data
    x2=[lon11,lon22];
    y2=[lat11,lat22];
    z2=[Pmat_bangkok(1,1),Pmat_bangkok(1,2);Pmat_bangkok(2,1),Pmat_bangkok(2,2)];
    P2_actual=interp2(x2,y2,z2,bangkok_lon,bangkok_lat);
    
    %e)
    %find the actual sfc pressure point
    p_actual=p_surf(56,113);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    