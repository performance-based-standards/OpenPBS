within OpenPBS.PBS;
model LowSpeedCurve
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu=4 "Number of units";
  parameter Integer na=3 "Number of axles (max across all units)";

  Modelica.Blocks.Interfaces.RealOutput LSSP "Low speed swept path"
    annotation (Placement(transformation(extent={{100,56},{120,76}})));
  Components.PathPosition pathPositionRight[nu,na](n0=0, s0=
        vehicle.vehicle.rx0) "Path position of right side wheels"
    annotation (Placement(transformation(extent={{-24,-24},{-4,-4}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));
  Components.Curve90deg curve90deg[nu,na](radius=curve_radius,
      s_start=curve_start)
    annotation (Placement(transformation(extent={{10,4},{-10,24}})));
  VehicleModels.DirectionInput vehicle(paramSet=paramSet,
    nu=nu,
    na=na)
    annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
  replaceable parameter       Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3[nu,
    na](y=matrix(vehicle.vehicle.vy)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression4[nu,
    na](y=matrix(vehicle.vehicle.pz)*ones(1, na))
    annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
  Modelica.Blocks.Sources.RealExpression realExpression5[nu,
    na](y=matrix(vehicle.vehicle.vx)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
  Components.PathPosition pathPositionLeft[nu,na](s0=vehicle.vehicle.rx0,
      n0=paramSet.w) "Path position of left side wheels"
    annotation (Placement(transformation(extent={{-20,52},{0,72}})));
  Components.Curve90deg curve90deg1[nu,na](radius=
        curve_radius, s_start=curve_start)
    annotation (Placement(transformation(extent={{20,76},{0,96}})));
  Components.MotionOffset motionOffsetLeft[nu,na](x_offset=
        vehicle.vehicle.Lcog, y_offset=paramSet.w/2)
    "Position and velocity of left wheels on all axles"
    annotation (Placement(transformation(extent={{-60,56},{-40,76}})));
  Modelica.Blocks.Sources.RealExpression realExpression7[nu,
    na](y=matrix(vehicle.vehicle.wz)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Components.MotionOffset motionOffsetRight[nu,na](x_offset=
        vehicle.vehicle.Lcog, y_offset=-paramSet.w/2)
    "Position and velocity of right wheels on all axles"
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Blocks.RollingMax rollingMax(n1=nu, n2=na)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{60,56},{80,76}})));
  parameter Modelica.SIunits.Length curve_radius=12.5;
  parameter Modelica.SIunits.Position curve_start=50
    "Distance along path when curve starts";
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-34},{120,-14}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThan(threshold=
        curve_start + curve_radius*Modelica.Constants.pi/2)
    annotation (Placement(transformation(extent={{40,-24},{60,-4}})));
  Blocks.RollingMax rollingMax1(
                               n1=nu, n2=na)
    annotation (Placement(transformation(extent={{36,6},{46,16}})));
  Modelica.Blocks.Math.Gain gain[nu,na](k=-1) annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={26,6})));
  Modelica.Blocks.Logical.LessThreshold lessThan(threshold=0.05)
    annotation (Placement(transformation(extent={{56,6},{66,16}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Components.PathPosition90degCurve overHangCalculatorRigth[nu,2](
    radius=curve_radius,
    s_start=curve_start,
    s0=vehicle.vehicle.rx0_oh,
    nu=paramSet.nu,
    na=paramSet.na,
    x_offset=vehicle.vehicle.Lcog_oh,
    y_offset=-paramSet.w/2,
    n0=0) "Calculate all overhang positions on the rigth side."
    annotation (Placement(transformation(extent={{24,-88},{44,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression9[nu,2](y=matrix(vehicle.vehicle.vx)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-70},{
            -80,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression10[
                                                         nu,2](y=matrix(vehicle.vehicle.vy)
        *ones(1, 2))
    annotation (Placement(transformation(extent={{-100,-82},{-80,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression11[
                                                         nu,2](y=matrix(vehicle.vehicle.wz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-94},{
            -80,-74}})));
  Modelica.Blocks.Sources.RealExpression realExpression12[
                                                         nu,2](y=matrix(vehicle.vehicle.pz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-106},{
            -80,-86}})));
  Blocks.RollingMax     rollingMax4(
                                   n1=nu, n2=1)
    "Maximum of all front rigth offsets for each unit"
    annotation (Placement(transformation(extent={{62,-64},{82,-44}})));
  Blocks.RollingMax     rollingMax5(
                                   n1=nu, n2=1)
    "Maximum of all rear rigth offsets for each unit"
    annotation (Placement(transformation(extent={{66,-98},{86,-78}})));
  Modelica.Blocks.Math.Gain gain1[nu,1](k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={52,-62})));
  Modelica.Blocks.Math.Gain gain2[nu,1](k=-1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={54,-84})));
  Modelica.Blocks.Interfaces.RealOutput FS "Front Swing(rigth side)"
    annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
  Modelica.Blocks.Interfaces.RealOutput RS "Rear swing(rigth side)"
    annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
equation
  connect(pathPositionRight.s_out, curve90deg.u) annotation (Line(points={{-3,-7},
          {18,-7},{18,14},{12,14}},        color={0,0,127}));
  connect(curve90deg.y,pathPositionRight. c) annotation (Line(points={{-11,14},
          {-11,14},{-14,14},{-14,-2}},        color={0,0,127}));
  connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-47},{10,-47},{
          10,-46},{10,-38},{-59,-38}},
                                     color={0,0,127}));
  connect(pathPositionLeft.s_out, curve90deg1.u) annotation (Line(points={{1,69},{
          26,69},{26,86},{22,86}},             color={0,0,127}));
  connect(curve90deg1.y,pathPositionLeft. c) annotation (Line(points={{-1,86},{
          -1,86},{-10,86},{-10,74}},               color={0,0,127}));
  connect(realExpression4.y,pathPositionLeft. pz) annotation (Line(points={{-39,36},
          {-30,36},{-30,56},{-22,56}},              color={0,0,127}));
  connect(realExpression5.y, motionOffsetLeft.vx) annotation (Line(points={{-79,62},
          {-68,62},{-68,72},{-62,72}},     color={0,0,127}));
  connect(realExpression3.y, motionOffsetLeft.vy)
    annotation (Line(points={{-79,46},{-70,46},{-70,66},{-62,66}},
                                                 color={0,0,127}));
  connect(realExpression7.y, motionOffsetLeft.wz) annotation (Line(points={{-79,30},
          {-72,30},{-72,60},{-62,60}},     color={0,0,127}));
  connect(motionOffsetLeft.vx_offset, pathPositionLeft.vx) annotation (Line(
        points={{-38,72},{-34,72},{-34,68},{-30,68},{-22,68}},
        color={0,0,127}));
  connect(motionOffsetRight.vy_offset, pathPositionRight.vy) annotation (Line(
        points={{-38,-16},{-34,-16},{-34,-14},{-26,-14}}, color={0,0,127}));
  connect(motionOffsetRight.vx_offset, pathPositionRight.vx) annotation (Line(
        points={{-38,-4},{-34,-4},{-34,-8},{-26,-8}},     color={0,0,127}));
  connect(pathPositionLeft.n_out, rollingMax.u) annotation (Line(points={{1,65},{
          32,65},{32,66},{58,66}},             color={0,0,127}));
  connect(rollingMax.y, LSSP) annotation (Line(points={{81,66},{81,66},{110,66}},
                          color={0,0,127}));
  connect(pathPositionRight[1, 1].pp_out, vehicle.front_direction_in)
    annotation (Line(points={{-3,-21},{10,-21},{10,-28},{10,-37},{18,-37}},
        color={0,0,127}));
  connect(pathPositionRight.pz, realExpression4.y) annotation (Line(points={{-26,-20},
          {-30,-20},{-30,36},{-39,36}},      color={0,0,127}));
  connect(motionOffsetLeft.vy_offset, pathPositionLeft.vy) annotation (Line(
        points={{-38,60},{-34,60},{-34,62},{-22,62}}, color={0,0,127}));
  connect(motionOffsetRight.vx, realExpression5.y) annotation (Line(points={{-62,-4},
          {-68,-4},{-68,62},{-79,62}},       color={0,0,127}));
  connect(motionOffsetRight.vy, realExpression3.y) annotation (Line(points={{-62,-10},
          {-70,-10},{-70,46},{-79,46}},      color={0,0,127}));
  connect(motionOffsetRight.wz, realExpression7.y) annotation (Line(points={{-62,-16},
          {-66,-16},{-72,-16},{-72,30},{-79,30}},      color={0,0,127}));
  connect(greaterThan.u, pathPositionRight[end, 1].s_out) annotation (Line(
        points={{38,-14},{8,-14},{8,-7},{-3,-7}},   color={0,0,127}));
  connect(gain.y, rollingMax1.u)
    annotation (Line(points={{26,10.4},{26,11},{35,11}}, color={0,0,127}));
  connect(gain.u, pathPositionRight.n_out) annotation (Line(points={{26,1.2},{
          26,-11},{-3,-11}},         color={0,0,127}));
  connect(rollingMax1.y, lessThan.u) annotation (Line(points={{46.5,11},{46.5,
          11},{55,11}},      color={0,0,127}));
  connect(lessThan.y, and1.u1) annotation (Line(points={{66.5,11},{68,11},{68,4},
          {68,0},{72,0}},                    color={255,0,255}));
  connect(greaterThan.y, and1.u2) annotation (Line(points={{61,-14},{66,-14},{
          66,-8},{72,-8}},    color={255,0,255}));
  connect(and1.y, valid) annotation (Line(points={{95,0},{98,0},{98,-24},{110,
          -24}},      color={255,0,255}));
  connect(realExpression9.y,overHangCalculatorRigth. vx) annotation (Line(points={{-79,-60},
          {6,-60},{6,-71.7},{22.3,-71.7}},        color={0,0,127}));
  connect(realExpression10.y,overHangCalculatorRigth. vy) annotation (Line(points={{-79,-72},
          {-6,-72},{-6,-76.6},{22.2,-76.6}},        color={0,0,127}));
  connect(realExpression11.y,overHangCalculatorRigth. wz) annotation (Line(points={{-79,-84},
          {-30,-84},{-22,-84},{-22,-80.8},{22.2,-80.8}},                color={0,0,127}));
  connect(realExpression12.y,overHangCalculatorRigth. pz) annotation (Line(points={{-79,-96},
          {-58,-96},{-24,-96},{-24,-88},{-14,-88},{-14,-85.4},{22.2,-85.4}},
                   color={0,0,127}));
  connect(rollingMax4.y, FS) annotation (Line(points={{83,-54},{86,-54},{86,-62},
          {110,-62}}, color={0,0,127}));
  connect(rollingMax5.y, RS)
    annotation (Line(points={{87,-88},{87,-82},{110,-82}}, color={0,0,127}));
  connect(gain1.y,rollingMax4. u) annotation (Line(points={{52,-57.6},{56,-57.6},
          {56,-54},{60,-54}}, color={0,0,127}));
  connect(overHangCalculatorRigth[:, 2].n_out,gain2 [:, 1].u)
    annotation (Line(points={{45,-76},{54,-76},{54,-79.2}}, color={0,0,127}));
  connect(gain2.y,rollingMax5. u)
    annotation (Line(points={{54,-88.4},{54,-88},{64,-88}},    color={0,0,127}));
  connect(gain1[:, 1].u,overHangCalculatorRigth [:, 1].n_out)
    annotation (Line(points={{52,-66.8},{52,-76},{45,-76}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">LSSP, Low Speed Swept Path</span></b></p>
<p><b><span style=\"font-size: 12pt;\">Manoeuvre: </span></b></p>
<ul>
<li>Speed=0+</li>
<li>Friction=High</li>
<li>Unit loading=Max load, evenly distributed</li>
<li>guide: R=12.5 m, 90 deg </li>
</ul>
<p><b><span style=\"font-size: 12pt;\">Measure: </span></b></p>
<p>LSSP=Max perpendicular distance from guide to follower. </p>
<p>Relevant alternatives and selection: </p>
<ul>
<li>guide=FAO, follower=worst of all other [HCTinSWE and OpenPBS] </li>
<li>guide=FBO, follower=worst of all other [approx. Australia] </li>
</ul>
<p><i><b><span style=\"font-size: 12pt; color: #ff0000;\">Present known issues with selected definition: </span></b></i></p>
<ul>
<li><i><span style=\"color: #ff0000;\">Low or high mu? What value if hi (1?), and if low (0.35?)</span></i></li>
<li><i><span style=\"color: #ff0000;\">HCTinSWE and OpenPBS does not punish long overhang, e.g. city buses or &ldquo;nose-built&rdquo; cabins </span></i></li>
<li><i><span style=\"color: #ff0000;\">OpenPBS presently does not saturate axle forces to mu_max*F_z. </span></i></li>
</ul>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/LSSP_Description.png\"/></p>
<p>￼</p>
</html>"));
end LowSpeedCurve;
