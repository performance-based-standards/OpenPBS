within OpenPBS.VehicleParameters.Functions;
function ModelParametersFromSpecification
  input Integer nu "Number of units";
  input Integer na "Number of axles (max over combination)";
  input OpenPBS.Parameters.Base.UnitSpecification specification[nu];

  input Real[nu] weight_percentage=ones(nu)
    "Amount of payload max mass that is loaded";
  input Real[nu] height_percentage=ones(nu)
    "Amount of payload max height that is used";
  output OpenPBS.Parameters.Base.VehicleModel modelparameters;

protected
  Modelica.SIunits.Length load_height[nu];
  Modelica.SIunits.Mass m_payload;
  Modelica.SIunits.Mass m_total;
  Modelica.SIunits.Position cgx_payload;
  Modelica.SIunits.Position cgz_payload;
  Modelica.SIunits.Position cgx_total;
  Modelica.SIunits.Position cgz_total;
  Modelica.SIunits.Inertia Izz_payload;
  Modelica.SIunits.Inertia Ixx_payload;
  Modelica.SIunits.Inertia Iyy_payload;
  Modelica.SIunits.Inertia Izz_total;
  Modelica.SIunits.Inertia Ixx_total;
  Modelica.SIunits.Inertia Iyy_total;
algorithm
  // Code to find model parameters from vehicle specification
  modelparameters.nu := nu;
  modelparameters.na := na;

  for i in 1:nu loop
    modelparameters.L[i, :] := axlePositions(specification[i].n_axles,
      specification[i].wheelbase);
    modelparameters.w[i, 1:specification[i].n_axles] := specification[i].axle_width;
    modelparameters.X[i] := specification[i].cg_x_location_unloaded;

    load_height[i] := specification[i].max_load_height - specification[i].chassis_height;

    (m_payload,cgx_payload,cgz_payload,Izz_payload,Ixx_payload,Iyy_payload) :=
      payloadMassProperties(
      specification[i].max_payload_mass,
      specification[i].max_load_height,
      specification[i].load_space_length,
      specification[i].width,
      1,
      weight_percentage[i],
      height_percentage[i]);

    (m_total,cgx_total,cgz_total,Izz_total,Ixx_total,Iyy_payload) :=
      totalMassProperties(
      specification[i].kerb_mass,
      specification[i].max_payload_mass,
      specification[i].cg_x_location_unloaded,
      specification[i].cg_z_location_unloaded,
      cgx_payload,
      cgz_payload,
      specification[i].yaw_inertia_unloaded,
      specification[i].roll_inertia_unloaded,
      specification[i].pitch_inertia_unloaded,
      Izz_payload,
      Ixx_payload,
      Iyy_payload);
    modelparameters.m[i] := m_total;
    modelparameters.I[i] := Izz_total;
    modelparameters.cgh[i] := cgz_total;
    modelparameters.X[i] := cgx_total;

    modelparameters.axlegroups[i, :] := (specification[i].axle_groups);

  end for;
  //   modelparameters.na:=size(modelparameters.L, 2);
  annotation (Documentation(info="<html>
<p>erergAbce</p>
</html>"));
end ModelParametersFromSpecification;
