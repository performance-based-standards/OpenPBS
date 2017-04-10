within OpenPBS.PBS;
model SteadyStateRollOver
  extends Modelica.Blocks.Icons.Block;
  replaceable parameter       Parameters.Vehicles.Adouble6x4
                                       paramSet constrainedby
    Parameters.Vehicles.Adouble6x4                    annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SteadyStateRollOver;
