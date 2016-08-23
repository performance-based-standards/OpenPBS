within OpenPBS.SandBox;
model TestPathPosition

  Components.PathPosition pathPosition
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vehicle.vehicle.vy[1] +
        vehicle.vehicle.Lcog[1, 1]*vehicle.vehicle.wz[1])
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=vehicle.vehicle.pz[1])
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  AccInput vehicle
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{-46,0},{-34,12}})));
  Components.Curve90deg curve90deg
    annotation (Placement(transformation(extent={{40,70},{20,90}})));

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
  connect(const.y, multiProduct.u[1]) annotation (Line(points={{-79,-20},{
          -60,-20},{-60,8.8},{-46,8.8}},
                                color={0,0,127}));
  connect(const.y, multiProduct.u[2]) annotation (Line(points={{-79,-20},{
          -60,-20},{-60,6},{-46,6}},
                            color={0,0,127}));
  connect(pathPosition.vx, const.y) annotation (Line(points={{-12,56},{-16,56},{
          -20,56},{-20,-20},{-79,-20}}, color={0,0,127}));
  connect(curve90deg.y, pathPosition.c)
    annotation (Line(points={{19,80},{0,80},{0,62}}, color={0,0,127}));
  connect(pathPosition.s_out, curve90deg.u) annotation (Line(points={{11,57},
          {56,57},{56,80},{42,80}},
                                color={0,0,127}));
  connect(curve90deg.y, multiProduct.u[3]) annotation (Line(points={{19,80},
          {-80,80},{-80,3.2},{-46,3.2}},
                                      color={0,0,127}));
  connect(vehicle.a_y_first, multiProduct.y) annotation (Line(points={{38,5},
          {3,5},{3,6},{-32.98,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestPathPosition;
