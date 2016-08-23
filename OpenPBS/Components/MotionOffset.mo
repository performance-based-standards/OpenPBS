within OpenPBS.Components;
block MotionOffset
  "Calculate velocities and positions of a point offset from vehicle c.g."
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Position x_offset=0 "Longitudinal offset";
  parameter Modelica.SIunits.Position y_offset=0 "Lateral offset";

  Modelica.Blocks.Interfaces.RealInput vx
    "Vehicle longitudinal velocity (vehicle local)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput vy
    "Vehicle lateral velocity (vehicle local)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput wz "Vehicle yaw rate"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput vx_offset
    "Longitudinal velocity at offset point"
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
  Modelica.Blocks.Interfaces.RealOutput vy_offset
    "Lateral velocity at offset point"
    annotation (Placement(transformation(extent={{100,-80},{140,-40}})));

equation
  vx_offset = vx-wz*y_offset;
  vy_offset = vy+wz*x_offset;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MotionOffset;
