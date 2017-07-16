within OpenPBS.VehicleParameters.Functions;
function totalMassProperties
  "Find total CG of a unit based on chassis and payload mass"
  input Modelica.SIunits.Mass m_chassis;
  input Modelica.SIunits.Mass m_payload;
  input Modelica.SIunits.Position cgx_chassis;
  input Modelica.SIunits.Position cgz_chassis;
  input Modelica.SIunits.Position cgx_payload;
  input Modelica.SIunits.Position cgz_payload;
  input Modelica.SIunits.Inertia Izz_chassis
    "Total yaw inertia of load around c.g.";
  input Modelica.SIunits.Inertia Ixx_chassis
    "Total roll inertia of load around c.g.";
  input Modelica.SIunits.Inertia Iyy_chassis
    "Total pitch inertia of load around c.g.";
  input Modelica.SIunits.Inertia Izz_payload
    "Total yaw inertia of load around c.g.";
  input Modelica.SIunits.Inertia Ixx_payload
    "Total roll inertia of load around c.g.";
  input Modelica.SIunits.Inertia Iyy_payload
    "Total pitch inertia of load around c.g.";

  output Modelica.SIunits.Mass m_total;
  output Modelica.SIunits.Position cgx_total;
  output Modelica.SIunits.Position cgz_total;
  output Modelica.SIunits.Inertia Izz_total
    "Total yaw inertia of load around c.g.";
  output Modelica.SIunits.Inertia Ixx_total
    "Total roll inertia of load around c.g.";
  output Modelica.SIunits.Inertia Iyy_total
    "Total pitch inertia of load around c.g.";
algorithm
  // Code code code

  m_total :=m_chassis + m_payload;

  cgx_total :=(m_chassis*cgx_chassis + m_payload*cgx_payload)/m_total;
  cgz_total :=(m_chassis*cgz_chassis + m_payload*cgz_payload)/m_total;

  Izz_total :=Izz_chassis + Izz_payload + m_chassis*(cgx_chassis - cgx_total)^2 +
    m_payload*(cgx_payload - cgx_payload)^2;
  Ixx_total :=Ixx_chassis + Ixx_payload + m_chassis*(cgz_chassis - cgz_total)^2 +
    m_payload*(cgz_payload - cgz_payload)^2;
  Iyy_total :=Iyy_chassis + Iyy_payload + m_chassis*(cgx_chassis - cgx_total)^2 +
    m_payload*(cgx_payload - cgx_payload)^2;

end totalMassProperties;
