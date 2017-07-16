within OpenPBS.VehicleModels;
partial model Longitudinal

  replaceable parameter VehicleParameters.Vehicles.Adouble6x4 paramSet
    constrainedby VehicleParameters.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

   parameter Integer mode=2
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
  parameter Real drag_coefficient=paramSet.drag_coefficient;
  parameter Modelica.SIunits.Area frontal_area=paramSet.frontal_area;
  parameter Real rolling_resistance_coefficient=paramSet.rolling_resistance_coefficient "Rolling resistance force as a function of vertical force";


  parameter Modelica.SIunits.Force max_thrust_force_vx0=paramSet.max_thrust_force_vx0;
  parameter Modelica.SIunits.Power max_engine_power=paramSet.max_engine_power;

  parameter Modelica.SIunits.Density air_density=1.204;

  final parameter Modelica.SIunits.Length[nu,na] Lcog = L-matrix(X)*ones(1,na)
    "Axle positions relative c.g.";
  final parameter Modelica.SIunits.Length[nu] Bcog = B-X;
  final parameter Modelica.SIunits.Length[nu] Acog = A-X;

  final parameter Modelica.SIunits.Position[nu,na] rx0=TM*[0;matrix(B[1:nu-1]-A[2:nu])]*ones(1,na)+L;
  final parameter Integer TM[nu,nu]=Functions.tril(nu);
  parameter Integer n_driven=sum(Modelica.Math.BooleanVectors.countTrue(driven));

  OpenPBS.VehicleModels.VerticalForces verticalForces(paramSet=paramSet);

  Modelica.SIunits.Acceleration ax[nu];
  Modelica.SIunits.Velocity vx[nu];

  /* Tire forces */
  Modelica.SIunits.Force Fx[nu,na] "Vehicle longitudinal force per axle";
  Modelica.SIunits.Force Fxd "Drive force (applied to each driven axle)";


  /* Coupling forces */
  Modelica.SIunits.Force Fcx[nu-1] "Longitudinal coupling forces";

  /* Chassis forces */
  Modelica.SIunits.Force Fxa "Aerodynamic force";

  /* Derivative variables */
  //Modelica.SIunits.Acceleration[nu] d_vx;
  //Modelica.SIunits.Velocity[nu] d_rx;

  Modelica.SIunits.Position[nu,na] rx(start=rx0);

  Real[nu,na] friction_usage=Fx./verticalForces.Fz;


initial equation
   vx=vx0*ones(nu);
equation
  if mode==1 then
    der(vx)=ax;
  else
    der(vx)=zeros(nu);
  end if;

//   d_vx=ax;

  Fxa = 0.5*air_density*vx[1]^2*drag_coefficient*frontal_area "Aerodynamic drag";

  /* Tire force */
  for i in 1:nu loop
    for j in 1:na loop
      if driven[i,j] then
        Fx[i,j]=Fxd-verticalForces.Fz[i,j]*sin(inclination_angle)-verticalForces.Fz[i,j]*rolling_resistance_coefficient;
      else
        Fx[i,j]=-verticalForces.Fz[i,j]*sin(inclination_angle)-verticalForces.Fz[i,j]*rolling_resistance_coefficient;
      end if;
    end for;
  end for;


  /* Kinematic constraints in couplings */
   for i in 1:nu-1 loop
     ax[i+1] = ax[i];
   end for;

  m.*ax=vector([matrix(Fxa);zeros(nu-1,1)]+Fx*ones(na,1)-[matrix(Fcx);0]+[0;matrix(Fcx)]);

  /* Axle global positions */
  der(rx)=if mode==1 then matrix(vx)*ones(1,na) else zeros(nu,na);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Longitudinal;
