within OpenPBS.SandBox;
model TestLowSpeedCurveFhRh "Test low speed curve with front and rear overhang"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu=4 "Number of units";
  parameter Integer na=3 "Number of axles (max across all units)";

  Modelica.Blocks.Interfaces.RealOutput LSSP "Low speed swept path"
    annotation (Placement(transformation(extent={{100,16},{120,36}})));
  Components.PathPosition pathPositionRight[nu,na](n0=0, s0=
        vehicle.vehicle.rx0) "Path position of right side wheels"
    annotation (Placement(transformation(extent={{-24,-40},{-4,-20}})));
  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Components.Curve90deg curve90deg[nu,na](radius=curve_radius,
      s_start=curve_start)
    annotation (Placement(transformation(extent={{10,-12},{-10,8}})));
  VehicleModels.DirectionInput vehicle(paramSet=paramSet,
    nu=nu,
    na=na)
    annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
  replaceable parameter       Parameters.Vehicles.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression3[nu,
    na](y=matrix(vehicle.vehicle.vy)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression4[nu,
    na](y=matrix(vehicle.vehicle.pz)*ones(1, na))
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression5[nu,
    na](y=matrix(vehicle.vehicle.vx)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,56},{-80,76}})));
  Components.PathPosition pathPositionLeft[nu,na](s0=vehicle.vehicle.rx0,
      n0=paramSet.w) "Path position of left side wheels"
    annotation (Placement(transformation(extent={{-20,34},{0,54}})));
  Components.Curve90deg curve90deg1[nu,na](radius=
        curve_radius, s_start=curve_start)
    annotation (Placement(transformation(extent={{18,60},{-2,80}})));
  Components.MotionOffset motionOffsetLeft[nu,na](x_offset=
        vehicle.vehicle.Lcog, y_offset=paramSet.w/2)
    "Position and velocity of left wheels on all axles"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression7[nu,
    na](y=matrix(vehicle.vehicle.wz)*ones(1, na))
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Components.MotionOffset motionOffsetRight[nu,na](x_offset=
        vehicle.vehicle.Lcog, y_offset=-paramSet.w/2)
    "Position and velocity of right wheels on all axles"
    annotation (Placement(transformation(extent={{-60,-36},{-40,-16}})));
  Manouvres.Blocks.RollingMax rollingMax(n1=nu, n2=na)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{62,16},{82,36}})));
  parameter Modelica.SIunits.Length curve_radius=12.5;
  parameter Modelica.SIunits.Position curve_start=50
    "Distance along path when curve starts";
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThan(threshold=
        curve_start + curve_radius*Modelica.Constants.pi/2)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Manouvres.Blocks.RollingMax rollingMax1(n1=nu, n2=na)
    annotation (Placement(transformation(extent={{36,-10},{46,0}})));
  Modelica.Blocks.Math.Gain gain[nu,na](k=-1) annotation (
     Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={26,-10})));
  Modelica.Blocks.Logical.LessThreshold lessThan(threshold=0.05)
    annotation (Placement(transformation(extent={{56,-10},{66,0}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{74,-26},{94,-6}})));
  Components.PathPosition90degCurve overHangCalculatorLeft[nu,2](
    radius=curve_radius,
    s_start=curve_start,
    n0=paramSet.w,
    y_offset=paramSet.w/2,
    s0=vehicle.vehicle.rx0_oh,
    nu=paramSet.nu,
    na=paramSet.na,
    x_offset=vehicle.vehicle.Lcog_oh)
    annotation (Placement(transformation(extent={{32,88},{52,108}})));
  Modelica.Blocks.Sources.RealExpression realExpression1[nu,2](y=matrix(vehicle.vehicle.vx)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-24,98},{-4,118}})));
  Modelica.Blocks.Sources.RealExpression realExpression2[nu,2](y=matrix(vehicle.vehicle.vy)
        *ones(1, 2))
    annotation (Placement(transformation(extent={{-48,92},{-28,112}})));
  Modelica.Blocks.Sources.RealExpression realExpression6[nu,2](y=matrix(vehicle.vehicle.wz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-48,80},{-28,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression8[nu,2](y=matrix(vehicle.vehicle.pz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-74,80},{-54,100}})));
  Manouvres.Blocks.RollingMax rollingMax2(n1=nu, n2=1)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{70,96},{90,116}})));
  Modelica.Blocks.Interfaces.RealOutput FS "Low speed swept path"
    annotation (Placement(transformation(extent={{96,84},{116,104}})));
  Manouvres.Blocks.RollingMax rollingMax3(n1=nu, n2=1)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{70,66},{90,86}})));
  Modelica.Blocks.Interfaces.RealOutput RS "Low speed swept path"
    annotation (Placement(transformation(extent={{100,66},{120,86}})));
  Components.PathPosition90degCurve overHangCalculatorLeft1[nu,2](
    radius=curve_radius,
    s_start=curve_start,
    s0=vehicle.vehicle.rx0_oh,
    nu=paramSet.nu,
    na=paramSet.na,
    x_offset=vehicle.vehicle.Lcog_oh,
    y_offset=-paramSet.w/2,
    n0=0) annotation (Placement(transformation(extent={{14,-100},{34,-80}})));
  Modelica.Blocks.Sources.RealExpression realExpression9[nu,2](y=matrix(vehicle.vehicle.vx)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-42,-90},{-22,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression10[
                                                         nu,2](y=matrix(vehicle.vehicle.vy)
        *ones(1, 2))
    annotation (Placement(transformation(extent={{-66,-96},{-46,-76}})));
  Modelica.Blocks.Sources.RealExpression realExpression11[
                                                         nu,2](y=matrix(vehicle.vehicle.wz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-66,-108},{-46,-88}})));
  Modelica.Blocks.Sources.RealExpression realExpression12[
                                                         nu,2](y=matrix(vehicle.vehicle.pz)
        *ones(1, 2)) annotation (Placement(transformation(extent={{-92,-108},{-72,-88}})));
  Manouvres.Blocks.RollingMax rollingMax4(n1=nu, n2=1)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{52,-92},{72,-72}})));
  Manouvres.Blocks.RollingMax rollingMax5(n1=nu, n2=1)
    "Maximum of all left wheel offsets"
    annotation (Placement(transformation(extent={{52,-122},{72,-102}})));
  Modelica.Blocks.Interfaces.RealOutput FSRigth "Low speed swept path"
    annotation (Placement(transformation(extent={{90,-84},{110,-64}})));
  Modelica.Blocks.Interfaces.RealOutput RSRigth "Low speed swept path"
    annotation (Placement(transformation(extent={{90,-104},{110,-84}})));
  Modelica.Blocks.Math.Gain gain1[nu,1](k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={42,-74})));
  Modelica.Blocks.Math.Gain gain2[nu,1](k=-1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=90,
        origin={44,-102})));
equation
  connect(pathPositionRight.s_out, curve90deg.u) annotation (Line(points={{-3,-23},
          {18,-23},{18,-2},{12,-2}},       color={0,0,127}));
  connect(curve90deg.y,pathPositionRight. c) annotation (Line(points={{-11,-2},
          {-11,-2},{-14,-2},{-14,-18}},       color={0,0,127}));
  connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-63},{10,-63},{
          10,-62},{10,-60},{-59,-60}},
                                     color={0,0,127}));
  connect(pathPositionLeft.s_out, curve90deg1.u) annotation (Line(points={{1,51},{26,51},
          {26,70},{20,70}},                    color={0,0,127}));
  connect(curve90deg1.y,pathPositionLeft. c) annotation (Line(points={{-3,70},{-3,70},{
          -10,70},{-10,56}},                       color={0,0,127}));
  connect(realExpression4.y,pathPositionLeft. pz) annotation (Line(points={{-39,20},{-30,
          20},{-30,38},{-22,38}},                   color={0,0,127}));
  connect(realExpression5.y, motionOffsetLeft.vx) annotation (Line(points={{-79,66},{-68,
          66},{-68,56},{-62,56}},          color={0,0,127}));
  connect(realExpression3.y, motionOffsetLeft.vy)
    annotation (Line(points={{-79,50},{-62,50}}, color={0,0,127}));
  connect(realExpression7.y, motionOffsetLeft.wz) annotation (Line(points={{-79,
          34},{-72,34},{-72,44},{-62,44}}, color={0,0,127}));
  connect(motionOffsetLeft.vx_offset, pathPositionLeft.vx) annotation (Line(
        points={{-38,56},{-34,56},{-34,52},{-22,52},{-22,50}},
        color={0,0,127}));
  connect(motionOffsetRight.vy_offset, pathPositionRight.vy) annotation (Line(
        points={{-38,-32},{-34,-32},{-34,-30},{-26,-30}}, color={0,0,127}));
  connect(motionOffsetRight.vx_offset, pathPositionRight.vx) annotation (Line(
        points={{-38,-20},{-34,-20},{-34,-24},{-26,-24}}, color={0,0,127}));
  connect(pathPositionLeft.n_out, rollingMax.u) annotation (Line(points={{1,47},{32,47},
          {32,26},{60,26}},                    color={0,0,127}));
  connect(rollingMax.y, LSSP) annotation (Line(points={{83,26},{83,26},{110,26}},
                          color={0,0,127}));
  connect(pathPositionRight[1, 1].pp_out, vehicle.front_direction_in)
    annotation (Line(points={{-3,-37},{10,-37},{10,-44},{10,-53},{18,-53}},
        color={0,0,127}));
  connect(pathPositionRight.pz, realExpression4.y) annotation (Line(points={{-26,-36},
          {-30,-36},{-30,20},{-39,20}},      color={0,0,127}));
  connect(motionOffsetLeft.vy_offset, pathPositionLeft.vy) annotation (Line(
        points={{-38,44},{-34,44},{-22,44}},          color={0,0,127}));
  connect(motionOffsetRight.vx, realExpression5.y) annotation (Line(points={{-62,-20},{
          -68,-20},{-68,66},{-79,66}},       color={0,0,127}));
  connect(motionOffsetRight.vy, realExpression3.y) annotation (Line(points={{-62,
          -26},{-70,-26},{-70,50},{-79,50}}, color={0,0,127}));
  connect(motionOffsetRight.wz, realExpression7.y) annotation (Line(points={{-62,
          -32},{-66,-32},{-72,-32},{-72,34},{-79,34}}, color={0,0,127}));
  connect(greaterThan.u, pathPositionRight[end, 1].s_out) annotation (Line(
        points={{38,-30},{8,-30},{8,-23},{-3,-23}}, color={0,0,127}));
  connect(gain.y, rollingMax1.u)
    annotation (Line(points={{26,-5.6},{26,-5},{35,-5}}, color={0,0,127}));
  connect(gain.u, pathPositionRight.n_out) annotation (Line(points={{26,
          -14.8},{26,-27},{-3,-27}}, color={0,0,127}));
  connect(rollingMax1.y, lessThan.u) annotation (Line(points={{46.5,-5},{46.5,
          -5},{55,-5}},      color={0,0,127}));
  connect(lessThan.y, and1.u1) annotation (Line(points={{66.5,-5},{68,-5},{68,
          -12},{68,-16},{72,-16}},           color={255,0,255}));
  connect(greaterThan.y, and1.u2) annotation (Line(points={{61,-30},{66,-30},
          {66,-24},{72,-24}}, color={255,0,255}));
  connect(and1.y, valid) annotation (Line(points={{95,-16},{98,-16},{98,-40},
          {110,-40}}, color={255,0,255}));
  connect(realExpression1.y, overHangCalculatorLeft.vx)
    annotation (Line(points={{-3,108},{14,108},{14,104.3},{30.3,104.3}},
                                                                    color={0,0,127}));
  connect(realExpression2.y, overHangCalculatorLeft.vy)
    annotation (Line(points={{-27,102},{2,102},{2,99.4},{30.2,99.4}},
                                                                    color={0,0,127}));
  connect(realExpression6.y, overHangCalculatorLeft.wz) annotation (Line(points={{-27,90},
          {-22,90},{-22,92},{-14,92},{-14,95.2},{30.2,95.2}}, color={0,0,127}));
  connect(realExpression8.y, overHangCalculatorLeft.pz) annotation (Line(points={{-53,90},
          {-50,90},{-50,80},{-16,80},{-16,88},{-6,88},{-6,90.6},{30.2,90.6}}, color={0,
          0,127}));
  connect(rollingMax2.y,FS)
    annotation (Line(points={{91,106},{94,106},{94,94},{106,94}},
                                                                color={0,0,127}));
  connect(overHangCalculatorLeft[:, 1].n_out, rollingMax2.u[:, rollingMax2.n2]) annotation (Line(
        points={{53,100},{58,100},{58,102},{58,106},{68,106}},
                                                          color={0,0,127}));
  connect(rollingMax3.y, RS)
    annotation (Line(points={{91,76},{110,76}},          color={0,0,127}));
  connect(overHangCalculatorLeft[:, 2].n_out, rollingMax3.u[:, 1])
    annotation (Line(points={{53,100},{58,100},{58,76},{68,76}},
                                                               color={0,0,127}));
  connect(realExpression9.y, overHangCalculatorLeft1.vx) annotation (Line(points={{-21,
          -80},{-4,-80},{-4,-83.7},{12.3,-83.7}}, color={0,0,127}));
  connect(realExpression10.y, overHangCalculatorLeft1.vy) annotation (Line(points={{-45,
          -86},{-16,-86},{-16,-88.6},{12.2,-88.6}}, color={0,0,127}));
  connect(realExpression11.y, overHangCalculatorLeft1.wz) annotation (Line(points={{-45,
          -98},{-40,-98},{-40,-96},{-32,-96},{-32,-92.8},{12.2,-92.8}}, color={0,0,127}));
  connect(realExpression12.y, overHangCalculatorLeft1.pz) annotation (Line(points={{-71,
          -98},{-68,-98},{-68,-108},{-34,-108},{-34,-100},{-24,-100},{-24,-97.4},{12.2,
          -97.4}}, color={0,0,127}));
  connect(rollingMax4.y, FSRigth)
    annotation (Line(points={{73,-82},{76,-82},{76,-74},{100,-74}}, color={0,0,127}));
  connect(rollingMax5.y, RSRigth)
    annotation (Line(points={{73,-112},{73,-94},{100,-94}}, color={0,0,127}));
  connect(gain1.y, rollingMax4.u) annotation (Line(points={{42,-69.6},{46,-69.6},
          {46,-70},{50,-70},{50,-82}},
                              color={0,0,127}));
  connect(overHangCalculatorLeft1[:, 2].n_out, gain2[:, 1].u)
    annotation (Line(points={{35,-88},{44,-88},{44,-97.2}}, color={0,0,127}));
  connect(gain2.y, rollingMax5.u)
    annotation (Line(points={{44,-106.4},{44,-112},{50,-112}}, color={0,0,127}));
  connect(gain1[:, 1].u, overHangCalculatorLeft1[:, 1].n_out)
    annotation (Line(points={{42,-78.8},{42,-88},{35,-88}}, color={0,0,127}));
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
end TestLowSpeedCurveFhRh;
