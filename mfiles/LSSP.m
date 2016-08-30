function [value,success] = LSSP(fmupath,L,w,X,A,B,driven,Cc,m,I,showplot,showanimation)
%% Initialize fmu
    fmu_obj = loadFMU(fmupath);
    
%     fmu_obj.initialize;

%     fmu_obj.get('pathPositionLast[4, 3].n0')

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
        for j=1:na
            outdata.name{end+1}=['vehicle.vehicle.rx[' num2str(i) ',' num2str(j) ']'];
            outdata.name{end+1}=['vehicle.vehicle.ry[' num2str(i) ',' num2str(j) ']'];
        end
    end

    for i=1:nu
        for j=1:na
            outdata.name{end+1}=['pathPositionRight[' num2str(i) ', ' num2str(j) '].s_out'];
            outdata.name{end+1}=['pathPositionRight[' num2str(i) ', ' num2str(j) '].n_out'];
            outdata.name{end+1}=['pathPositionLeft[' num2str(i) ', ' num2str(j) '].s_out'];
            outdata.name{end+1}=['pathPositionLeft[' num2str(i) ', ' num2str(j) '].n_out'];            
        end
    end

    for i=1:nu
        for j=1:na
            outdata.name{end+1}=['vehicle.vehicle.delta[' num2str(i) ',' num2str(j) ']'];
        end
    end

    for i=1:nu
       outdata.name{end+1}=['vehicle.vehicle.pz[' num2str(i) ']'];
    end

    [tout, yout, yname] = fmu_obj.simulate(0:0.01:5,'Output',outdata);     

    [value_,success_,rx,ry,pz,delta,s_left,n_left,s_right,n_right] = getVariablesLSSP(tout,yout,yname,nu,na);
    
    value=value_(end);
    success=success_(end);

%% Animation
    if showanimation
        animateLSSP(rx,ry,delta,pz,w,A,B);
    end
    
%% Plots
    if showplot
        f=figure('Name','Positions in path coordinates');
        hold on;
        for i=1:nu
            for j=1:na
                plot(squeeze(s_left(:,i,j)),squeeze(n_left(:,i,j)));
                plot(squeeze(s_right(:,i,j)),squeeze(n_right(:,i,j)));
            end
        end

        f=figure('Name','Global axle center positions');
        hold on;
        for i=1:nu
            for j=1:na
                plot(squeeze(rx(:,i,j)),squeeze(ry(:,i,j)));  
            end
        end
    end
end

