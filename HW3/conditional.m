%clear workspaces
clear
clc

%%Problem 1
    %a-c)
    load ('p1.dat') %loading the pressure data
    load ('t1.dat') %loading the temperature data
   
    
    %d)
    size_p1=size(p1); %creating a 1x2 matrix of the size of p1
    size_t1=size(t1); %creating a 1x2 matrix of the size of t1
    
    % create lat/lon for proper grid spacing
    [nlat,nlon]=size(p1);
    [tlat,tlon]=size(t1);
    
    tf=isequal(nlat,tlat); %checking to see if they match, true
    tf=isequal(nlon,tlon); %checking to see if they match, true
    
    
    %e)
    %create the degrees for lat and lon
    dlat=180/nlat;
    dlon=360/nlon;
    
    %create the lon and lat variables
    lat=[-90:dlat:90-dlat];
    lon=[-180:dlon:180-dlon];
    
    size_lon=size(lon); % check to see if it matches the columns of p1
    size_lat=size(lat); % check to see if it matches the rows of p1
                          
    %find the min and max, and assign them to a variable
    pmin=min(p1(:));
    pmax=max(p1(:));
    tmin=min(t1(:));
    tmax=max(t1(:));
    
    
    %f)
    p1_pa=zeros(nlat,nlon); %nlat and nlon is the value of the size of the two dimensions of your p1 array: 96 and 144
    size_p1_pa=size(p1_pa); %96x144
    
    for i=1:nlon
        for j=1:nlat
           p1_pa(j,i) = p1(j,i) * 100;
        end
    end
    
            
    %g)
    den1=zeros(nlat,nlon); %nlat and nlon is the value of the size of the two dimensions of your p1 array: 96 and 144
    size_den1=size(den1); %96x144
    R_s=287;
    
    for i=1:nlon
        for j=1:nlat
           den1(j,i) = (p1_pa(j,i))/(R_s*(t1(j,i)));
        end
    end
            
            
    %h)
    % prepare your arguments for the function
            figure(1)
            variable=den1; % variable you want to plot
            units='kg/m3'; % units of your pressure variable
            figure_number=1; % assign a figure number (integer)
            x_axis=lon; % this is the lon vector you created
            y_axis=lat; % this is the lat vector you created
            den1_min=min(den1(:)); % this is the minimum value you found
            den1_max=max(den1(:)); % this is the maximum value you found

        % you are ready to plot. use the syntax below to plot
            plot_2d(figure_number,x_axis,y_axis,variable,den1_min,den1_max,units);
                title('Pressure') %title the graph
            
            
%%Problem 2
    %a)
    x=find(lon==-110) %find the cell that equals -110
    y=find(lat==31.8750) %find the cell that equals 31.8750
    
    %b/c)
    for i=1:nlon %loop from 1 to the the variable nlon
        if lon(i)==-110 %return the value if it equals this
            disp(i) %display the current step if the statement is true
        end %end the if statement
    end %end the for statement
    
    for j=1:nlat %loop from 1 to the the variable nlat
        if lat(j)==31.8750 %return the value if it equals this
            disp(j) %display the current step if the statement is true
        end %end the if statement
    end %end the for statement
    
          
%%Problem 3 
    %a)
    load ('table1.txt') %load table1 into the program
    index_table1=[1:26]; %index until h=51
    Lev_H=26; %set the end of the loops
    H=table1(index_table1,1); %set height for the length defined
    T=table1(index_table1,2); %set temp for the length defined
    Tn=zeros(Lev_H,1); %prepare empty matrix
    
    for k=1:Lev_H; %step through from 1 to 26
        if H(k)<11 %set conditions
            Tn(k)=288.15-6.5*H(k); %assign the cell values
        elseif (11<=H(k)) && (H(k)<=20) %add conditions when previous aren't met
            Tn(k)=216.65; %assign the cell values
        elseif (20<=H(k)) && (H(k)<=32) %add conditions when previous aren't met
            Tn(k)=216.65+H(k)-20; %assign the cell values
        elseif (32<=H(k)) && (H(k)<=47) %add conditions when previous aren't met
            Tn(k)=228.65+2.8*(H(k)-32); %assign the cell values
        elseif (47<=H(k)) && (H(k)<=51) %add conditions when previous aren't met
            Tn(k)=270.65; %assign the cell values
        end %end the if statement
    end %end the for loop
            
    
    %b)
    hold on %keep graphs on screen
    figure(2) %change the figure number so that it won't overwrite the previously graphed figure
        %subplot(1,1,1) %subplot in case of later plots
            plot(Tn,H,'bo-','markerfacecolor','b') % plot it
            xlabel('Temperature (K vs C)') % label the x axis
            ylabel('Height (km)') % label the y axis
            title('Temperature vs. Height') % label the title
        hold %holds current graph on screen so the second can be plotted over it
            plot(T,H,'bo-','markerfacecolor','r') % plot it
        shg % display the graph
    hold off %release the hold
    
    
        
        
        
        