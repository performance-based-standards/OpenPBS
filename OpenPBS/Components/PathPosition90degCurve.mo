within OpenPBS.Components;
model PathPosition90degCurve
  "Calculate the position of a point given by the offest parameters."

  Components.PathPosition pathPosition(s0=s0, n0=n0)
    annotation (Placement(transformation(extent={{-20,24},{0,44}})));
  Components.MotionOffset motionOffset(x_offset=x_offset, y_offset=y_offset)
    annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
  Modelica.Blocks.Interfaces.RealInput vx "Vehicle longitudinal velocity (local)"
    annotation (Placement(transformation(extent={{-134,46},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput vy "Vehicle lateral velocity(local)"
    annotation (Placement(transformation(extent={{-136,-4},{-100,32}})));
  Modelica.Blocks.Interfaces.RealInput wz "Yaw rate"
    annotation (Placement(transformation(extent={{-136,-46},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput pz "Vehicle heading angle"
    annotation (Placement(transformation(extent={{-136,-92},{-100,-56}})));
  Modelica.Blocks.Interfaces.RealOutput s_out "Position along path"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput n_out "Position normal to path"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput d_n_out "Derivative of normal position"
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput pp_out "Path direction"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  parameter Integer nu=2 "Number of units";
  parameter Integer na=3 "Max number of axles per unit";
  parameter Modelica.SIunits.Position x_offset=0 "Longitudinal offset";
  parameter Modelica.SIunits.Position y_offset=0 "Lateral offset";
  parameter Modelica.SIunits.Position s0=0 "Initial position along path";
  parameter Modelica.SIunits.Position n0=0 "Initial position normal to path";
  Components.Curve90deg curve90deg(radius=radius, s_start=s_start)
    annotation (Placement(transformation(extent={{26,68},{6,88}})));
  parameter Modelica.SIunits.Length radius=12.5 "Curve radius";
  parameter Modelica.SIunits.Position s_start=50
    "Position along path when curve starts";
equation
  connect(motionOffset.vx_offset, pathPosition.vx)
    annotation (Line(points={{-60,42},{-44,42},{-44,40},{-22,40}}, color={0,0,127}));
  connect(motionOffset.vy_offset, pathPosition.vy)
    annotation (Line(points={{-60,30},{-44,30},{-44,34},{-22,34}}, color={0,0,127}));
  connect(vx, motionOffset.vx)
    annotation (Line(points={{-117,63},{-90,63},{-90,42},{-84,42}}, color={0,0,127}));
  connect(vy, motionOffset.vy) annotation (Line(points={{-118,14},{-98,14},{-98,18},{-96,
          18},{-96,36},{-84,36}}, color={0,0,127}));
  connect(wz, motionOffset.wz) annotation (Line(points={{-118,-28},{-88,-28},{-88,30},{
          -84,30}}, color={0,0,127}));
  connect(pz, pathPosition.pz) annotation (Line(points={{-118,-74},{-118,-74},{-34,-74},
          {-34,28},{-22,28}}, color={0,0,127}));
  connect(pp_out, pp_out)
    annotation (Line(points={{110,-60},{110,-60}}, color={0,0,127}));
  connect(pathPosition.s_out, s_out)
    annotation (Line(points={{1,41},{50,41},{50,60},{110,60}}, color={0,0,127}));
  connect(pathPosition.n_out, n_out)
    annotation (Line(points={{1,37},{72,37},{72,20},{110,20}}, color={0,0,127}));
  connect(pathPosition.d_n_out, d_n_out)
    annotation (Line(points={{1,31},{52,31},{52,-20},{110,-20}}, color={0,0,127}));
  connect(pathPosition.pp_out, pp_out)
    annotation (Line(points={{1,27},{36,27},{36,-60},{110,-60}}, color={0,0,127}));
  connect(curve90deg.y, pathPosition.c)
    annotation (Line(points={{5,78},{5,78},{-10,78},{-10,46}},  color={0,0,127}));
  connect(pathPosition.s_out, curve90deg.u)
    annotation (Line(points={{1,41},{40,41},{40,78},{28,78}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PathPosition90degCurve;
