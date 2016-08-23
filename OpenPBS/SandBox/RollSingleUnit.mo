within OpenPBS.SandBox;
model RollSingleUnit

  Modelica.SIunits.Force Fz1 "Left side vertical force";
  Modelica.SIunits.Force Fz2 "Right side vertical force";

  parameter Modelica.SIunits.Mass m=25000 "Vehicle mass";

  parameter Modelica.SIunits.Length w=2 "Track width";
  parameter Modelica.SIunits.Position h=2 "C.g. height";

  Modelica.SIunits.Acceleration ay "Lateral acceleration";
equation
  0=m*Modelica.Constants.g_n-Fz1-Fz2;
  0=Fz1*w/2-Fz2*w/2+m*ay*h;

  Fz1=0;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RollSingleUnit;
