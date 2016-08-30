function [] = updateVehicle(rx,ry,delta,pz,w,A,B,chassis,axles,wheels)

for i = 1:size(rx,1)
    set(chassis(i),'XData',[rx(i,1)+A(i)*cos(pz(i)) rx(i,1)+B(i)*cos(pz(i))]);
    set(chassis(i),'YData',[ry(i,1)+A(i)*sin(pz(i)) ry(i,1)+B(i)*sin(pz(i))]);
    for j=1:size(rx,2)
        set(axles(i,j),'XData',[rx(i,j)-0.5*w(i,j)*sin(pz(i)) rx(i,j)+0.5*w(i,j)*sin(pz(i))]);
        set(axles(i,j),'YData',[ry(i,j)+0.5*w(i,j)*cos(pz(i)) ry(i,j)-0.5*w(i,j)*cos(pz(i))]);
        updateRectangle(rx(i,j)-0.5*w(i,j)*sin(pz(i)),ry(i,j)+0.5*w(i,j)*cos(pz(i)),0.2,0.6,pz(i)+delta(i,j),wheels(i,j,1));
        updateRectangle(rx(i,j)+0.5*w(i,j)*sin(pz(i)),ry(i,j)-0.5*w(i,j)*cos(pz(i)),0.2,0.6,pz(i)+delta(i,j),wheels(i,j,2));
    end
end
hold off
end

