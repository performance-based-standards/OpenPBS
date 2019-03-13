within OpenPBS.Manoeuvres.Blocks.PBS;
block FrictionDemand
  extends Modelica.Blocks.Interfaces.BlockIcon;
  MaxFrictionUsage maxFrictionUsage(nu=nu, na=na,
    driven=driven)
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  parameter Integer nu=2;
  parameter Integer na=3;
  Modelica.Blocks.Interfaces.RealOutput FDST
    annotation (Placement(transformation(extent={{100,30},{140,70}})));
  Modelica.Blocks.Interfaces.RealOutput FDDT
    annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
  parameter Real max_friction=0.8 "Maximum allowed friction";
  Modelica.Blocks.Math.Gain steer_gain(k=1/max_friction)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Blocks.Math.Gain drive_gain(k=1/max_friction)
    annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
  parameter Boolean driven[nu,na]=[false,true,true; false,false,false]
    "Driven axles";
  RollingMax rollingMax1_1(n1=1, n2=1)
    annotation (Placement(transformation(extent={{34,40},{54,60}})));
  RollingMax rollingMax1_2(n1=1, n2=1)
    annotation (Placement(transformation(extent={{34,-60},{54,-40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001)
    annotation (Placement(transformation(extent={{0,2},{16,18}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.001)
    annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
equation
  connect(maxFrictionUsage.friction_usage, friction_usage)
    annotation (Line(points={{-64,0},{-120,0}}, color={0,0,127}));
  connect(steer_gain.y, FDST)
    annotation (Line(points={{91,50},{120,50}}, color={0,0,127}));
  connect(drive_gain.y, FDDT)
    annotation (Line(points={{91,-50},{120,-50}}, color={0,0,127}));
  connect(steer_gain.u, rollingMax1_1.y)
    annotation (Line(points={{68,50},{55,50}}, color={0,0,127}));
  connect(drive_gain.u, rollingMax1_2.y)
    annotation (Line(points={{68,-50},{55,-50}}, color={0,0,127}));
  connect(maxFrictionUsage.y1, firstOrder.u)
    annotation (Line(points={{-18,10},{-1.6,10}}, color={0,0,127}));
  connect(firstOrder.y, rollingMax1_1.u[1, 1]) annotation (Line(points={{16.8,
          10},{24,10},{24,50},{32,50}}, color={0,0,127}));
  connect(firstOrder1.u, maxFrictionUsage.y2) annotation (Line(points={{-1.6,
          -10},{-9.8,-10},{-18,-10}}, color={0,0,127}));
  connect(firstOrder1.y, rollingMax1_2.u[1, 1]) annotation (Line(points={{16.8,
          -10},{24,-10},{24,-50},{32,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FrictionDemand;
