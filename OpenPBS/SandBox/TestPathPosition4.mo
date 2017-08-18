within OpenPBS.SandBox;
model TestPathPosition4

  Components.PathPosition pathPosition(s0=0, n0=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vehicle.vehicle.vy[
        1] + vehicle.vehicle.Lcog[1, 1]*vehicle.vehicle.wz[1])
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=vehicle.vehicle.pz[
        1])
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Components.Curve90deg curve90deg
    annotation (Placement(transformation(extent={{64,70},{44,90}})));

  VehicleModels.DirectionInput vehicle
    annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  inner VehicleParameters.Vehicles.Adouble6x4 paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(realExpression.y, pathPosition.vy)
    annotation (Line(points={{-39,50},{-39,50},{-12,50}}, color={0,0,127}));
  connect(realExpression1.y, pathPosition.pz) annotation (Line(points={{-39,30},
          {-30,30},{-30,44},{-12,44}}, color={0,0,127}));
  connect(pathPosition.vx, const.y) annotation (Line(points={{-12,56},{-16,56},{
          -20,56},{-20,-20},{-79,-20}}, color={0,0,127}));
  connect(pathPosition.s_out, curve90deg.u) annotation (Line(points={{11,57},
          {80,57},{80,80},{66,80}},
                                color={0,0,127}));
  connect(curve90deg.y, pathPosition.c) annotation (Line(points={{43,80},{
          22,80},{0,80},{0,62}}, color={0,0,127}));
  connect(vehicle.vx_in, const.y) annotation (Line(points={{38,-25},{-10,
          -25},{-10,-20},{-79,-20}}, color={0,0,127}));
  connect(pathPosition.pp_out, vehicle.front_direction_in) annotation (Line(
        points={{11,43},{24,43},{24,-15},{38,-15}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestPathPosition4;
