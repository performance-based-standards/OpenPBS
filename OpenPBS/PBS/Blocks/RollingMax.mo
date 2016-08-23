within OpenPBS.PBS.Blocks;
block RollingMax "Find max value of n signals during simulation"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer n1=1 "Number of rows in input matrix";
  parameter Integer n2=1 "Number of columns in input matrix";

  Real[n1,n2] umax;
  Modelica.Blocks.Interfaces.RealInput u[n1,n2]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  y = max(umax);

  for i in 1:n1 loop
    for j in 1:n2 loop
      when der(u[i,j])<0 then
        umax[i,j] = max(u[i,j],pre(umax[i,j]));
      end when;
    end for;
  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RollingMax;
