%clear workspaces
clear
clc

%%Problem 2
    %a)
    %loading the part 1 data
    load ('w1_t2rad.dat')
    load ('w2_t2rad.dat')
    load ('w3_t2rad.dat')
    load ('w4_t2rad.dat')
    load ('w5_t2rad.dat')
    load ('w6_t2rad.dat')
    load ('w7_t2rad.dat')
    load ('w8_t2rad.dat')
    load ('w9_t2rad.dat')
    load ('w10_t2rad.dat')
    load ('rad.dat')
    load ('z.dat')
    load ('true_t.dat')
    
    %b)
    %loading the part 2 data
    load ('full_w1_t2rad.dat')
    load ('full_w2_t2rad.dat')
    load ('full_w3_t2rad.dat')
    load ('full_w4_t2rad.dat')
    load ('full_w5_t2rad.dat')
    load ('full_w6_t2rad.dat')
    load ('full_w7_t2rad.dat')
    load ('full_w8_t2rad.dat')
    load ('full_w9_t2rad.dat')
    load ('full_w10_t2rad.dat')
    load ('full_rad.dat')
    load ('full_z.dat')
    load ('full_true_t.dat')
    
    %c) 
    %contatenate the weighting files 
    cat_a=cat(1,w1_t2rad,w2_t2rad,w3_t2rad,w4_t2rad,w5_t2rad,w6_t2rad,w7_t2rad,w8_t2rad,w9_t2rad,w10_t2rad);
    cat_full_a=cat(1,full_w1_t2rad,full_w2_t2rad,full_w3_t2rad,full_w4_t2rad,full_w5_t2rad,full_w6_t2rad,full_w7_t2rad,full_w8_t2rad,full_w9_t2rad,full_w10_t2rad);
    
    %reshape the column vectors to row vectors
    b=z';
    full_b=full_z';
    a=cat_a';
    full_a=cat_full_a';    
    
    %Hx = y
    %[weighting function] [temp profile] = [height]
    %need to solve for x...
    %this means that it is now in vector-matrix form to be able to solve
    %for x
    
    
%%Problem 3
    %a)
    det(a) %VERY close to zero... 1.3834e-19
    a_inv=inv(a); %a is not singular
    cond_a=cond(a) %extremely high... 3.2843e+05
    
    rank(a) %10
    rank([a,b]) %10, they match!!
    
    %c)
    %taking the matrix inverse method
    x3_mat=inv(a)*b;
    
    %d)
    x3_left=a\b; %solution with the left division method
    ans=a*x3_left; %proof that x is the solution to each equation, ans=z
    
    %h)
    figure(1) %change the figure number so that it won't overwrite the previously graphed figure
        plot(x3_mat,b,'yo-','markerfacecolor','y'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(x3_left,b,'mo-','markerfacecolor','m'); % plot it
        plot(true_t,b,'co-','markerfacecolor','c'); % plot it
    
            xlabel('Weighting Function') % label the x axis
            ylabel('Height (km)') % label the y axis
            title('Calculated Weighting Function with Height') % label the title
            legend('Matrix Inverse Method','Left Division Method','True Temperature')
        shg % display the graph
    
    %i)
    e_mat=x3_mat-true_t;
    e_left=x3_left-true_t;
    
    %j)
    figure(2) %change the figure number so that it won't overwrite the previously graphed figure
        plot(e_mat,'yo-','markerfacecolor','y'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(e_left,'mo-','markerfacecolor','m'); % plot it
    
            xlabel('Layer') % label the x axis
            ylabel('Weighting Function Error') % label the y axis
            title('Calculated Weighting Function Error') % label the title
            legend('Matrix Inverse Method Error','Left Division Method Error')
        shg % display the graph
    
    
    %o)
    %det(full_a) commented out for a reason... det() can't be used on a
    %non-square matrix, instead the rank can still be used to determine
    %whether the matrix is singular
    cond_full_a=cond(full_a) %decent number, not too bad... 278.1625
    rank(full_a) %10
    rank([full_a,full_b]) %11, they don't match!! move on regardless...
    
    %q)
    %x4_mat=inv(full_a)*full_b;
    %gets error since it isn't a square matrix
    
    %r)
    x4_left=full_a\full_b; %solution with the left division method
    full_ans=full_a*x4_left; %proof that x is the solution to each equation, ans=z
    
    %v)
    figure(3) %change the figure number so that it won't overwrite the previously graphed figure
        plot(x4_left,b,'yo-','markerfacecolor','y'); hold on; % plot it, and keep the plot so that all can be graphed on it
        plot(full_true_t,full_b,'co-','markerfacecolor','c'); % plot it
    
            xlabel('Weighting Function') % label the x axis
            ylabel('Height (km)') % label the y axis
            title('Calculated Weighting Function with Height') % label the title
            legend('Left Division Method','True Temperature')
        shg % display the graph
    
    %w)
    e4_left=x4_left-true_t;
    
    %x)
    figure(4) %change the figure number so that it won't overwrite the previously graphed figure
        plot(e4_left,'yo-','markerfacecolor','y'); hold on; % plot it, and keep the plot so that all can be graphed on it
    
            xlabel('Layer') % label the x axis
            ylabel('Weighting Function Error') % label the y axis
            title('Calculated Weighting Function Error') % label the title
            legend('Left Division Method Error')
        shg % display the graph
    
    
    