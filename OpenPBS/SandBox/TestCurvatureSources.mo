within OpenPBS.SandBox;
model TestCurvatureSources
  Components.Curve90deg curve90deg
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Curve90deg2 curve90deg2_1
    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(clock.y, curve90deg.u) annotation (Line(points={{-39,0},{-26,0},{
          -26,30},{-12,30}}, color={0,0,127}));
  connect(curve90deg2_1.u, clock.y) annotation (Line(points={{-12,-30},{-26,
          -30},{-26,0},{-39,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestCurvatureSources;
