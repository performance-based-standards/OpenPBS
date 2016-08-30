within OpenPBS.Parameters.Base;
record UnitSpecification
  "Specification data, typically from bilregistret"
  extends Modelica.Icons.Record;

  /*--- DATA FROM BILREGISTRET ---*/
  // parameter ??? "Reg nummer";
  parameter Integer  n_axles "Antal axlar";
  parameter Integer   n_wheels "Antal hjul";

  parameter Modelica.SIunits.Mass max_payload_mass "Tillåten vikt";
  parameter Modelica.SIunits.Length coupling_distance_EU
    "Kopplingsavstånd EU";
  parameter Modelica.SIunits.Length coupling_distance_front
    "Avstånd mellan kopplingar";

  parameter Modelica.SIunits.Length rear_overhang "Bakre överhäng";

  parameter Modelica.SIunits.Length wheelbase[n_axles]
    "Distance to the next rearward axle";

  parameter Real tyre_dimension1[n_wheels]
    "First number in tyre dimesion, tyre width in mm";
  parameter Real tyre_dimension2[n_wheels]
    "Second number in tyre dimension, aspect ratio, tyre height relative to width, in percent";
  parameter Real tyre_dimension3[n_wheels]
    "Third number in tyre dimension, rim diameter, in inches";

  //parameter Modelica.SIunits.Length tyre_dimension[n_wheels] "Däcksdimension";
  parameter Modelica.SIunits.Length length "Fordonslängd";
  parameter Modelica.SIunits.Length height "Fordonshöjd";
  parameter Modelica.SIunits.Length width "Fordonsbredd";
  parameter Modelica.SIunits.Mass kerb_mass
    "Tjänstevikt inkl påbyggnad";
  parameter Real load_index "Lastindex";
  parameter Modelica.SIunits.Power max_engine_power "Max engine power";

  /* --- DATA FROM OTHER SOURCES --- */
  parameter Modelica.SIunits.Position chassis_height
    "Height where load space starts/lower edge of load space";
  parameter Modelica.SIunits.Length max_load_height
    "Max height of load space above ground";
  parameter Modelica.SIunits.Length load_space_length
    "Length of load space";
  parameter Modelica.SIunits.Length load_space_position
    "Front end of load space";
  parameter Modelica.SIunits.Inertia yaw_inertia_unloaded
    "Yaw inertia of unloaded vehicle";
  parameter Modelica.SIunits.Inertia pitch_inertia_unloaded
    "Pitch inertia of unloaded vehicle";
  parameter Modelica.SIunits.Inertia roll_inertia_unloaded
    "Roll inertia of unloaded vehicle";
  parameter Modelica.SIunits.Position cg_x_location_unloaded
    "Longitudinal c.g. location of unloaded vehicle, relative first axle";
  parameter Modelica.SIunits.Position cg_z_location_unloaded
    "C.g. height of unloaded vehicle, relative to ground";

  parameter Modelica.SIunits.Length front_overhang "Främre överhäng";

  // Tire data
  parameter Real cornering_coefficient=5.5
    "Cornering coefficient: C_alpha/Fz";

  // Axle data
  parameter Integer n_wheels_per_axle[n_axles]
    "Number of wheels per axle";
  parameter Modelica.SIunits.Length axle_width[n_axles]
    "Axle width per axle (outer wheel ends)";
  parameter Integer axle_groups[n_axles]
    "Axle group assignment for each axle";
  parameter Real load_distribution[n_axles]
    "Load distribution in each axle group";
  parameter Modelica.SIunits.Force nominal_axle_load[n_axles]
    "Nominal axle load";

  // Powertrain data
  parameter Modelica.SIunits.Force max_thrust_vx0
    "Max thrust force at zero vehicle speed";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/vehiclespec.png\"/></p>
</html>"));
end UnitSpecification;
