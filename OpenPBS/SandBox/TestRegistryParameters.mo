within OpenPBS.SandBox;
model TestRegistryParameters
  extends PBS.LSSP(final paramSet=
    OpenPBS.Parameters.Functions.ModelParametersFromSpecification(
      nu=2,
      na=3,
      specification={
      tractorParam,
      semitrailerParam}), vehicle(paramSet=paramSet));
  parameter Parameters.Variants.FromRegistry.SLX394 tractorParam
    annotation (Placement(transformation(extent={{-138,64},{-118,84}})));
  parameter Parameters.Variants.FromRegistry.CNC134 semitrailerParam
    annotation (Placement(transformation(extent={{-138,42},{-118,62}})));
end TestRegistryParameters;
