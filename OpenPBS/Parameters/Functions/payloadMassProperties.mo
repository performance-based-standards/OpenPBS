within OpenPBS.Parameters.Functions;
function payloadMassProperties
  "Payload mass properties from load size and distribution"
  input Modelica.SIunits.Mass max_mass=30000 "Max allowed mass";
  input Modelica.SIunits.Length load_height=3;
  input Modelica.SIunits.Length load_length=10;
  input Modelica.SIunits.Length load_width=2.5;
  input Integer distribution=1    annotation(choices(choice=1
        "Rectangular",                                                       choice=2
        "Triangular"));
  input Real weight_percentage=1.0;
  input Real height_percentage=1.0;

  output Modelica.SIunits.Mass m "Total mass of load";
  output Modelica.SIunits.Position cgx
    "C.g. X location relative to front edge of load";
  output Modelica.SIunits.Position cgz
    "C.g. Z location relative to bottom of load";
  output Modelica.SIunits.Inertia Izz "Yaw inertia of load around c.g.";
  output Modelica.SIunits.Inertia Ixx "Roll inertia of load around c.g.";
  output Modelica.SIunits.Inertia Iyy "Pitch inertia of load around c.g.";
algorithm
  m :=weight_percentage*max_mass;

  if distribution==1 then
    // Rectangular load
    cgx :=load_length/2;
    cgz :=load_height*height_percentage/2;

    Izz :=m/12*(load_length^2 + load_width^2);
    Ixx :=m/12*((load_height*height_percentage)^2 + load_width^2);
    Iyy :=m/12*((load_height*height_percentage)^2 + load_length^2);
  else
    // Triangular load
  end if;

  annotation (Documentation(info="<html>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/payload.png\"/></p>
</html>"));
end payloadMassProperties;
