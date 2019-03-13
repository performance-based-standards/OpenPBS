within OpenPBS.VehicleModels;
model VerticalForces
  parameter OpenPBS.VehicleParameters.Base.VehicleModel paramSet;
  parameter Integer nu=paramSet.nu "Number of units";
  parameter Integer na=paramSet.na "Max number of axles per unit";

  parameter Modelica.SIunits.Mass[nu] m=paramSet.m;
  parameter Modelica.SIunits.Length[nu,na] L=paramSet.L
    "Axle positions relative first axle of each unit";
  parameter Modelica.SIunits.Length[nu] X=paramSet.X
    "C.g. position relative first axle";
  parameter Modelica.SIunits.Length[nu] A=paramSet.A
    "Front coupling position relative first axle";
  parameter Modelica.SIunits.Length[nu] B=paramSet.B
    "Rear coupling position relative first axle";
  parameter Integer[nu,na] axlegroups=paramSet.axlegroups annotation(Evaluate=true);
//   parameter Modelica.SIunits.TranslationalSpringConstant[nu,na] kz(start=paramSet.kz,fixed=false);

  final parameter Modelica.SIunits.Length[nu,na] Lcog = L-matrix(X)*ones(1,na)
    "Axle positions relative c.g.";
  final parameter Modelica.SIunits.Length[nu] Bcog = B-X;
  final parameter Modelica.SIunits.Length[nu] Acog = A-X;
  Modelica.SIunits.Force[nu,na] Fz(start=1e4*ones(nu,na))
    "Vertical force at each axle";
  Modelica.SIunits.Force Fcz[nu-1] "Vertical force at couplings";
  Modelica.SIunits.Force fz_front[nu] "Vertical force of front axle groups";
  Modelica.SIunits.Force fz_rear[nu] "Vertical force of rear axle groups";

equation
  for i in 1:nu loop
     if max(axlegroups[i,:])<2 then
       fz_rear[i]=0;
     end if;
    for j in 1:na loop
      if axlegroups[i,j]==1 then
        Fz[i,j]=fz_front[i];
      elseif axlegroups[i,j]==2 then
        Fz[i,j]=fz_rear[i];
      else
        Fz[i,j]=1;
      end if;
    end for;
  end for;

  m*Modelica.Constants.g_n=vector(Fz*ones(na,1)-[matrix(Fcz);0]+[0;matrix(Fcz)]);

  zeros(nu)=vector(Lcog.*Fz*ones(na,1)-matrix(Bcog).*[matrix(Fcz);0]+matrix(Acog).*[0;matrix(Fcz)]);

 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end VerticalForces;
