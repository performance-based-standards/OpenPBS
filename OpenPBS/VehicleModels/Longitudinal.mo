within OpenPBS.VehicleModels;
partial model Longitudinal

  parameter Parameters.Base.VehicleModel paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

   parameter Integer mode=1
    "1: Normal, 2: Quasistatic"
        annotation(choices(choice=1 "Normal", choice=2 "Quasi-static"));
  parameter Modelica.SIunits.Velocity vx0=15;
  parameter Modelica.SIunits.Angle inclination_angle "Inclination angle, positive for uphill driving";

  parameter Integer nu=paramSet.nu;
  parameter Integer na=paramSet.na;
  parameter Modelica.SIunits.Mass[nu] m=paramSet.m;
  parameter Modelica.SIunits.Length[nu,na] L=paramSet.L
    "Axle positions relative first axle of each unit";
  parameter Modelica.SIunits.Length[nu] X=paramSet.X
    "C.g. position relative first axle";
  parameter Modelica.SIunits.Length[nu] A=paramSet.A
    "Front coupling position relative first axle";
  parameter Modelica.SIunits.Length[nu] B=paramSet.B
    "Rear coupling position relative first axle";
  parameter Integer[nu,na] axlegroups=paramSet.axlegroups;
  parameter Boolean[nu,na] driven=paramSet.driven;

  final parameter Modelica.SIunits.Length[nu,na] Lcog = L-matrix(X)*ones(1,na)
    "Axle positions relative c.g.";
  final parameter Modelica.SIunits.Length[nu] Bcog = B-X;
  final parameter Modelica.SIunits.Length[nu] Acog = A-X;

  final parameter Modelica.SIunits.Position[nu,na] rx0=TM*[0;matrix(B[1:nu-1]-A[2:nu])]*ones(1,na)+L;
  final parameter Integer TM[nu,nu]=Functions.tril(nu);

  OpenPBS.VehicleModels.VerticalForces verticalForces;

  Modelica.SIunits.Acceleration ax[nu];
  Modelica.SIunits.Velocity vx[nu];

  /* Tire forces */
  Modelica.SIunits.Force Fx[nu,na] "Vehicle longitudinal force per axle";

  /* Coupling forces */
  Modelica.SIunits.Force Fcx[nu-1] "Longitudinal coupling forces";

  /* Derivative variables */
  Modelica.SIunits.Acceleration[nu] d_vx;
  //Modelica.SIunits.Velocity[nu] d_rx;

  Modelica.SIunits.Position[nu,na] rx(start=rx0);

  Real[nu,na] friction_usage=Fx./verticalForces.Fz;

initial equation
  vx=vx0*ones(nu);
equation
  if mode==1 then
    der(vx)=d_vx;
  else
    der(vx)=zeros(nu);
  end if;

  d_vx=ax;

  /* Kinematic constraints in couplings */
   for i in 1:nu-1 loop
     //vx[i+1] = vx[i];
     ax[i+1] = ax[i];
   end for;

  m.*ax=vector(Fx*ones(na,1)-[matrix(Fcx);0]+[0;matrix(Fcx)]);

  /* Axle global positions */
  der(rx)=if mode==1 then matrix(vx)*ones(1,na) else zeros(nu,na);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Longitudinal;
