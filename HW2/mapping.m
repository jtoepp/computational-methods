%clear workspaces
clear
clc

%Problem 1
    % a/b)
    load ('p1.dat')       %loads data from pressure field 1
    % c)
    sp1 = size (p1)             %checks the size of the p1 matrix: 
                          %96 rows x 144 columns
    % d)
    % create nlat/nlon for proper grid spacing
    [nlat,nlon] = size(p1)
    
    % create the degrees for lat and lon
    dlat = 180/nlat
    dlon = 360/nlon
    
    % create the lon and lat variables
    lat = [-90:dlat:90-dlat];
    lon = [-180:dlon:180-dlon];
    
    slon = size(lon) % check to see if it matches the columns of p1
    slat = size(lat) % check to see if it matches the rows of p1
                          
    % e) find the min and max, and assign them to a variable
        cmin = min(p1(:))
        cmax = max(p1(:))
        
    % f) plot it all
        % prepare your arguments for the function
            figure(1)
            variable=p1; % variable you want to plot
            units='hPa'; % units of your pressure variable
            figure_number=1; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);


    % g) 
    p1_tucson = p1(66,:); % define the slice of just tucson
    [htucson,ltucson] = size(p1_tucson) % height and length of tucson
    tf = isequal(ltucson,nlon) % checking to see if they match
    lat66 = lat(66) % output gives the lat of tucson: 31.8750
    tp1_tucson = transpose(p1_tucson);
    tlon = transpose(lon);

    
    % h)
        figure(2)
        subplot(1,1,1) %subplot in case of later plots
            plot(tlon,tp1_tucson,'bo-','markerfacecolor','b') % plot it
            xlabel('Longitude') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            title('Pressure at Lat 32N') % label the title
            set(gca,'Ydir','reverse')
        shg % display the graph


%Problem 2
    %a/b)
        load ('t1.dat') %load in the data
        
    %c)
        st1 = size(t1) %check size, 96x144
    %d)
        cmin = min(t1(:))
        cmax = max(t1(:))        
    
    %e) plot it all
        % prepare your arguments for the function
            figure(3)
            variable=t1; % variable you want to plot
            units='K'; % units of your pressure variable
            figure_number=3; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);    

    %f) 
        t1_tucson = t1(:,29); % define the slice of just tucson
        [htucson,ltucson] = size(t1_tucson) % rows and columns of tucson
        tf = isequal(htucson,nlat) % checking to see if they match
        lon29 = lon(29) % output gives the lon of tucson: -110
        tt1_tucson = transpose(t1_tucson);
        tlat = transpose(lat);
    
    %g)
        figure(4)
        subplot(1,1,1) %subplot in case of later plots
            plot(tlat,tt1_tucson,'bo-','markerfacecolor','b') % plot it
            xlabel('Latitude') % label the x axis
            ylabel('Temperature (K)') % label the y axis
            title('Temperature at Lon 110W') % label the title
        shg % display the graph
        
%Problem 3
    %a)
        tarea = t1(66-3:2:66+3,29-2:1:29+2); %define a smaller portion around tucson
        lat2 = [lat66-3:dlat:lat66+3]; %define new lat
        lon2 = [lon29-2:dlon:lon29+2]; %define new lon
        cmin = min(tarea(:)) %find min range
        cmax = max(tarea(:)) %find max range
    %b)
        figure(5)
            variable=tarea; % variable you want to plot
            units='K'; % units of your pressure variable
            figure_number=5; % assign a figure number (integer)
            x_axis=lon2; % this is the lon vector you created
            y_axis=lat2; % this is the lat vector you created
            cmin=cmin; % this is the minimum value you found
            cmax=cmax; % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,cmin,cmax,units);
        
        
%Problem 4
    %a) load data from our remaining fields
        load ('p3.dat')
        load ('p5.dat')
        load ('t3.dat')
        load ('t5.dat')
        
    %b) contatenate temperature
        tlev = cat(3,t1,t3,t5);
        
    %c) contatenate pressure
        plev = cat(3,p1,p3,p5);
        
    %d) find the size of tnlev and pnlev
        stlev = size(tlev) %produces 96x144x3
        splev = size(plev) %produces 96x144x3

%Problem 5
    %a)
        [htlev,ltlev,dtlev] = size(tlev) %still produces 96x144x3
        [hplev,lplev,dplev] = size(tlev) %still produces 96x144x3
        t2_tucson = tlev(29,66,:)
        p2_tucson = plev(29,66,:)
        
        t3_tucson = reshape(t2_tucson,1,3) %convert from 3d array to 2d
        p3_tucson = reshape(p2_tucson,1,3) %convert from 3d array to 2d
        
        st3_tucsan = size(t3_tucson) %outputs 1x3
        sp3_tucsan = size(p3_tucson) %outputs 1x3
        

    %b)
        figure(6)
        subplot(1,1,1) %subplot in case of later plots
            plot(t3_tucson,p3_tucson,'-or','markerfacecolor','b') % plot it
            %plot3??(t3_tucson,p3_tucson,3,'bo-','markerfacecolor','b') % attempt 2
            xlabel('Temperature (K)') % label the x axis
            ylabel('Pressure (hPa)') % label the y axis
            title('Temperature vs. Pressure') % label the title
            legend('Relationship with Height')
            set(gca,'Ydir','reverse')
        shg % display the graph


    
