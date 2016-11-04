within OpenPBS.PBS;
model HighSpeedCurve
  extends Modelica.Blocks.Icons.Block;
  replaceable parameter       Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Variants.Adouble6x4              annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=10/3.6)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-26,18},{22,42}})));
  VehicleModels.SingleTrack vehicle(paramSet=paramSet, mode=3)
    annotation (Placement(transformation(extent={{16,-26},{-4,-6}})));
  Modelica.Blocks.Sources.Constant radius(k=1/15)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Blocks.Curvature curvature(
    nu=paramSet.nu,
    na=paramSet.na,
    Lcog=vehicle.Lcog)
    annotation (Placement(transformation(extent={{-20,-20},{-40,0}})));
equation
  connect(inverseBlockConstraints.y2, vehicle.delta_in) annotation (Line(points=
         {{18.4,30},{10,30},{10,14},{30,14},{30,-10},{18,-10}}, color={0,0,127}));
  connect(vehicle.vx_in, velocitySource.y) annotation (Line(points={{18,-22},{
          24,-22},{24,-30},{-79,-30}}, color={0,0,127}));
  connect(inverseBlockConstraints.u1, radius.y)
    annotation (Line(points={{-28.4,30},{-54,30},{-79,30}}, color={0,0,127}));
  connect(vehicle.vx_out, curvature.vx) annotation (Line(points={{-5,-8},{-10,
          -8},{-10,-3},{-18,-3}}, color={0,0,127}));
  connect(vehicle.vy_out, curvature.vy) annotation (Line(points={{-5,-11},{
          -10.5,-11},{-10.5,-10},{-18,-10}}, color={0,0,127}));
  connect(vehicle.wz_out, curvature.wz) annotation (Line(points={{-5,-14.2},{
          -10.5,-14.2},{-10.5,-17},{-18,-17}}, color={0,0,127}));
  connect(curvature.y[1, 1], inverseBlockConstraints.u2) annotation (Line(
        points={{-41,-10},{-54,-10},{-54,10},{-16,10},{-16,30},{-21.2,30}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighSpeedCurve;
