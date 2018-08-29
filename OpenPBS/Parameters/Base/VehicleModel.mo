within OpenPBS.Parameters.Base;
record VehicleModel "Base vehicle model parameter set"
  extends Modelica.Icons.Record;
  parameter Integer nu=2 "Number of units";
  parameter Integer na=3 "Max number of axles per unit";

  parameter Modelica.SIunits.Position[nu,na] L=[1,1,1;1,1,1]
    "All axle longitudinal positions rearward from first axle of each unit";
  parameter Modelica.SIunits.Length[nu,na] w=[1,1,1;1,1,1]
    "Track width per axle";
  parameter Modelica.SIunits.Position[nu] X={-1,-1}
    "C.g. longitudinal position relative first axle";
  parameter Modelica.SIunits.Position[nu] cgh={1,1}
    "C.g. height over ground";
  parameter Modelica.SIunits.Position[nu] A={1,1}
    "Front coupling position relative first axle";
  parameter Modelica.SIunits.Length[nu] B={-2,-2}
    "Rear coupling position relative first axle";

  parameter Boolean[nu,na] driven=[false,true,false;false,false,false]
    "True for each driven axle";

  parameter Real[nu,na] Cc=5.5*[1,1,1;1,1,1]
    "Cornering coefficient per axle";

  parameter Modelica.SIunits.Mass[nu] m={10000,10000} "Masses";
  parameter Modelica.SIunits.Inertia[nu] I={10000,10000} "Inertias";

  parameter Integer[nu,na] axlegroups=[1,2,2;1,1,1];

  parameter Modelica.SIunits.Length[nu] FOH={1,1}
                                            "Front hang define from the front axle of each unit.";
  parameter Modelica.SIunits.Length[nu] ROH={-5,-5}
                                            "Rear hang define from the front axle of each unit.";
  parameter Real drag_coefficient=0.5;
  parameter Modelica.SIunits.Area frontal_area=4;
  parameter Real rolling_resistance_coefficient=0.0004 "Rolling resistance force as a function of vertical force";
  parameter Modelica.SIunits.Power max_engine_power=550000;
  parameter Modelica.SIunits.Force max_thrust_force_vx0=175000;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>

</html>"));


  // Beräknade indata
// Axel/boggitryck i kopplad kombination - Beräknas i simulering, VerticalForces
// Kopplingstryck - Beräknas i simulering, VerticalForces
// Tyngdpunktshöjd - cgh
// Resulterande tyngdpunktshöjd - ?
// Spårvidd - w
// Resulterande spårvidd - ?
// Kopplingsavstånd EU till främre koppling
// Kopplingsavstånd EU till bakre koppling
// Tröghetsmoment - I (yaw)
// Tyngdpunktsposition rel. axel 1 - X
// Främre kopplingsposition rel. axel 1 - A
// Bakre kopplingsposition rel.axel 1 - B
// Axelposition rel. axel 1 - L
// Modifieringsfaktor

end VehicleModel;
