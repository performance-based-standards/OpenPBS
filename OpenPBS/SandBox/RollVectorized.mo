within OpenPBS.SandBox;
model RollVectorized

  parameter Integer nu = 3 "Number of units";

  Modelica.SIunits.Force FzOuter[nu]
    "Total vertical load on outer wheels of each unit";
  Modelica.SIunits.Force FzInner[nu]
    "Total vertical load on inner wheels of each unit";

  parameter Modelica.SIunits.Mass m[nu]=23000*ones(nu)
    "Total mass of each unit";

  parameter Modelica.SIunits.Length w[nu]=2*ones(nu)
    "Track width (average for the axles on each unit)";
  parameter Modelica.SIunits.Position h[nu]=2*ones(nu) "C.g. height";

  Modelica.SIunits.Acceleration ay_in=time;

  Modelica.SIunits.Acceleration ay[nu]=ay_in*ones(nu)
    "Lateral acceleration";

  //Modelica.SIunits.Torque Mx[nu] "Total roll moment per unit";

  Modelica.SIunits.Torque Mxc[nu-1] "Moment sums for coupled systems";
                                       //=OpenPBS.SandBox.MomentCouple(nu, 2, roll_couple, Mx)

  Modelica.SIunits.Angle phix[nu];
  Modelica.SIunits.RotationalSpringConstant kc[nu]={100000,100000,100000};

//   Boolean roll_couple[nu-1]={true,false}
//     "True if coupling transfers roll moment";
equation
  zeros(nu) = m*Modelica.Constants.g_n-FzInner-FzOuter;

  zeros(nu) = vector(matrix(FzInner.*w/2-FzOuter.*w/2+m.*ay.*h)-([{0};(Mxc)])+([(Mxc);{0}]));

//   Mxc = phic.*kc;

  (FzInner-FzOuter).*w./2=phix.*kc;

  phix[1:end-1]=zeros(nu-1);

//   for i in 1:nu-1 loop
//     FzInner[i]=FzInner[i+1];
//     FzOuter[i]=FzOuter[i+1];
//   end for;

  //Mx = zeros(nu);

  //min(FzInner)=0;

  // FzInner[1]=0;
  // FzInner[2]=0;
  // FzInner[3]=0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RollVectorized;
