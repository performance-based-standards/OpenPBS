function [LSSP,valid,rx,ry,pz,delta,s_left,n_left,s_right,n_right] = getVariablesLSSP(t,yout,yname,nu,na);



rx=zeros(size(t,1),nu,na);
ry=zeros(size(t,1),nu,na);
pz=zeros(size(t,1),nu);
delta=zeros(size(t,1),nu,na);
s_left=zeros(size(t,1),nu,na);
n_left=zeros(size(t,1),nu,na);

    for i=1:nu
        pz(:,i)=yout(:,strcmp(['vehicle.vehicle.pz[' num2str(i) ']'],yname));
        for j=1:na
            rx(:,i,j)=yout(:,strcmp(['vehicle.vehicle.rx[' num2str(i) ',' num2str(j) ']'],yname));
            ry(:,i,j)=yout(:,strcmp(['vehicle.vehicle.ry[' num2str(i) ',' num2str(j) ']'],yname));
            delta(:,i,j)=yout(:,strcmp(['vehicle.vehicle.delta[' num2str(i) ',' num2str(j) ']'],yname));
            s_left(:,i,j)=yout(:,strcmp(['pathPositionLeft[' num2str(i) ', ' num2str(j) '].s_out'],yname));
            n_left(:,i,j)=yout(:,strcmp(['pathPositionLeft[' num2str(i) ', ' num2str(j) '].n_out'],yname));
            s_right(:,i,j)=yout(:,strcmp(['pathPositionRight[' num2str(i) ', ' num2str(j) '].s_out'],yname));
            n_right(:,i,j)=yout(:,strcmp(['pathPositionRight[' num2str(i) ', ' num2str(j) '].n_out'],yname));            
        end
    end
    LSSP=yout(:,strcmp(['LSSP'],yname));
    valid=yout(:,strcmp(['valid'],yname));
end

