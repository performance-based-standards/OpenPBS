within OpenPBS.PBS.Blocks;
block Curvature "Curvature at each axle"
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer nu=3 "Number of units";
  parameter Integer na=2 "Max number of axles per unit";

  Modelica.Blocks.Interfaces.RealInput vx[nu] "vx at c.o.g."
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  Modelica.Blocks.Interfaces.RealInput vy[nu] "vy at c.o.g."
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput wz[nu] "wz at c.o.g."
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));

  parameter Modelica.SIunits.Length[nu,na] Lcog
    "Axle positions relative c.g.";

  Modelica.Blocks.Interfaces.RealOutput
             y[nu,na] "Connector of Real output signals" annotation (Placement(
        transformation(extent={{100,-10},{120,10}})));

equation

  for i in 1:nu loop
    for j in 1:na loop
      y[i,j] = wz[i]/sqrt((vy[i]+Lcog[i,j]*wz[i])^2+vx[i]^2);
    end for;
  end for;
     annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Curvature;
