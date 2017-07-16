within OpenPBS.VehicleModels;
model SingleTrack_SaturatedTyre
  "Single-track model for lateral dynamics of articulated vehicles"
  /* All length parameters positive forward */
  parameter Vehicles.Base.VehicleModel paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  OpenPBS.VehicleModels.VerticalForces verticalForces(nu=nu,na=na,paramSet=paramSet);

  parameter Integer mode=1
    "1: Normal, 2: Non-inertial mode, no mass or inertia is considered, 3: Quasistatic, all derivatives are zero"
        annotation(choices(choice=1 "Normal", choice=2 "Non-inertial",
                        choice=3 "Quasi-static"));

//   parameter Boolean steadystate=false
//     "True if all derivatives should be set to zero";
//   /* Dimensions */
//   parameter Boolean noninertial=false
//     "True if inertial effects should be ignored";

parameter Integer nu=paramSet.nu "Number of units";
parameter Integer na=paramSet.na "Max number of axles per unit";

parameter Modelica.SIunits.Length[nu,na] L=paramSet.L
    "Axle positions relative first axle of each unit";
parameter Modelica.SIunits.Length[nu] X=paramSet.X
    "C.g. position relative first axle";
parameter Modelica.SIunits.Length[nu] A=paramSet.A
    "Front coupling position relative first axle";
parameter Modelica.SIunits.Length[nu] B=paramSet.B
    "Rear coupling position relative first axle";
    parameter Modelica.SIunits.Length[nu] FOH=paramSet.FOH
    "Front overhang relative first axle of each unit";
     parameter Modelica.SIunits.Length[nu] ROH=paramSet.ROH
    "Front overhang relative first axle of each unit";
  parameter Modelica.SIunits.Angle inclination=0 "Lateral road inclination";

parameter Boolean[nu,na] driven=paramSet.driven;

  /* Cornering stiffnesses */
Real[nu,na] C=paramSet.Cc.*verticalForces.Fz
    "Linear cornering stiffness per axle";

  /* Masses and inertias */
      parameter Modelica.SIunits.Mass[nu] m = paramSet.m "Masses";
    parameter Modelica.SIunits.Inertia[nu] I = paramSet.I "Inertias";

  /* Inputs */
    // input Modelica.SIunits.Angle[nu,na] delta_in
    input Modelica.Blocks.Interfaces.RealInput delta_in
    "Steering angle at tractor front axle" annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

    input Modelica.Blocks.Interfaces.RealInput vx_in
    "First unit velocity input" annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  /* Outputs */
   Modelica.Blocks.Interfaces.RealOutput vx_out[nu]=vx annotation (Placement(transformation(extent={{100,70},
            {120,90}})));
   Modelica.Blocks.Interfaces.RealOutput vy_out[nu]=vy annotation (Placement(transformation(extent={{100,40},
            {120,60}})));
   Modelica.Blocks.Interfaces.RealOutput wz_out[nu]=wz annotation (Placement(transformation(extent={{100,8},
            {120,28}})));
   Modelica.Blocks.Interfaces.RealOutput ay_out[nu,na] = matrix(d_vy)*ones(1,na)+Lcog.*(matrix(d_wz)*ones(1,na))+(matrix(wz)*ones(1,na)).*(matrix(vx)*ones(1,na)) annotation (Placement(transformation(extent={{100,-60},
            {120,-40}})));
   Modelica.Blocks.Interfaces.RealOutput ax_out[nu,na] = matrix(d_vx)*ones(1,na)-(matrix(wz)*ones(1,na)).*((matrix(vy)*ones(1,na))+Lcog.*(matrix(wz)*ones(1,na))) annotation (Placement(transformation(extent={{100,-32},
            {120,-12}})));
   Modelica.Blocks.Interfaces.RealOutput ry_out[nu,na]=ry
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
//    Modelica.Blocks.Interfaces.RealOutput front_direction = atan2(vy[1]+Lcog[1,1]*wz[1],vx[1])+pz[1]
//     "Direction of travel at front axle"                                                                                                 annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  /* Steering angles */
  Modelica.SIunits.Angle[nu,na] delta "Steering angles per axle";

  /* Accelerations */
  Modelica.SIunits.Acceleration ax[nu] = d_vx-vy.*wz;
  Modelica.SIunits.Acceleration ay[nu] = d_vy+vx.*wz;

  /* States */
  Modelica.SIunits.AngularVelocity wz[nu](start=zeros(nu)) "Yaw rates";

    Modelica.SIunits.Velocity[nu] vy(start=zeros(nu))
    "Lateral velocities at c.g.";

    Modelica.SIunits.Velocity[nu] vx "Longitudinal velocities";

    Modelica.SIunits.Angle theta[nu-1] "Articulation angles";

  /* ---------- Auxiliary variables ---------- */
  /* Slip angles */

   Modelica.SIunits.Angle alpha[nu,na] "Slip angle per axle";

  /* Tire forces */
  Modelica.SIunits.Force Fxd "Drive force (applied to each driven axle)";
  Modelica.SIunits.Force Fxw[nu,na] "Wheel longitudinal force";
  Modelica.SIunits.Force Fyw[nu,na] "Wheel lateral force";
  Modelica.SIunits.Force Fx[nu,na] "Vehicle longitudinal force per axle";
   Modelica.SIunits.Force Fy[nu,na] "Vehicle lateral force per axle";

  /* Coupling forces */
   Modelica.SIunits.Force Fcx[nu-1] "Longitudinal coupling forces";
   Modelica.SIunits.Force Fcy[nu-1] "Lateral coupling forces";

 /* Computed c.g. distances, positive length should give positive c.g. torque for positive (leftward) lateral force*/

  /* Derivative variables */

  Modelica.SIunits.Acceleration[nu] d_vx;

  Modelica.SIunits.Acceleration[nu] d_vy;

  Modelica.SIunits.AngularAcceleration[nu] d_wz;

  Modelica.SIunits.AngularVelocity[nu-1] d_theta;

  parameter Modelica.SIunits.Length[nu,na] Lcog = L-matrix(X)*ones(1,na)
    "Axle positions relative c.g.";
  parameter Modelica.SIunits.Length[nu] Bcog = B-X;
  parameter Modelica.SIunits.Length[nu] Acog = A-X;
  parameter Modelica.SIunits.Position[nu,na] rx0=TM*[0;matrix(B[1:nu-1]-A[2:nu])]*ones(1,na)+L;
  parameter Integer TM[nu,nu]=Functions.tril(nu);

  /*Initial coordinates for the over hang. Assume straight starting position. */

   //Modelica.SIunits.Length[nu] rx01=rx0[:,1];

  parameter Modelica.SIunits.Length[nu,2] rx0_oh=cat(2,matrix(rx0[:,1]+FOH),matrix(rx0[:,1]+ROH))
  "Initial position in x-dir of overhang. Front in first colume rear in second. Resolved from first units first axle";
  parameter Modelica.SIunits.Length[nu,2] Lcog_oh=cat(2,matrix(FOH-X),matrix(ROH-X))
                                                                    "Position of overhang in x-dir from cog, one row for each unit";
    Modelica.SIunits.Position[nu,na] rx(start=rx0);
    Modelica.SIunits.Position[nu,na] ry(start=zeros(nu,na));
    Modelica.SIunits.Angle[nu] pz;

    /*Friction usage. One element for each axle*/
    output Real[nu,na] friction_usage=sqrt(Fx.^2+Fy.^2)./verticalForces.Fz;

    parameter Real mu "Friction coefficient";

equation
    if mode==1 then
        d_vx=der(vx);
        d_vy=der(vy);
        d_wz=der(wz);
        d_theta=der(theta);
     elseif mode==2 then
        d_vx=zeros(nu);
        d_vy=zeros(nu);
        d_wz=zeros(nu);
        d_theta=der(theta);
    else
        d_vx=zeros(nu);
        d_vy=zeros(nu);
        d_wz=zeros(nu);
        d_theta=zeros(nu-1);
    end if;

/* Input equations */
vx[1] = max(0.1,vx_in);
for i in 1:nu loop
  for j in 1:na loop
    if i==1 and j==1 then
      delta[i,j]=delta_in;
    else
      delta[i,j]=0;
    end if;
  end for;
end for;

/* Slip angles */
alpha = ((matrix(vy)*ones(1,na)+Lcog.*(matrix(wz)*ones(1,na)))./(matrix(vx)*ones(1,na))-delta);


  /* Tire force */
  //Tyre-Longitudinal
  for i in 1:nu loop
    for j in 1:na loop
      if driven[i, j] then
        Fxw[i, j] = Fxd;
      else
        Fxw[i, j] = 0;
      end if;
    end for;
  end for;
  //Tyre-Lateral
  for i in 1:nu loop
    for j in 1:na loop
//       //Change step 2:
       if driven[i, j] then
         Fyw[i, j] = -sign(alpha[i, j])*min(C[i, j]*abs(alpha[i, j]), mu*verticalForces.Fz[i, j])*sqrt(1-((Fyw[i, j]/(mu*verticalForces.Fz[i, j]))^2));
       else
         Fyw[i, j] = -sign(alpha[i, j])*min(C[i, j]*abs(alpha[i, j]), mu*verticalForces.Fz[i, j]);
       end if;
//       //Change step 1:
//        if driven[i, j] then
//          Fyw[i, j] = -C[i, j]*alpha[i, j];
//        else
//          Fyw[i, j] = -sign(alpha[i, j])*min(C[i, j]*abs(alpha[i, j]), mu*verticalForces.Fz[i, j]);
//        end if;
//       //No change:
//          Fyw[i, j] = -C[i, j]*alpha[i, j];
    end for;
  end for;
  //Transfromation between tyre and vehicle units coordinate systems
  Fx = Fxw .* cos(delta) - Fyw .* sin(delta);
  Fy = Fxw .* sin(delta) + Fyw .* cos(delta) - sin(inclination)*verticalForces.Fz;


/* Kinematic constraints in couplings */
for i in 1:nu-1 loop
  vx[i+1] = vx[i]*cos(theta[i])-(vy[i]+Bcog[i]*wz[i])*sin(theta[i]);
  vy[i+1]+Acog[i+1]*wz[i+1]=(vy[i]+Bcog[i]*wz[i])*cos(theta[i])+vx[i]*sin(theta[i]);
end for;

(if mode==2 then zeros(nu) else m).*(d_vx-vy.*wz)=vector(Fx*ones(na,1)-[matrix(Fcx);0]+[0;matrix(Fcx)].*cos([0;matrix(theta)])-[0;matrix(Fcy)].*sin([0;matrix(theta)]));

(if mode==2 then zeros(nu) else m).*(d_vy+vx.*wz)=vector(Fy*ones(na,1)-[matrix(Fcy);0]+[0;matrix(Fcx)].*sin([0;matrix(theta)])+[0;matrix(Fcy)].*cos([0;matrix(theta)]));

(if mode==2 then zeros(nu) else I).*d_wz = vector(Lcog.*Fy*ones(na,1)-matrix(Bcog).*[matrix(Fcy);0]+matrix(Acog).*([0;matrix(Fcx)].*sin([0;matrix(theta)])+[0;matrix(Fcy)].*cos([0;matrix(theta)])));

d_theta = wz[1:(nu-1)]-wz[2:nu];

/* Axle global positions */
  der(pz)=wz;
  der(rx)=matrix(vx)*ones(1,na).*(cos(matrix(pz))*ones(1,na))-(matrix(vy)*ones(1,na)+Lcog.*(matrix(wz)*ones(1,na))).*(sin(matrix(pz))*ones(1,na));
  der(ry)=matrix(vx)*ones(1,na).*(sin(matrix(pz))*ones(1,na))+(matrix(vy)*ones(1,na)+Lcog.*(matrix(wz)*ones(1,na))).*(cos(matrix(pz))*ones(1,na));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end SingleTrack_SaturatedTyre;
