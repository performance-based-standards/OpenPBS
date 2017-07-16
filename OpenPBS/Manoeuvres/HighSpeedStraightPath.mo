within OpenPBS.Manoeuvres;
model HighSpeedStraightPath
  import OpenPBS;
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu=paramSet.nu;
  parameter Integer na=paramSet.na;
  parameter Modelica.SIunits.Velocity velocity=15 "Reference velocity";
  replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
    constrainedby OpenPBS.Vehicles.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  VehicleModels.SingleTrack vehicle(
    paramSet=paramSet,
    inclination=inclination,
    mode=1) annotation (Placement(transformation(extent={{26,0},{6,20}})));

  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-10,-2},{40,22}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=velocity)
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-96,2},{-76,22}})));
  Modelica.Blocks.Interfaces.RealOutput TASP
    "Swept area when driving on constant crossfall"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Modelica.SIunits.Angle inclination=0.05 "Lateral road inclination";
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
equation
  connect(vehicle.delta_in,inverseBlockConstraints. y2)
    annotation (Line(points={{28,16},{36,16},{36,10},{36.25,10}},
                                                           color={0,0,127}));
  connect(velocitySource.y,vehicle. vx_in) annotation (Line(points={{31,-30},{44,
          -30},{44,4},{28,4}},   color={0,0,127}));
  connect(const.y, inverseBlockConstraints.u1) annotation (Line(points={{-75,12},
          {-44,12},{-44,10},{-12.5,10}}, color={0,0,127}));
  connect(vehicle.ry_out[1, 1], inverseBlockConstraints.u2)
    annotation (Line(points={{5,2},{0,2},{0,10},{-5,10}}, color={0,0,127}));
  connect(abs1.y, TASP)
    annotation (Line(points={{85,0},{92,0},{110,0}}, color={0,0,127}));
  connect(abs1.u, vehicle.ry_out[nu, na]) annotation (Line(points={{62,0},{50,0},{
          50,-12},{0,-12},{0,2},{5,2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-36,60},{34,38}},
          lineColor={28,108,200},
          textString="Mode=1
Hence the model should be simulated until
no transient behavior is seen.
For deafult values more than 10 s")}));
end HighSpeedStraightPath;
