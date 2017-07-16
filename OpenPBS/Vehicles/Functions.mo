within OpenPBS.Vehicles;
package Functions
  extends Modelica.Icons.VariantsPackage;

  function ModelParametersFromSpecification
    input Integer nu "Number of units";
    input Integer na "Number of axles (max over combination)";
    input OpenPBS.Vehicles.Base.UnitSpecification specification[nu];

    input Real[nu] weight_percentage=ones(nu)
      "Amount of payload max mass that is loaded";
    input Real[nu] height_percentage=ones(nu)
      "Amount of payload max height that is used";
    output OpenPBS.Vehicles.Base.VehicleModel modelparameters;

  protected
    Modelica.SIunits.Length load_height[nu];
    Modelica.SIunits.Mass m_payload, m_total;
    Modelica.SIunits.Position cgx_payload, cgz_payload, cgx_total, cgz_total;
    Modelica.SIunits.Inertia Izz_payload, Ixx_payload, Iyy_payload, Izz_total, Ixx_total, Iyy_total;
  algorithm
   // Code to find model parameters from vehicle specification
    modelparameters.nu:=nu;
    modelparameters.na:=na;

    for i in 1:nu loop
      modelparameters.L[i,:] :=axlePositions(specification[i].n_axles,  specification[i].wheelbase);
      modelparameters.w[i,1:specification[i].n_axles] := specification[i].axle_width;
      modelparameters.X[i] := specification[i].cg_x_location_unloaded;

      load_height[i] :=specification[i].max_load_height - specification[i].chassis_height;

      (m_payload, cgx_payload, cgz_payload, Izz_payload, Ixx_payload, Iyy_payload) :=
        payloadMassProperties(specification[i].max_payload_mass, specification[i].max_load_height, specification[i].load_space_length, specification[i].width, 1, weight_percentage[i], height_percentage[i]);

      (m_total,cgx_total,cgz_total,Izz_total,Ixx_total,Iyy_payload) :=totalMassProperties(specification[i].kerb_mass, specification[i].max_payload_mass, specification[i].cg_x_location_unloaded, specification[i].cg_z_location_unloaded, cgx_payload, cgz_payload, specification[i].yaw_inertia_unloaded, specification[i].roll_inertia_unloaded, specification[i].pitch_inertia_unloaded, Izz_payload, Ixx_payload, Iyy_payload);
      modelparameters.m[i] :=m_total;
      modelparameters.I[i] :=Izz_total;
      modelparameters.cgh[i] :=cgz_total;
      modelparameters.X[i] :=cgx_total;

      modelparameters.axlegroups[i,:]:=(specification[i].axle_groups);

    end for;
  //   modelparameters.na:=size(modelparameters.L, 2);
    annotation (Documentation(info="<html>
<p>erergAbce</p>
</html>"));
  end ModelParametersFromSpecification;

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

  function axlePositions "Calculate axle positions relative first axle"
    input Integer na;

    input Modelica.SIunits.Length wheelbase[na];

    output Modelica.SIunits.Position L[na];
  algorithm
    L[1]:=0;
    for i in 2:na loop
      L[i]:=L[i - 1] - wheelbase[i - 1];
    end for;
  end axlePositions;
end Functions;
