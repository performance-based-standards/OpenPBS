within OpenPBS.Manoeuvres.Blocks;
block InstantMax "Find max value of n signals"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer n1=1 "Number of rows in input matrix";
  parameter Integer n2=1 "Number of columns in input matrix";

  Modelica.Blocks.Interfaces.RealInput u[n1,n2]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  y = max(u);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InstantMax;
