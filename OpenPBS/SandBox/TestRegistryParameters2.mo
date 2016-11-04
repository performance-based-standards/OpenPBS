within OpenPBS.SandBox;
model TestRegistryParameters2

  Modelica.Blocks.Sources.Constant const(k=5)
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  VehicleModels.DirectionInput vehicle(
    paramSet=paramSet,
    nu=2,
    na=3)
    annotation (Placement(transformation(extent={{20,-38},{40,-18}})));
  parameter       Parameters.Base.VehicleModel
                                       paramSet=
    OpenPBS.Parameters.Functions.ModelParametersFromSpecification(
      nu=2,
      na=3,
      specification={
      tractorParam,
      semitrailerParam})
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  parameter Parameters.Variants.FromRegistry.SLX394 tractorParam
    annotation (Placement(transformation(extent={{-138,64},{-118,84}})));
  parameter Parameters.Variants.FromRegistry.CNC134 semitrailerParam
    annotation (Placement(transformation(extent={{-138,42},{-118,62}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
equation
  connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-33},{10,-33},{10,
          -62},{10,-60},{-59,-60}},  color={0,0,127}));
  connect(const1.y, vehicle.front_direction_in) annotation (Line(points={{-39,-10},
          {-10,-10},{-10,-23},{18,-23}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TestRegistryParameters2;
