within OpenPBS.SandBox;
model RollVectorizedWithStiffnesses

  parameter Integer nu = 3 "Number of units";

  Modelica.SIunits.Force FzOuter[nu]
    "Total vertical load on outer wheels of each unit";
  Modelica.SIunits.Force FzInner[nu]
    "Total vertical load on inner wheels of each unit";

  parameter Modelica.SIunits.Mass m[nu]={23000,23000,23000}
    "Total mass of each unit";

  parameter Modelica.SIunits.Length w[nu]=2*ones(nu)
    "Track width (average for the axles on each unit)";
  parameter Modelica.SIunits.Position h[nu]={2,2,2} "C.g. height";

  Modelica.SIunits.Acceleration ay_in=time;

  Modelica.SIunits.Acceleration ay[nu]=ay_in*ones(nu)
    "Lateral acceleration";

  //Modelica.SIunits.Torque Mx[nu] "Total roll moment per unit";

  Modelica.SIunits.Torque Mxc[nu-1] "Moment sums for coupled systems";
                                       //=OpenPBS.SandBox.MomentCouple(nu, 2, roll_couple, Mx)

  Modelica.SIunits.Angle phix[nu] "Roll angle";
  parameter Modelica.SIunits.RotationalSpringConstant kc[nu]={5000000,5000000,5000000}
    "Roll stiffness";
  parameter Modelica.SIunits.Position rollcenter[nu]=zeros(nu)
    "Roll center height";

   Boolean roll_couple[nu-1]={true,false}
    "True if coupling transfers roll moment";

equation
  zeros(nu) = m*Modelica.Constants.g_n-FzInner-FzOuter;

  zeros(nu) = vector(matrix(FzInner.*w/2-FzOuter.*w/2+m.*ay.*h+m*Modelica.Constants.g_n.*phix.*(h-rollcenter))-([{0};(Mxc)])+([(Mxc);{0}]));

//   Mxc = phic.*kc;

  (FzInner-FzOuter).*w./2=-phix.*kc;

  for i in 1:(nu-1) loop
    if roll_couple[i] then
      phix[i]=phix[i+1];
    else
      Mxc[i]=0;
    end if;
  end for;

//   for i in 1:nu-1 loop
//     FzInner[i]=FzInner[i+1];
//     FzOuter[i]=FzOuter[i+1];
//   end for;

  //Mx = zeros(nu);

//   min(FzInner)=0;

  // FzInner[1]=0;
  // FzInner[2]=0;
  // FzInner[3]=0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RollVectorizedWithStiffnesses;
