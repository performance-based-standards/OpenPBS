within OpenPBS.PBS;
model SingleSineSteering
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Frequency freqHz=0.4 "Frequency of lateral acceleration in ground coordinates";
  parameter Modelica.SIunits.Velocity vx=80/3.6 "Longitudinal velocity";
  parameter Real amplitude=0.05 "Amplitude of sine wave";
  VehicleModels.SingleTrack vehicle(paramSet=paramSet)
    annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=80/3.6)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Blocks.SinglePeriodSine singlePeriodSine(
    startTime=5,
    freqHz=freqHz,
    amplitude=amplitude)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
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

equation
  connect(velocitySource.y,vehicle. vx_in) annotation (Line(points={{-79,-30},{-60,
          -30},{-60,-6},{-38,-6}},
                                 color={0,0,127}));
  connect(rearWardAmplification.RWA, RWA) annotation (Line(points={{41,75},{62,75},
          {62,74},{82,74},{82,60},{110,60}}, color={0,0,127}));
  connect(damping.D, YD) annotation (Line(points={{41,35},{80,35},{80,20},{110,20}},
        color={0,0,127}));
  connect(damping.motion, vehicle.wz_out) annotation (Line(points={{18,30},{4,30},
          {-6,30},{-6,1.8},{-15,1.8}},
                                    color={0,0,127}));
  connect(rearWardAmplification.motion, vehicle.wz_out) annotation (Line(points={{18,70},
          {6,70},{-6,70},{-6,1.8},{-15,1.8}},      color={0,0,127}));
  connect(and1.u1, damping.valid) annotation (Line(points={{58,-70},{54,-70},{50,
          -70},{50,25},{41,25}}, color={255,0,255}));
  connect(and1.u2, rearWardAmplification.valid) annotation (Line(points={{58,-78},
          {54,-78},{46,-78},{46,65},{41,65}}, color={255,0,255}));
  connect(and1.y, valid)
    annotation (Line(points={{81,-70},{110,-70}}, color={255,0,255}));
  connect(singlePeriodSine.y, vehicle.delta_in) annotation (Line(points={{-79,30},
          {-70,30},{-60,30},{-60,6},{-38,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-100,-100},{100,100}}, fileName=
              "modelica://OpenPBS/Resources/illustrations/SingleLaneChange.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SingleSineSteering;
