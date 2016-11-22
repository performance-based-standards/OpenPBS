within OpenPBS.PBS;
model SingleLaneChange
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Frequency freqHz=0.4 "Frequency of lateral acceleration in ground coordinates";
  parameter Modelica.SIunits.Length width=4.5 "Width of lane change maneuver";
  parameter Modelica.SIunits.Velocity vx=80/3.6 "Longitudinal velocity";

  VehicleModels.SingleTrack vehicle(paramSet=paramSet)
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-20,-12},{30,12}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=80/3.6)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Blocks.SinglePeriodSine singlePeriodSine(
    startTime=5,
    amplitude=freqHz^2*(width*2*Modelica.Constants.pi),
    freqHz=freqHz)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
  Modelica.Blocks.Continuous.Der der2
    annotation (Placement(transformation(extent={{-48,-40},{-68,-20}})));
  replaceable parameter       Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel                annotation (Placement(transformation(extent={{-100,80},
            {-80,100}})));
  Blocks.PBS.RearWardAmplification rearWardAmplification(nu=paramSet.nu)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Blocks.PBS.Damping damping(nu=paramSet.nu, start_time=singlePeriodSine.startTime
         + 1/singlePeriodSine.freqHz)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Interfaces.RealOutput RWA "Rearward amplification"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput YD "Yaw damping"
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if calculations were completed"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Blocks.PBS.HighSpeedTransientOfftracking highSpeedTransientOfftracking(
    nu=paramSet.nu,
    na=paramSet.na,
    width=width)
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  Modelica.Blocks.Interfaces.RealOutput HSTO
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
equation
  connect(vehicle.delta_in,inverseBlockConstraints. y2)
    annotation (Line(points={{22,6},{26,6},{26,0},{26.25,0}},
                                                           color={0,0,127}));
  connect(velocitySource.y,vehicle. vx_in) annotation (Line(points={{21,-40},{34,
          -40},{34,-6},{22,-6}}, color={0,0,127}));
  connect(der1.u,vehicle. ry_out[1, 1]) annotation (Line(points={{-18,-30},{-6,-30},
          {-6,-8},{-1,-8}},          color={0,0,127}));
  connect(der2.u,der1. y) annotation (Line(points={{-46,-30},{-41,-30}},
                 color={0,0,127}));
  connect(der2.y,inverseBlockConstraints. u2) annotation (Line(points={{-69,-30},
          {-74,-30},{-74,-4},{-15,-4},{-15,0}},    color={0,0,127}));
  connect(inverseBlockConstraints.u1,singlePeriodSine. y)
    annotation (Line(points={{-22.5,0},{-79,0}},
                                               color={0,0,127}));
  connect(rearWardAmplification.RWA, RWA) annotation (Line(points={{41,75},{62,75},
          {62,74},{82,74},{82,60},{110,60}}, color={0,0,127}));
  connect(damping.D, YD) annotation (Line(points={{41,35},{80,35},{80,20},{110,20}},
        color={0,0,127}));
  connect(damping.motion, vehicle.wz_out) annotation (Line(points={{18,30},{4,
          30},{-6,30},{-6,1.8},{-1,1.8}},
                                    color={0,0,127}));
  connect(rearWardAmplification.motion, vehicle.wz_out) annotation (Line(points={{18,70},
          {6,70},{-6,70},{-6,1.8},{-1,1.8}},       color={0,0,127}));
  connect(and1.u1, damping.valid) annotation (Line(points={{58,-70},{54,-70},{50,
          -70},{50,25},{41,25}}, color={255,0,255}));
  connect(and1.u2, rearWardAmplification.valid) annotation (Line(points={{58,-78},
          {54,-78},{46,-78},{46,65},{41,65}}, color={255,0,255}));
  connect(and1.y, valid)
    annotation (Line(points={{81,-70},{110,-70}}, color={255,0,255}));
  connect(highSpeedTransientOfftracking.ry, vehicle.ry_out) annotation (Line(
        points={{58,-20},{26,-20},{-6,-20},{-6,-8},{-1,-8}}, color={0,0,127}));
  connect(highSpeedTransientOfftracking.HSTO, HSTO)
    annotation (Line(points={{81,-20},{110,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-100},{100,100}}, fileName=
              "modelica://OpenPBS/Resources/illustrations/SingleLaneChange.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/HSTO_Description.png\"/></p>
</html>"));
end SingleLaneChange;
