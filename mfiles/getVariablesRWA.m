function [RWA,valid,t,wz,ay,rx,ry,pz,delta] = getVariablesRWA(t,yout,yname,nu,na)

t = t;

pz=zeros(size(t,1),nu);
wz=zeros(size(t,1),nu);
ay=zeros(size(t,1),nu);
rx=zeros(size(t,1),nu,na);
ry=zeros(size(t,1),nu,na);
delta=zeros(size(t,1),nu,na);

    for i=1:nu
        wz(:,i)=yout(:,strcmp(['vehicle.wz[' num2str(i) ']'],yname));
        ay(:,i)=yout(:,strcmp(['vehicle.ay[' num2str(i) ']'],yname));
        pz(:,i)=yout(:,strcmp(['vehicle.pz[' num2str(i) ']'],yname));
        for j=1:na
            rx(:,i,j)=yout(:,strcmp(['vehicle.rx[' num2str(i) ',' num2str(j) ']'],yname));
            ry(:,i,j)=yout(:,strcmp(['vehicle.ry[' num2str(i) ',' num2str(j) ']'],yname));
            delta(:,i,j)=yout(:,strcmp(['vehicle.delta[' num2str(i) ',' num2str(j) ']'],yname));          
        end        
    end
    RWA=yout(:,strcmp(['RWA'],yname));
    valid=yout(:,strcmp(['valid'],yname));
end

