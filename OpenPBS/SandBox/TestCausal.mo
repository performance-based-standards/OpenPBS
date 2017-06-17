within OpenPBS.SandBox;
model TestCausal

  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Step steerSource(height=0.05, startTime=3)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  VehicleModels.SingleTrack singleTrack(mode=1)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  inner parameter Parameters.Vehicles.Adouble6x4
                                       paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(singleTrack.vx_in, const.y) annotation (Line(points={{-12,44},{
          -30,44},{-30,-30},{-59,-30}}, color={0,0,127}));
  connect(steerSource.y, singleTrack.delta_in) annotation (Line(points={{
          -79,50},{-60,50},{-40,50},{-40,56},{-12,56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestCausal;
