%clear workspaces
clear
clc

%%Problem 1
    %a)
    %create my variables
    c = 3e8; %m/s
    h = 6.63e-34; %m2kg/s
    k = 1.38e-23; %m2kg/s2/k
    sigma = 5.67e-8; %W/m2/K4
    T = 5780; %K
    
    %b)
    %create lambda
    lambda = [0.015:.01:100.005]; %micrometers
    %c)
    %calculate c_1 and c_2
    c1 = 2*h*c^2;
    c2 = h*c/k;
    
    %d)
    mlambda = lambda*1e-6;
    Blambda = (c1*mlambda.^(-5))./(pi.*(exp(c2./(mlambda*T))-1));
    
    %e)
    figure(1)
        plot(mlambda,Blambda,'bo-','markerfacecolor','b')
            xlabel('Wavelength (m)') % label the x axis
            ylabel('Emitted Radiaiton ()') % label the y axis
            title('Emitted Radiation of a Blackbody') % label the title
            set(gca,'XScale','log')
            legend('Emitted Radiation')
        shg % display the graph
    
    %f)
    dBlambda(1,:) = ((-c1*mlambda.^(-6))./((exp((c2/T)./mlambda) -1).^2)).*((5*(exp((c2/T)./mlambda)-1))-(((c2/T)./mlambda).*(exp((c2/T)./mlambda))));
        
    %g)
    ma = max(Blambda); % occurs at 1,50
    max_mlambda = mlambda(1,50); %gives the wavelength at the max emitted energy
    delta_mlambda = mlambda(1,2)-mlambda(1,1);
    
    figure(2)
        plot(dBlambda,'bo-','markerfacecolor','b')
            xlabel('') % label the x axis
            ylabel('Slope') % label the y axis
            title('First Derivative of Plancks Function') % label the title
            set(gca,'XScale','log')
            legend('Slope of Plancks Function')
        shg % display the graph
    
    
%%Problem 2
    %a)
    x_lambda = find(lambda==0.305); %occurs at (1,30)
    CDD_planck = (dBlambda(30)-dBlambda(29))/(delta_mlambda);
    
    %b)
    %arte_CDD = abs((XXX-CDD_planck)/XXX)*100;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    