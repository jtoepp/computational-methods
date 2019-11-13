function status=plot_2d_vert(ifig,x,y,var,cmin,cmax,units);

status=0;
cmap=linspecer(50);

% make a matrix of lon
[nlon,nlev]=size(y);
lon=zeros(nlon,nlev);
for k=1:nlev
    lon(:,k)=x;
end
%------------------------------------------
% now plot
%------------------------------------------
h=figure(ifig);
clf(ifig);

% position the figure
set(h,'Units','pixels','Position',[700 450 620 350]);


% plot
pcolor(lon,y,squeeze(var(:,:)));
hold on;
shading interp; 
caxis([cmin cmax]);
set(gca,'YDir','reverse');
set(gca,'YScale','log');

%------------------------------------------
% all aesthetics
%------------------------------------------
ylim([100 1020]);
set(gca,'Ytick',[100 250 400 550 700 850 1000]);
set(gca,'YtickLabel',[' 100';' 250';' 400';' 550';' 700';' 850';'1000'],'fontsize',14);
set(gca,'Fontsize',14);
ax=gca;
ax.TickLength=[0.025;0.025];

% colorbar
hh=colorbar('EastOutside');
axx=gca;
axx.TickLength=[0.025;0.025];

set(hh,'Position',[0.912,0.318,0.01,0.403]);
set(hh,'Fontsize',14);
set(get(hh,'Title'),'String',units,'Fontsize',14);
ylabel('Pressure, in hPa','Fontsize',16);
xlabel('Longitude, in deg','Fontsize',16);
colormap(cmap);
status=1;