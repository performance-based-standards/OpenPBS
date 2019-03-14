within OpenPBS.Manoeuvres.Blocks;
block MaxFrictionUsage_New
  "Calculate the maximum friction used for the front axle and all driven axles (max value)."
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer nu=2 "Number of rows in input matrix";
  parameter Integer na=3 "Numnber of colums in input matrix";
  parameter Boolean[nu,na] driven=[false,true,true;false,false,false]
                                                  "Driven axles"
                                                                annotation(Evaluate=true);

  Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

protected
  parameter Integer[nu,na] matrix=booleanToInteger(driven);
equation
  y1=friction_usage[1, 1]; //assuming axle [1,1] is steered and only steered
  y2=max(friction_usage .* matrix);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MaxFrictionUsage_New;
