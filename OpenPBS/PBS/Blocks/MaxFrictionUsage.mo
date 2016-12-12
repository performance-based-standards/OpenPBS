within OpenPBS.PBS.Blocks;
block FrictionUsageCalculator
  "Calculate the friction used for the front axle and all driven axels(max value)."
  extends Modelica.Blocks.Interfaces.BlockIcon;
  parameter Integer nu=2 "Number of rows in input matrix";
  parameter Integer na=3 "Numnber of colums in input matrix";
  parameter Boolean[nu,na] driven=[false,true,true;false,false,false]
                                                  "Driven axles"
                                                                annotation(Evaluate=true);

  Integer[nu,na] matrix;


  Modelica.Blocks.Interfaces.RealInput frictionUsage[nu,na]
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y1
    annotation (Placement(transformation(extent={{100,46},{122,68}})));
  Modelica.Blocks.Interfaces.RealOutput y2
    annotation (Placement(transformation(extent={{100,-52},{122,-30}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));

equation
  y1=frictionUsage[1,1];
  y2=max(frictionUsage.*matrix);
  for i in 1:nu loop
    for j in 1:na loop
      if driven[i,j] then
        matrix[i,j]=1;
      else
        matrix[i,j]=0;
      end if;
    end for;
  end for;

end FrictionUsageCalculator;
