within OpenPBS.Manoeuvres;
model SteadyStateRollOver
  import OpenPBS;
  extends Modelica.Blocks.Icons.Block;
  replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
    constrainedby OpenPBS.Vehicles.Vehicles.Adouble6x4
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteadyStateRollOver;
