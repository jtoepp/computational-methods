%clear workspaces
clear
clc

%%Problem 1
    %a)
    %load in Irradiance
    load ('Irradiance.txt')

    %b)
    %define all of the values
    E_sun=Irradiance(1,1);
    E_mercury=Irradiance(2,1);
    E_venus=Irradiance(3,1);
    E_earth=Irradiance(4,1);
    E_mars=Irradiance(5,1);
    E_jupiter=Irradiance(6,1);
    E_saturn=Irradiance(7,1);
    E_uranus=Irradiance(8,1);
    E_neptune=Irradiance(9,1);
    E_pluto=Irradiance(10,1);

    %c)
    %define sigma
    sigma=0.0000000567;

    %d)
    %make it so T can be used in a function in the operator
    syms T
    
    %e)
    %define lower and upper limits, as well as the tolerance
    a=0;
    b=6000;
    tol=0.00001
    %define f, then calculate the new bisection as the definition of f changes
    f = @(T) sigma*T^4-E_sun;
    disp('Sun bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_mercury;
    disp('Mercury bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_venus;
    disp('Venus bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_earth;
    disp('Earth bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_mars;
    disp('Mars bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_jupiter;
    disp('Jupiter bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_saturn;
    disp('Saturn bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_uranus;
    disp('Uranus bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_neptune;
    disp('Neptune bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    f = @(T) sigma*T^4-E_pluto;
    disp('Pluto bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    %g)
    no_constant=0.0000000567*T^4; %constants become 0 during differentiation, so just doing this early
    df=diff(no_constant); %returns the equivalent to 2.268e-7, which is 0.0000000567*4
    
    %h)
    %define the initial guess, the tolerance, and the initial count
    x0=100;
    tol=0.00000001;
    count=0;
    
    %redefine df for the instance to be used in the function
    df=@(T)0.0000000567*4*T^3
    
    
    %computing the Newton method, then list the count. All meet the
    %bisection, but the count is always zero... why??
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_mercury;
    disp('Mercury Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_venus;
    disp('Venus Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_earth;
    disp('Earth Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_mars;
    disp('Mars Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_jupiter;
    disp('Jupiter Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_saturn;
    disp('Saturn Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_uranus;
    disp('Uranus Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_neptune;
    disp('Neptune Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    f = @(T) sigma*T^4-E_pluto;
    disp('Pluto Newton')
    [R] = newton(f,df,x0,tol,count)
    count
    
    
    %i)
    %prepare each new vector for each planet for the roots() function
    sun=[sigma 0 0 0 -E_sun];   
    mercury=[sigma 0 0 0 -E_mercury]; 
    venus=[sigma 0 0 0 -E_venus]; 
    earth=[sigma 0 0 0 -E_earth]; 
    mars=[sigma 0 0 0 -E_mars]; 
    jupiter=[sigma 0 0 0 -E_jupiter]; 
    saturn=[sigma 0 0 0 -E_saturn]; 
    uranus=[sigma 0 0 0 -E_uranus]; 
    neptune=[sigma 0 0 0 -E_neptune]; 
    pluto=[sigma 0 0 0 -E_pluto]; 
    
    %calculate the roots of each planet, and assign them to a vector
    s1=roots(sun)
    m1=roots(mercury)
    v=roots(venus)
    e=roots(earth)
    m2=roots(mars)
    j=roots(jupiter)
    s2=roots(saturn)
    u=roots(uranus)
    n=roots(neptune)
    p=roots(pluto)
    
    
    %l)
    %prepare variables for each solution. the only ones that are different
    %than each other is the uranus, neptune, and pluto bisections
    sun_bisection=5700;
    mercury_bisection=439;
    venus_bisection=225;
    earth_bisection=255;
    mars_bisection=216;
    jupiter_bisection=105;
    saturn_bisection=81;
    uranus_bisection=58.0001;
    neptune_bisection=47.0002;
    pluto_bisection=38.0001;
    
    sun_newton=5700;
    mercury_newton=439;
    venus_newton=225;
    earth_newton=255;
    mars_newton=216;
    jupiter_newton=105;
    saturn_newton=81;
    uranus_newton=58;
    neptune_newton=47;
    pluto_newton=38;
    
    sun_roots=5700;
    mercury_roots=439;
    venus_roots=225;
    earth_roots=255;
    mars_roots=216;
    jupiter_roots=105;
    saturn_roots=81;
    uranus_roots=58;
    neptune_roots=47;
    pluto_roots=38;
    
    
    figure(1) %change the figure number so that it won't overwrite the previously graphed figure
        %plot bisection
        plot(sun_bisection,E_sun,'bo-','markerfacecolor','b'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(mercury_bisection,E_mercury,'bo-','markerfacecolor','b'); % plot it
        plot(venus_bisection,E_venus,'bo-','markerfacecolor','b');
        plot(earth_bisection,E_earth,'bo-','markerfacecolor','b');
        plot(mars_bisection,E_mars,'bo-','markerfacecolor','b');
        plot(jupiter_bisection,E_jupiter,'bo-','markerfacecolor','b');
        plot(saturn_bisection,E_saturn,'bo-','markerfacecolor','b');
        plot(uranus_bisection,E_uranus,'bo-','markerfacecolor','b');
        plot(neptune_bisection,E_neptune,'bo-','markerfacecolor','b');
        plot(pluto_bisection,E_pluto,'bo-','markerfacecolor','b');
        
        %change to plotting newton method
        plot(sun_newton,E_sun,'ro-','markerfacecolor','r');
        plot(mercury_newton,E_mercury,'ro-','markerfacecolor','r');
        plot(venus_newton,E_venus,'ro-','markerfacecolor','r');
        plot(earth_newton,E_earth,'ro-','markerfacecolor','r');
        plot(mars_newton,E_mars,'ro-','markerfacecolor','r');
        plot(jupiter_newton,E_jupiter,'ro-','markerfacecolor','r');
        plot(saturn_newton,E_saturn,'ro-','markerfacecolor','r');
        plot(uranus_newton,E_uranus,'ro-','markerfacecolor','r');
        plot(neptune_newton,E_neptune,'ro-','markerfacecolor','r');
        plot(pluto_newton,E_pluto,'ro-','markerfacecolor','r');
        
        %change to plotting roots() method
        plot(sun_roots,E_sun,'yo-','markerfacecolor','y');
        plot(mercury_roots,E_mercury,'yo-','markerfacecolor','y');
        plot(venus_roots,E_venus,'yo-','markerfacecolor','y');
        plot(earth_roots,E_earth,'yo-','markerfacecolor','y');
        plot(mars_roots,E_mars,'yo-','markerfacecolor','y');
        plot(jupiter_roots,E_jupiter,'yo-','markerfacecolor','y');
        plot(saturn_roots,E_saturn,'yo-','markerfacecolor','y');
        plot(uranus_roots,E_uranus,'yo-','markerfacecolor','y');
        plot(neptune_roots,E_neptune,'yo-','markerfacecolor','y');
        plot(pluto_roots,E_pluto,'yo-','markerfacecolor','y');
        
        %change the labels and legend of the graph, as well at the location
        %of the legend
            xlabel('Equivalent Blackbody Temperature (T)') % label the x axis
            ylabel('Flux Density (E*)') % label the y axis
            title('Roots of the Stefan-Boltzman Law') % label the title
            legend('Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto','Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto','Sun','Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune','Pluto','Location','northwest')
    

%%Problem 1
    %a)
    %define lower and upper limits, as well as the tolerance
    a=0;
    b=1000000;
    tol=0.00001
    %define f, then calculate the new bisection as the definition of f changes
    f = @(T) sigma*T^4-E_sun;
    disp('Sun bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    %define new limits
    a=5765;
    b=5775;
    
    %define f, then calculate the new bisection as the definition of f changes
    f = @(T) sigma*T^4-E_sun;
    disp('Sun bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    
    %c)
    %define lower and upper limits, as well as the tolerance
    a=0;
    b=6000;
    tol=0.00000000000000000001;
    
    %define f, then calculate the new bisection as the definition of f changes
    f = @(T) sigma*T^4-E_earth;
    disp('Earth bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    %define new tolerance
    tol=100;
    
    %define f, then calculate the new bisection as the definition of f changes
    f = @(T) sigma*T^4-E_earth;
    disp('Earth bisection')
    [xm,count]=bisection(f,a,b,tol)
    
    
%%Problem 3
    %a)
    %define the initial guess, the tolerance, and the initial count
    x0=100;
    tol=0.00000001;
    count=0;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count=0;
    
    %redefine the x0
    x0=1000000;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count=0;
    
    %redefine the x0
    x0=1;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count=0;
    
    
    %c)
    %define the initial guess, the tolerance, and the initial count
    x0=100;
    tol=0.00000001;
    count=0;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count=0;
    
    %redefine the x0
    tol=0.00000000000000000001;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)
    count=0;
    
    %redefine the x0
    tol=100;
    
    %computing the Newton method, then list the count
    f = @(T) sigma*T^4-E_sun;
    disp('Sun Newton')
    [R] = newton(f,df,x0,tol,count)

    
    
    
    
    