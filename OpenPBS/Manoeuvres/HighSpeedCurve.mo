within OpenPBS.Manoeuvres;
model HighSpeedCurve
  import OpenPBS;
  extends Modelica.Blocks.Icons.Block;
  replaceable parameter OpenPBS.VehicleParameters.Vehicles.Adouble6x4 paramSet
    constrainedby OpenPBS.VehicleParameters.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Integer nu=4;
  parameter Integer na=3;
  parameter Modelica.SIunits.Length curve_radius=350
    "Radius of steady-state curve (at front axle)";
  parameter Modelica.SIunits.Velocity velocity=15 "Velocity reference";
  Modelica.Blocks.Sources.Constant velocitySource(k=velocity)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Sources.Constant curvature(k=1/curve_radius)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  VehicleModels.CurvatureInput vehicle(
    paramSet=paramSet,
    nu=nu,
    na=na) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Modelica.Blocks.Math.Division division[nu,na]
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Sources.Constant const[nu,na](each k=1)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));

  Modelica.Blocks.Sources.Constant const1[
                                         nu,na](each k=curve_radius)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Blocks.Math.Add add[nu,na](k2=-1)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Blocks.InstantMax instantMax(n1=nu, n2=na)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealOutput HSSO
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
equation
  connect(vehicle.curvature_in, curvature.y) annotation (Line(points={{-51,26},{
          -52,26},{-52,26},{-50,26},{-50,26},{-64,26},{-64,30},{-79,30}},
                                                 color={0,0,127}));
  connect(vehicle.vx_in, velocitySource.y) annotation (Line(points={{-51,14},{-64,
          14},{-64,-30},{-79,-30}}, color={0,0,127}));
  connect(division.u2, vehicle.curvature_out)
    annotation (Line(points={{-12,14},{-8,14},{-29,14}},
                                                       color={0,0,127}));
  connect(const.y, division.u1)
    annotation (Line(points={{-29,50},{-20,50},{-20,26},{-12,26}},
                                                             color={0,0,127}));
  connect(division.y, add.u1)
    annotation (Line(points={{11,20},{18,20},{18,6},{28,6}}, color={0,0,127}));
  connect(const1.y, add.u2) annotation (Line(points={{11,-20},{18,-20},{18,-6},{
          28,-6}}, color={0,0,127}));
  connect(add.y, instantMax.u)
    annotation (Line(points={{51,0},{54.5,0},{58,0}}, color={0,0,127}));
  connect(instantMax.y, HSSO)
    annotation (Line(points={{81,0},{96,0},{96,60},{110,60}},
                                              color={0,0,127}));
  connect(booleanConstant.y, valid)
    annotation (Line(points={{81,-60},{110,-60}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighSpeedCurve;
