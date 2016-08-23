within OpenPBS.SandBox;
model TestPathPosition2

  Components.PathPosition pathPosition
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vehicle.vehicle.vy[1] +
        vehicle.vehicle.Lcog[1, 1]*vehicle.vehicle.wz[1])
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=vehicle.vehicle.pz[1])
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  VehicleModels.DirectionInput vehicle
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Curve90deg2 curve90deg(s_change=0.1)
    annotation (Placement(transformation(extent={{64,70},{44,90}})));

  Modelica.Blocks.Sources.RealExpression realExpression3(y=vehicle.vehicle.d_vy[
        1] + vehicle.vehicle.d_wz[1]*vehicle.vehicle.Lcog[1, 1] + vehicle.vehicle.vx[
        1]*vehicle.vehicle.wz[1])
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
equation
  connect(realExpression.y, pathPosition.vy)
    annotation (Line(points={{-39,50},{-39,50},{-12,50}}, color={0,0,127}));
  connect(realExpression1.y, pathPosition.pz) annotation (Line(points={{-39,30},
          {-30,30},{-30,44},{-12,44}}, color={0,0,127}));
  connect(const.y, vehicle.vx_in) annotation (Line(points={{-79,-20},{-40,-20},{
          -40,-5},{38,-5}},  color={0,0,127}));
  connect(pathPosition.vx, const.y) annotation (Line(points={{-12,56},{-16,56},{
          -20,56},{-20,-20},{-79,-20}}, color={0,0,127}));
  connect(pathPosition.s_out, curve90deg.u) annotation (Line(points={{11,57},
          {80,57},{80,80},{66,80}},
                                color={0,0,127}));
  connect(curve90deg.y, pathPosition.c) annotation (Line(points={{43,80},{
          22,80},{0,80},{0,62}}, color={0,0,127}));
  connect(curve90deg.y, vehicle.curvature_in) annotation (Line(points={{43,
          80},{-18,80},{-82,80},{-82,5},{38,5}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestPathPosition2;
