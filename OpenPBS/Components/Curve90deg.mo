within OpenPBS.Components;
block Curve90deg
  "Output curvature as a function of path length for a 90° curve"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Modelica.SIunits.Length radius=12.5 "Curve radius";
  parameter Modelica.SIunits.Position s_start=50
    "Position along path when curve starts";
  Real curvature;
equation
  when initial() then
    curvature = 0;
  elsewhen u>s_start then
    curvature = 1/radius;
  elsewhen u>s_start+radius*Modelica.Constants.pi then
    curvature = 0;
  end when;
  y = smooth(2,curvature);
end Curve90deg;
