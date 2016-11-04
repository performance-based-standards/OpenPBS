within OpenPBS.PBS;
model LSSP

  Modelica.Blocks.Interfaces.RealOutput LSSP "Low speed swept path"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Components.PathPosition pathPositionRight[paramSet.nu,paramSet.na](n0=0, s0=
        vehicle.vehicle.rx0) "Path position of right side wheels"
    annotation (Placement(transformation(extent={{-24,-40},{-4,-20}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Components.Curve90deg curve90deg[paramSet.nu,paramSet.na](radius=curve_radius,
      s_start=curve_start)
    annotation (Placement(transformation(extent={{10,-12},{-10,8}})));
  VehicleModels.DirectionInput vehicle(
    paramSet=paramSet,
    nu=paramSet.nu,
    na=paramSet.na)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  inner replaceable parameter Parameters.Base.VehicleModel
                                       paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3[vehicle.vehicle.nu,
    vehicle.vehicle.na](y=matrix(vehicle.vehicle.vy)*ones(1, vehicle.vehicle.na))
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression4[vehicle.vehicle.nu,
    vehicle.vehicle.na](y=matrix(vehicle.vehicle.pz)*ones(1, vehicle.vehicle.na))
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression5[vehicle.vehicle.nu,
    vehicle.vehicle.na](y=matrix(vehicle.vehicle.vx)*ones(1, paramSet.na))
    annotation (Placement(transformation(extent={{-100,56},{-80,76}})));
  Components.PathPosition pathPositionLeft[paramSet.nu,paramSet.na](s0=vehicle.vehicle.rx0,
      n0=paramSet.w) "Path position of left side wheels"
    annotation (Placement(transformation(extent={{-20,36},{0,56}})));
  Components.Curve90deg curve90deg1[paramSet.nu,paramSet.na](radius=
        curve_radius, s_start=curve_start)
    annotation (Placement(transformation(extent={{20,60},{0,80}})));
  Components.MotionOffset motionOffsetLeft[paramSet.nu,paramSet.na](x_offset=
        vehicle.vehicle.Lcog, y_offset=paramSet.w/2)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression7[vehicle.vehicle.nu,
    vehicle.vehicle.na](y=matrix(vehicle.vehicle.wz)*ones(1, vehicle.vehicle.na))
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Components.MotionOffset motionOffsetRight[paramSet.nu,paramSet.na](x_offset=
        vehicle.vehicle.Lcog, y_offset=-paramSet.w/2)
    annotation (Placement(transformation(extent={{-60,-36},{-40,-16}})));
  Blocks.RollingMax rollingMax(n1=vehicle.vehicle.nu, n2=vehicle.vehicle.na)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  parameter Modelica.SIunits.Length curve_radius=12.5;
  parameter Modelica.SIunits.Position curve_start=50
    "Distance along path when curve starts";
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThan(threshold=
        curve_start + curve_radius*Modelica.Constants.pi/2)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Blocks.RollingMax rollingMax1(
                               n1=vehicle.vehicle.nu, n2=vehicle.vehicle.na)
    annotation (Placement(transformation(extent={{38,-10},{48,0}})));
  Modelica.Blocks.Math.Gain gain[paramSet.nu,paramSet.na](k=-1) annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={26,-10})));
  Modelica.Blocks.Logical.LessThreshold lessThan(threshold=0.05)
    annotation (Placement(transformation(extent={{54,-10},{64,0}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{74,-26},{94,-6}})));
equation
  connect(pathPositionRight.s_out, curve90deg.u) annotation (Line(points={{-3,-23},
          {18,-23},{18,-2},{12,-2}},       color={0,0,127}));
  connect(curve90deg.y,pathPositionRight. c) annotation (Line(points={{-11,-2},
          {-11,-2},{-14,-2},{-14,-18}},       color={0,0,127}));
  connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-65},{10,-65},
          {10,-62},{10,-60},{-59,-60}},
                                     color={0,0,127}));
  connect(pathPositionLeft.s_out, curve90deg1.u) annotation (Line(points={{1,53},{
          26,53},{26,70},{22,70}},             color={0,0,127}));
  connect(curve90deg1.y,pathPositionLeft. c) annotation (Line(points={{-1,70},
          {-1,70},{-10,70},{-10,70},{-10,58}},     color={0,0,127}));
  connect(realExpression4.y,pathPositionLeft. pz) annotation (Line(points={{-39,20},
          {-30,20},{-30,40},{-22,40}},              color={0,0,127}));
  connect(realExpression5.y, motionOffsetLeft.vx) annotation (Line(points={{-79,
          66},{-68,66},{-68,56},{-62,56}}, color={0,0,127}));
  connect(realExpression3.y, motionOffsetLeft.vy)
    annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
  connect(realExpression7.y, motionOffsetLeft.wz) annotation (Line(points={{-79,
          34},{-72,34},{-72,44},{-62,44}}, color={0,0,127}));
  connect(motionOffsetLeft.vx_offset, pathPositionLeft.vx) annotation (Line(
        points={{-38,56},{-34,56},{-34,52},{-30,52},{-30,52},{-22,52},{-22,52}},
        color={0,0,127}));
  connect(motionOffsetRight.vy_offset, pathPositionRight.vy) annotation (Line(
        points={{-38,-32},{-34,-32},{-34,-30},{-26,-30}}, color={0,0,127}));
  connect(motionOffsetRight.vx_offset, pathPositionRight.vx) annotation (Line(
        points={{-38,-20},{-34,-20},{-34,-24},{-26,-24}}, color={0,0,127}));
  connect(pathPositionLeft.n_out, rollingMax.u) annotation (Line(points={{1,49},{
          32,49},{32,50},{58,50}},             color={0,0,127}));
  connect(rollingMax.y, LSSP) annotation (Line(points={{81,50},{81,50},{110,
          50}},           color={0,0,127}));
  connect(pathPositionRight[1, 1].pp_out, vehicle.front_direction_in)
    annotation (Line(points={{-3,-37},{10,-37},{10,-44},{10,-55},{18,-55}},
        color={0,0,127}));
  connect(pathPositionRight.pz, realExpression4.y) annotation (Line(points={{-26,-36},
          {-30,-36},{-30,20},{-39,20}},      color={0,0,127}));
  connect(motionOffsetLeft.vy_offset, pathPositionLeft.vy) annotation (Line(
        points={{-38,44},{-34,44},{-34,46},{-22,46}}, color={0,0,127}));
  connect(motionOffsetRight.vx, realExpression5.y) annotation (Line(points={{-62,
          -20},{-68,-20},{-68,66},{-79,66}}, color={0,0,127}));
  connect(motionOffsetRight.vy, realExpression3.y) annotation (Line(points={{-62,
          -26},{-70,-26},{-70,50},{-79,50}}, color={0,0,127}));
  connect(motionOffsetRight.wz, realExpression7.y) annotation (Line(points={{-62,
          -32},{-66,-32},{-72,-32},{-72,34},{-79,34}}, color={0,0,127}));
  connect(greaterThan.u, pathPositionRight[end, 1].s_out) annotation (Line(
        points={{38,-30},{8,-30},{8,-23},{-3,-23}}, color={0,0,127}));
  connect(gain.y, rollingMax1.u)
    annotation (Line(points={{26,-5.6},{26,-5},{37,-5}}, color={0,0,127}));
  connect(gain.u, pathPositionRight.n_out) annotation (Line(points={{26,
          -14.8},{26,-27},{-3,-27}}, color={0,0,127}));
  connect(rollingMax1.y, lessThan.u) annotation (Line(points={{48.5,-5},{
          48.5,-5},{53,-5}}, color={0,0,127}));
  connect(lessThan.y, and1.u1) annotation (Line(points={{64.5,-5},{66,-5},{
          66,-4},{68,-4},{68,-16},{72,-16}}, color={255,0,255}));
  connect(greaterThan.y, and1.u2) annotation (Line(points={{61,-30},{66,-30},
          {66,-24},{72,-24}}, color={255,0,255}));
  connect(and1.y, valid) annotation (Line(points={{95,-16},{98,-16},{98,-40},
          {110,-40}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LSSP;
