function [RWA,RWApass,LSSP,LSSPpass] = openPBS_Adouble(L,w,X,A,B,driven,C,m,I)
    fmu_obj = FMUModelCS1('OpenPBS_PBS_Variants_Adouble_LSSP.fmu');

    fmu_obj.fmiInstantiateSlave;
    fmu_obj.fmiInitializeSlave;
    
    for i=1:4
        for j=1:3
            outdata.name{end+1}=['vehicle.vehicle.rx[' num2str(i) ',' num2str(j) ']'];
            outdata.name{end+1}=['vehicle.vehicle.ry[' num2str(i) ',' num2str(j) ']'];
        end
    end
    
    for i=1:4
        for j=1:3
            outdata.name{end+1}=['pathPositionLast[' num2str(i) ', ' num2str(j) '].s_out'];
            outdata.name{end+1}=['pathPositionLast[' num2str(i) ', ' num2str(j) '].n_out'];
        end
    end

    for i=1:4
        for j=1:3
            outdata.name{end+1}=['vehicle.vehicle.delta[' num2str(i) ',' num2str(j) ']'];
        end
    end
    
    [t,y,n]=fmu_obj.simulate(0:10);
    LSSP=y(end);
    LSSPpass=1;
    
    
    
    
    
    

end

