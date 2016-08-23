within OpenPBS.SandBox;
block Curve90deg2
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.Length radius=12.5 "Curve radius";
  parameter Real s_change=0.001 "Distance for curvature change";
  parameter Modelica.SIunits.Position s_start=50
    "Position along path when curve starts";

  Real curvature(start=0);
protected
  parameter Real s_length = radius*Modelica.Constants.pi/2;
  parameter Real s0 = 0;
  parameter Real s1 = s_start;
  parameter Real s2 = s_start + s_change;
  parameter Real s3 = s_start + s_change + s_length;
  parameter Real s4 = s_start + s_change + s_length + s_change;
equation
  when initial() then
    der(curvature) = 0;
  elsewhen u>s1 then
    der(curvature) = (1/radius)/s_change*der(u);
  elsewhen u>s2 then
    der(curvature) = 0;
  elsewhen u>s3 then
    der(curvature) = -(1/radius)/s_change*der(u);
  elsewhen u>s4 then
    der(curvature) = 0;
  end when;
  y = smooth(2,curvature);

    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
end Curve90deg2;
