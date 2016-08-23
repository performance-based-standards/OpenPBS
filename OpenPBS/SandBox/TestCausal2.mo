within OpenPBS.SandBox;
model TestCausal2
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  VehicleModels.DirectionInput curvatureInput
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Curve90deg2 curve90deg2_1
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Continuous.Integrator integrator
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
equation
  connect(curvatureInput.vx_in, const.y) annotation (Line(points={{38,-5},{
          -36,-5},{-36,-30},{-59,-30}},  color={0,0,127}));
  connect(curve90deg2_1.u, clock.y) annotation (Line(points={{-62,20},{-66,
          20},{-66,50},{-79,50}}, color={0,0,127}));
  connect(curve90deg2_1.y, integrator.u)
    annotation (Line(points={{-39,20},{-22,20}}, color={0,0,127}));
  connect(integrator.y, curvatureInput.front_direction_in) annotation (Line(
        points={{1,20},{20,20},{20,5},{38,5}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestCausal2;
