within OpenPBS.SandBox;
model TestPathPosition3

  Components.PathPosition pathPosition(s0=0, n0=0)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=vehicle.vy[1] +
        vehicle.Lcog[1, 1]*vehicle.wz[1])
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=vehicle.pz[1])
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  VehicleModels.SingleTrack
           vehicle(mode=3)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Components.Curve90deg curve90deg
    annotation (Placement(transformation(extent={{64,70},{44,90}})));

  Modelica.Blocks.Math.Add3 add(
                               k1=-100, k2=-100)
    annotation (Placement(transformation(extent={{42,10},{62,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=vehicle.pz[1] -
        pathPosition.pp)
    annotation (Placement(transformation(extent={{-4,0},{16,20}})));
  inner VehicleParameters.Vehicles.Adouble6x4 paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(realExpression.y, pathPosition.vy)
    annotation (Line(points={{-39,50},{-39,50},{-12,50}}, color={0,0,127}));
  connect(realExpression1.y, pathPosition.pz) annotation (Line(points={{-39,30},
          {-30,30},{-30,44},{-12,44}}, color={0,0,127}));
  connect(const.y, vehicle.vx_in) annotation (Line(points={{-79,-20},{-20,
          -20},{-20,-6},{78,-6}},
                             color={0,0,127}));
  connect(pathPosition.vx, const.y) annotation (Line(points={{-12,56},{-16,56},{
          -20,56},{-20,-20},{-79,-20}}, color={0,0,127}));
  connect(pathPosition.s_out, curve90deg.u) annotation (Line(points={{11,57},
          {80,57},{80,80},{66,80}},
                                color={0,0,127}));
  connect(curve90deg.y, pathPosition.c) annotation (Line(points={{43,80},{
          22,80},{0,80},{0,62}}, color={0,0,127}));
  connect(add.u1, pathPosition.n_out) annotation (Line(points={{40,28},{30,
          28},{30,53},{11,53}}, color={0,0,127}));
  connect(add.u2, pathPosition.d_n_out) annotation (Line(points={{40,20},{
          34,20},{34,16},{22,16},{22,47},{11,47}}, color={0,0,127}));
  connect(add.y, vehicle.delta_in) annotation (Line(points={{63,20},{70,20},
          {70,6},{78,6}}, color={0,0,127}));
  connect(realExpression2.y, add.u3) annotation (Line(points={{17,10},{28,
          10},{28,12},{40,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestPathPosition3;
