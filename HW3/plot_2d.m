function status=plot_2d(ifig,lon,lat,var,cmin,cmax,units);

status=0;
cmap=linspecer(50);

%------------------------------------------
% all about the coastline -- need usahi.mat
%------------------------------------------

coastlines=coast;
row_c=find(coastlines(:,2)<-178.5 & coastlines(:,2)>=-180 );
coastlines(row_c,2)=NaN;

%------------------------------------------
% now plot
%------------------------------------------
h=figure(ifig);
clf(ifig);

% position the figure
set(h,'Units','pixels','Position',[700 450 620 350]); 
% plot the field
h1=imagesc(lon,lat,(var));
axis('xy');
hold on;
shading flat; 
caxis([cmin cmax]);

% add coastlines
h2=plot(coastlines(:,2), coastlines(:,1),'k.-','Linewidth',1.0);
set(h2,'Markersize',0.1);
set(gca,'Fontsize',14);
ax=gca;
ax.TickLength=[0.025;0.025];

% add colorbar
hh=colorbar('EastOutside');
axx=gca;
axx.TickLength=[0.025;0.025];
set(hh,'Position',[0.925,0.318,0.01,0.4]);
set(hh,'Fontsize',14);
set(get(hh,'Title'),'String',units);
ylabel('Latitude, in deg','Fontsize',16);
xlabel('Longitude, in deg','Fontsize',16);

% change colormap
colormap(cmap);
status=1;