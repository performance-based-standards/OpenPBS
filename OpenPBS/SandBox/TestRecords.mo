within OpenPBS.SandBox;
model TestRecords
  parameter Integer nu=2;
  parameter Integer na=3;

  inner parameter OpenPBS.Vehicles.Base.VehicleModel paramSet=
      OpenPBS.Vehicles.Functions.ModelParametersFromSpecification(
      nu=2,
      na=3,
      specification={tractorParam,semitrailerParam})
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter OpenPBS.Vehicles.Vehicles.FromRegistry.SLX394 tractorParam
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  parameter OpenPBS.Vehicles.Vehicles.FromRegistry.CNC134 semitrailerParam
    annotation (Placement(transformation(extent={{-30,80},{-10,100}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestRecords;
