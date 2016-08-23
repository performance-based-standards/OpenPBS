within OpenPBS.PBS.Blocks.PBS;
block RearWardAmplification
  parameter Integer nu=2 "Number of units";

  Modelica.SIunits.AngularVelocity peak_first(start=0);
  Modelica.SIunits.AngularVelocity peak_last(start=0);

  Modelica.Blocks.Interfaces.RealOutput RWA "Rearward amplification"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));

  Modelica.Blocks.Interfaces.RealInput motion[nu]
    "Lateral acceleration or yaw rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if RWA was successfully calculated"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
equation
  RWA=if peak_first > 0 then peak_last/peak_first else -1.0;

  when abs(motion[1]) > pre(peak_first) and der(abs(motion[1])) < 0 and abs(
      motion[1]) > 0.05 then
    peak_first = abs(motion[1]);
  end when;

  when abs(motion[end]) > pre(peak_last) and der(abs(motion[end])) < 0 and abs(
      motion[end]) > 0.05 then
    peak_last = abs(motion[end]);
  end when;

  valid=if peak_first > 0 and peak_last > 0 then true else false;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RearWardAmplification;
