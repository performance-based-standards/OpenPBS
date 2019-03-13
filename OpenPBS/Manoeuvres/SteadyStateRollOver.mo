within OpenPBS.Manoeuvres;
model SteadyStateRollOver
  import OpenPBS;
  extends Modelica.Blocks.Icons.Block;
  replaceable parameter OpenPBS.VehicleParameters.Vehicles.Adouble6x4 paramSet
    constrainedby OpenPBS.VehicleParameters.Vehicles.Adouble6x4
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput SRT
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteadyStateRollOver;
