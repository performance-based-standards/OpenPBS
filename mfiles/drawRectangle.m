function [rect] = drawRectangle(x,y,w,l,phi,ax)
%DRAWRECTANGLE 
% x, x position of center
% y, y position of center
% w, width (along y for zero phi)
% l, length (along x for zero phi)
% phi, angle

if nargin<6
    ax=gca;
end

x = [x+l/2*cos(phi)-w/2*sin(phi) x-l/2*cos(phi)-w/2*sin(phi) x-l/2*cos(phi)+w/2*sin(phi) x+l/2*cos(phi)+w/2*sin(phi) x+l/2*cos(phi)-w/2*sin(phi)];
y = [y+l/2*sin(phi)+w/2*cos(phi) y-l/2*sin(phi)+w/2*cos(phi) y-l/2*sin(phi)-w/2*cos(phi) y+l/2*sin(phi)-w/2*cos(phi) y+l/2*sin(phi)+w/2*cos(phi)];
rect = plot(ax,x,y,'k');
end

