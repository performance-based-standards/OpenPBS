within OpenPBS.SandBox;
model RollThreeCoupledUnits

  Modelica.SIunits.Force Fz11 "Left side vertical force";
  Modelica.SIunits.Force Fz12 "Right side vertical force";
  Modelica.SIunits.Force Fz21 "Left side vertical force";
  Modelica.SIunits.Force Fz22 "Right side vertical force";
  Modelica.SIunits.Force Fz31 "Left side vertical force";
  Modelica.SIunits.Force Fz32 "Right side vertical force";

  parameter Modelica.SIunits.Mass m1=25000 "Vehicle mass";
  parameter Modelica.SIunits.Mass m2=25000 "Vehicle mass";

  parameter Modelica.SIunits.Length w1=2 "Track width";
  parameter Modelica.SIunits.Position h1=2 "C.g. height";

  parameter Modelica.SIunits.Length w2=2 "Track width";
  parameter Modelica.SIunits.Position h2=2 "C.g. height";

  Modelica.SIunits.Acceleration ay1 "Lateral acceleration";
  Modelica.SIunits.Acceleration ay2=ay1 "Lateral acceleration";

//   Modelica.SIunits.Torque Mx1 "Total roll moment on first unit";
//   Modelica.SIunits.Torque Mx2 "Total roll moment on second unit";

  Modelica.SIunits.Torque Mxc "Coupling roll moment";

equation
  0=m1*Modelica.Constants.g_n-Fz11-Fz12;
  0=m2*Modelica.Constants.g_n-Fz21-Fz22;
  0=Fz11*w1/2-Fz12*w1/2+m1*ay1*h1+Mxc;
  0=Fz21*w2/2-Fz22*w2/2+m2*ay2*h2-Mxc;

  //min(Fz11,Fz21)=0;
  Fz11=0;
  Fz21=0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RollThreeCoupledUnits;
