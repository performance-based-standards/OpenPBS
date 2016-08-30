function [chassis,axles,wheels] = drawVehicle(rx,ry,delta,pz,w,A,B,ax)
%DRAW Summary of this function goes here
%   Detailed explanation goes here
if nargin<9
    ax = gca;
end

axes(ax)
for i = 1:size(rx,1)
    chassis(i)=plot(ax,[rx(i,1)+A(i)*cos(pz(i)) rx(i,1)+B(i)*cos(pz(i))],[ry(i,1)+A(i)*sin(pz(i)) ry(i,1)+B(i)*sin(pz(i))],'k');
    hold on
    for j=1:size(rx,2)
        axles(i,j) = plot(ax,[rx(i,j)-0.5*w(i,j)*sin(pz(i)) rx(i,j)+0.5*w(i,j)*sin(pz(i))],[ry(i,j)+0.5*w(i,j)*cos(pz(i)) ry(i,j)-0.5*w(i,j)*cos(pz(i))],'k');
        wheels(i,j,1) = drawRectangle(rx(i,j)-0.5*w(i,j)*sin(pz(i)),ry(i,j)+0.5*w(i,j)*cos(pz(i)),0.2,0.6,pz(i)+delta(i,j),ax);
        wheels(i,j,2) = drawRectangle(rx(i,j)+0.5*w(i,j)*sin(pz(i)),ry(i,j)-0.5*w(i,j)*cos(pz(i)),0.2,0.6,pz(i)+delta(i,j),ax);
    end
end
hold off
end

