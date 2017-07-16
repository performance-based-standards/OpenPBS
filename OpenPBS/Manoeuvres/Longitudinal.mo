within OpenPBS.Manoeuvres;
model Longitudinal
  import OpenPBS;
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu=paramSet.nu;
  parameter Integer na=paramSet.na;
  replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
    constrainedby OpenPBS.Vehicles.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

  Modelica.Blocks.Interfaces.RealOutput S "Startability"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  parameter Modelica.SIunits.Angle inclination=0.05 "Lateral road inclination";
  Modelica.Blocks.Interfaces.RealOutput G "gradeability"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput AC "Acceleration capability"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  VehicleModels.LongitudinalAccelerationQS startability(
    paramSet=paramSet,
    acceleration_demand=acceleration_demand,
    friction=friction)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  VehicleModels.LongitudinalAccelerationQS gradeability(
    acceleration_demand=0.001,
    paramSet=paramSet,
    vx0=vx_gradeability,
    friction=friction)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  VehicleModels.LongitudinalAcceleration longitudinalAcceleration(
    vx0=0,
    paramSet=paramSet,
    friction=friction)
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  parameter Modelica.SIunits.Acceleration acceleration_demand=0.001
    "Required acceleration for startability and gradeability";
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
        distance_target)
    annotation (Placement(transformation(extent={{-32,-80},{-12,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{38,-40},{58,-20}})));
  parameter Real distance_target=100
    "Distance target for acceleration capability";
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{8,-20},{28,0}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{8,-60},{28,-40}})));
  Modelica.Blocks.Continuous.Integrator derivative
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  parameter Modelica.SIunits.Velocity vx_gradeability=15
    "Longitudinal velocity for gradeability calculation";
  parameter Real friction=1 "Road friction coefficient";
equation
  connect(startability.inclination_out, S) annotation (Line(points={{1,70},{1,
          70},{58,70},{110,70}}, color={0,0,127}));
  connect(gradeability.inclination_out, G) annotation (Line(points={{1,30},{18,
          30},{26,30},{110,30}}, color={0,0,127}));
  connect(greaterThreshold.u, longitudinalAcceleration.s_out) annotation (Line(
        points={{-34,-70},{-44,-70},{-44,-40},{-49,-40}}, color={0,0,127}));
  connect(greaterThreshold.y, valid)
    annotation (Line(points={{-11,-70},{110,-70}}, color={255,0,255}));
  connect(switch1.u2, greaterThreshold.y) annotation (Line(points={{36,-30},{-2,
          -30},{-2,-70},{-11,-70}}, color={255,0,255}));
  connect(const.y, switch1.u1) annotation (Line(points={{29,-10},{32,-10},{32,
          -22},{36,-22}}, color={0,0,127}));
  connect(const1.y, switch1.u3) annotation (Line(points={{29,-50},{32,-50},{32,
          -38},{36,-38}}, color={0,0,127}));
  connect(switch1.y, derivative.u)
    annotation (Line(points={{59,-30},{68,-30}}, color={0,0,127}));
  connect(AC, derivative.y)
    annotation (Line(points={{110,-30},{91,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Longitudinal;
