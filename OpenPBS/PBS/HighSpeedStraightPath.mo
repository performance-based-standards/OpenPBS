within OpenPBS.PBS;
model HighSpeedStraightPath
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nu=paramSet.nu;
  parameter Integer na=paramSet.na;
  parameter Modelica.SIunits.Velocity velocity=15 "Reference velocity";
  replaceable parameter       Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel                annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  VehicleModels.SingleTrack vehicle(paramSet=paramSet,
    mode=1,
    phi=0.17453292519943)
    annotation (Placement(transformation(extent={{30,2},{10,22}})));

  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-10,-2},{40,22}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=velocity)
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  Modelica.Blocks.Continuous.Der der2
    annotation (Placement(transformation(extent={{-38,-30},{-58,-10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-96,2},{-76,22}})));
  Modelica.Blocks.Interfaces.RealOutput rearSlack
    annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  Modelica.Blocks.Sources.RealExpression absolutValueRearSlack(y=sqrt(vehicle.ry_out[
        nu, na]^2))
    annotation (Placement(transformation(extent={{56,-8},{76,12}})));
equation
  connect(vehicle.delta_in,inverseBlockConstraints. y2)
    annotation (Line(points={{32,18},{36,18},{36,10},{36.25,10}},
                                                           color={0,0,127}));
  connect(velocitySource.y,vehicle. vx_in) annotation (Line(points={{31,-30},{44,
          -30},{44,6},{32,6}},   color={0,0,127}));
  connect(der1.u,vehicle. ry_out[1, 1]) annotation (Line(points={{-8,-20},{4,-20},
          {4,4},{9,4}},              color={0,0,127}));
  connect(der2.u,der1. y) annotation (Line(points={{-36,-20},{-31,-20}},
                 color={0,0,127}));
  connect(der2.y,inverseBlockConstraints. u2) annotation (Line(points={{-59,-20},
          {-64,-20},{-64,6},{-5,6},{-5,10}},       color={0,0,127}));
  connect(const.y, inverseBlockConstraints.u1) annotation (Line(points={{-75,12},
          {-44,12},{-44,10},{-12.5,10}}, color={0,0,127}));
  connect(absolutValueRearSlack.y, rearSlack)
    annotation (Line(points={{77,2},{96,2},{110,2}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-36,60},{34,38}},
          lineColor={28,108,200},
          textString="Mode=1
Hence the model should be simulated until
no transient behavior is seen.
For deafult values more than 10 s")}));
end HighSpeedStraightPath;
