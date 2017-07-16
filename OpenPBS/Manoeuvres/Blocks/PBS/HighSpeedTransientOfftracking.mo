within OpenPBS.Manoeuvres.Blocks.PBS;
block HighSpeedTransientOfftracking
  extends Modelica.Blocks.Icons.Block;
  parameter Integer nu=4;
  parameter Integer na=3;
  parameter Modelica.SIunits.Length width=4.5 "width of lane change maneuver";

  RollingMax rollingMax(n1=nu, n2=na)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealInput ry[nu,na]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput HSTO
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{42,-16},{62,4}})));
  Modelica.Blocks.Sources.Constant const(k=width)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(rollingMax.u, ry)
    annotation (Line(points={{-12,0},{-120,0},{-120,0}}, color={0,0,127}));
  connect(add.u1, rollingMax.y)
    annotation (Line(points={{40,0},{11,0}},        color={0,0,127}));
  connect(add.y, HSTO) annotation (Line(points={{63,-6},{80,-6},{80,0},{110,0}},
        color={0,0,127}));
  connect(const.y, add.u2) annotation (Line(points={{21,-30},{30,-30},{30,-12},{
          40,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HighSpeedTransientOfftracking;
