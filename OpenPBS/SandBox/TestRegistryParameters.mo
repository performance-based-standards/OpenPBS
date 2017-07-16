within OpenPBS.SandBox;
model TestRegistryParameters
  extends Manoeuvres.LowSpeedCurve(
    final paramSet=OpenPBS.Vehicles.Functions.ModelParametersFromSpecification(
        nu=2,
        na=3,
        specification={tractorParam,semitrailerParam}),
    vehicle(paramSet=paramSet),
    nu=2,
    na=3);
  parameter Vehicles.Vehicles.FromRegistry.SLX394 tractorParam
    annotation (Placement(transformation(extent={{-138,64},{-118,84}})));
  parameter Vehicles.Vehicles.FromRegistry.CNC134 semitrailerParam
    annotation (Placement(transformation(extent={{-138,42},{-118,62}})));
end TestRegistryParameters;
