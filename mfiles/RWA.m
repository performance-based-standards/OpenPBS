function [value,success] = RWA(fmupath,L,w,X,A,B,driven,Cc,m,I,showplot,showanimation)
%% Initialize fmu
    fmu_obj = loadFMU(fmupath);

%% Get array sizes    
    nu = size(L,1);
    na = size(L,2);
    
%% Set parameters
    for i=1:nu
        fmu_obj.setValue(['paramSet.A[' num2str(i) ']'],A(i));
        fmu_obj.setValue(['paramSet.B[' num2str(i) ']'],B(i));
        fmu_obj.setValue(['paramSet.X[' num2str(i) ']'],X(i));
        fmu_obj.setValue(['paramSet.m[' num2str(i) ']'],m(i));
        fmu_obj.setValue(['paramSet.I[' num2str(i) ']'],I(i));
        for j=1:na
            fmu_obj.setValue(['paramSet.w[' num2str(i) ',' num2str(j) ']'],w(i,j));
            fmu_obj.setValue(['paramSet.L[' num2str(i) ',' num2str(j) ']'],L(i,j));
            fmu_obj.setValue(['paramSet.Cc[' num2str(i) ',' num2str(j) ']'],Cc(i,j));
            fmu_obj.setValue(['paramSet.driven[' num2str(i) ',' num2str(j) ']'],driven(i,j));
        end
    end

    fmu_obj.initialize;

%% Set up output names
    outdata.name={};
    
    for i=1:nu
       outdata.name{end+1}=['vehicle.wz[' num2str(i) ']'];
       outdata.name{end+1}=['vehicle.ay[' num2str(i) ']'];
       outdata.name{end+1}=['vehicle.pz[' num2str(i) ']'];
    end
    for i=1:nu
        for j=1:na
            outdata.name{end+1}=['vehicle.delta[' num2str(i) ',' num2str(j) ']'];
            outdata.name{end+1}=['vehicle.rx[' num2str(i) ',' num2str(j) ']'];
            outdata.name{end+1}=['vehicle.ry[' num2str(i) ',' num2str(j) ']'];
        end
    end
    [tout, yout, yname] = fmu_obj.simulate(0:0.01:15,'Output',outdata);     
    
    [value_,success_,t,wz,ay,rx,ry,pz,delta] = getVariablesRWA(tout,yout,yname,nu,na);
    value=value_(end);
    success=success_(end);
%% Animation
    if showanimation
        animateRWA(rx,ry,delta,pz,w,A,B);
    end
    
%% Plots
    if showplot
        f=figure('Name','Yaw rates');
        hold on;
        for i=1:nu
            plot(t,wz(:,i));
        end

        f=figure('Name','Lateral accelerations');
        hold on;
        for i=1:nu
            plot(t,ay(:,i));
        end
    end
end

