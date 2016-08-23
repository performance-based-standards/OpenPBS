within OpenPBS.PBS.Blocks;
block CubicSpline
  extends Modelica.Blocks.Interfaces.SO(y(start=0,fixed=true));

  parameter Modelica.SIunits.Time t_start=1 "Start time";
  parameter Modelica.SIunits.Time t_end=5 "End time";

  parameter Real amplitude=2;

  Real dy;
  Real ddy;
  Real dddy;
protected
  parameter Modelica.SIunits.Time t1=(t_end-t_start)/4 "First transition";
  parameter Modelica.SIunits.Time t2=3*(t_end-t_start)/4
    "Second transition";

  parameter Real k=1; //2*(amplitude-C11*t1-C12)/(t1^2);

//    parameter Real C11(fixed=false);
//    parameter Real C12(fixed=false);
//    parameter Real C13(fixed=false);
//    parameter Real C21(fixed=false);
//    parameter Real C22(fixed=false);
//    parameter Real C23(fixed=false);
//    parameter Real C31(fixed=false);
//    parameter Real C32(fixed=false);
//    parameter Real C33(fixed=false);

equation
//   k*t1^3/6+C11*t1^2/2+C12*t1+C13=-k*t1^3/6+C21*t1^2/2+C22*t1+C23;
//
//   k*t2^3/6+C31*t2^2/2+C32*t2+C33=-k*t2^3/6+C21*t2^2/2+C22*t2+C23;
//
//   k*t1^2/2+C11*t1+C12=-k*t1^2/2+C21*t1+C22;
//
//   k*t2^2/2+C31*t2+C32=-k*t2^2/2+C21*t2+C22;

  der(y)=dy;
  der(dy)=ddy;
  der(ddy)=dddy;

  if time<t_start then
    dddy=0;
  elseif time<t_start+t1 then
    dddy=k;
  elseif time<t_start+t2 then
    dddy=-k;
  elseif time<t_end then
    dddy=k;
  else
    dddy=0;
  end if;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CubicSpline;
