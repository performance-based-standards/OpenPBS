function [] = animateRWA(rx,ry,delta,pz,w,A,B)
%ANIMATE e
%   y: set of signals from simulation
%   y(:,1): rx, x positions
%   y(:,2): ry, y positions
%   y(:,3): pz, angles

f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
plot(ax,rx(:,1,1),ry(:,1,1),'k');
hold on;
set(ax,'XLim',[-50 5],'YLim',[-25 25]);
axis manual;
axis equal;

i=1;
[chassis,axles,wheels] = drawVehicle(squeeze(rx(i,:,:))-squeeze(rx(i,1,1)),squeeze(ry(i,:,:))-squeeze(ry(i,1,1)),squeeze(delta(i,:,:)),pz(i,:),w,A,B,ax);
set(ax,'XLim',[-50 5],'YLim',[-25 25]);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',i, 'min',1, 'max',size(rx,1));
          
b.Value

hLstn = addlistener(b,'ContinuousValueChange',@(es,ed) updateVehicle(squeeze(rx(floor(es.Value),:,:))-squeeze(rx(floor(es.Value),1,1)),squeeze(ry(floor(es.Value),:,:))-squeeze(ry(floor(es.Value),1,1)),squeeze(delta(floor(es.Value),:,:)),pz(floor(es.Value),:),w,A,B,chassis,axles,wheels));
% hListener = addlistener(hSlider,'Value','PostSet',@(s,e) disp('hi'));

% bgcolor = f.Color;
% bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
%                 'String','0','BackgroundColor',bgcolor);
% bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
%                 'String','1','BackgroundColor',bgcolor);
% bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
%                 'String','Damping Ratio','BackgroundColor',bgcolor);

% axis equal;

% b.Callback = @(es,ed) updateVehicle(squeeze(rx(floor(es.Value),:,:)),squeeze(ry(floor(es.Value),:,:)),squeeze(delta(floor(es.Value),:,:)),pz(floor(es.Value),:),w,A,B,chassis,axles,wheels); 

% b.Value
% for i=1:size(rx,1)
%    updateVehicle(squeeze(rx(i,:,:)),squeeze(ry(i,:,:)),squeeze(delta(i,:,:)),pz(i,:),w,A,B,chassis,axles,wheels);
%    pause(0.001)
% end

end


