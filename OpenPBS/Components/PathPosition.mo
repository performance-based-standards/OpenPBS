within OpenPBS.Components;
block PathPosition
  "Calculate path coordinates based on integrating global velocity"

  parameter Modelica.SIunits.Position s0=0 "Initial position along path";
  parameter Modelica.SIunits.Position n0=0
    "Initial position normal to path";

  Modelica.Blocks.Interfaces.RealInput vx
    "Vehicle longitudinal velocity (vehicle local)"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  Modelica.Blocks.Interfaces.RealInput vy
    "Vehicle lateral velocity (vehicle local)"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput pz "Vehicle heading angle (global)"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

  Modelica.Blocks.Interfaces.RealOutput s_out=s "Position along path"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput n_out=n "Position normal to path"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));

  Modelica.Blocks.Interfaces.RealOutput d_n_out=der(n)
    "Derivative of position normal to path"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput pp_out=pp "Path direction"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));

  Modelica.SIunits.Angle pp "Path heading angle";
  Modelica.SIunits.Position s(start=s0) "Position along path";
  Modelica.SIunits.Position n(start=n0) "Position normal to path";

  Modelica.Blocks.Interfaces.RealInput c "Path curvature" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,120})));

  Modelica.SIunits.Position rx(start=s0)
    "Closest point on path x coordinate";
  Modelica.SIunits.Position ry(start=n0)
    "Closest point on path y coordinate";

equation
  der(s)*(1-n*c) = vx*cos(pz-pp)-vy*sin(pz-pp);
  der(n) = vx*sin(pz-pp)+vy*cos(pz-pp);

  der(pp) = der(s)*c;

  der(rx) = der(s)*cos(pp)-0*sin(pp);
  der(ry) = der(s)*sin(pp)+0*cos(pp);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PathPosition;
