function [RWAvalue,RWAsuccess,LSSPvalue,LSSPsuccess] = PBS_NordicCombo(L,w,X,A,B,driven,Cc,m,I,showplot,showanimation)

fmupath = 'fmus/OpenPBS_PBS_Variants_NordicCombo_RWA.fmu';
[RWAvalue,RWAsuccess] = RWA(fmupath,L,w,X,A,B,driven,Cc,m,I,showplot,showanimation);

fmupath = 'fmus/OpenPBS_PBS_Variants_NordicCombo_LSSP.fmu';
[LSSPvalue,LSSPsuccess] = LSSP(fmupath,L,w,X,A,B,driven,Cc,m,I,showplot,showanimation);