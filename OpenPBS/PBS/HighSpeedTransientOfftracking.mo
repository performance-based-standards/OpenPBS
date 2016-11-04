within OpenPBS.PBS;
model HighSpeedTransientOfftracking
  //Single period sine for lateral acceleration
  VehicleModels.SingleTrack vehicle(paramSet=paramSet)
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-10,-12},{30,12}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=80/3.6)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

  Modelica.SIunits.AngularVelocity wz_peak_first(start=0);
  Modelica.SIunits.AngularVelocity wz_peak_last(start=0);

  Modelica.SIunits.AngularVelocity abs_wz_first=abs(vehicle.wz_out[1]);
  Modelica.SIunits.AngularVelocity abs_wz_last=abs(vehicle.wz_out[vehicle.nu]);

  Modelica.Blocks.Interfaces.RealOutput RWA "Rearward amplification"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));

  inner replaceable parameter Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel                annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if RWA was successfully calculated"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Blocks.SinglePeriodSine singlePeriodSine(
    startTime=5,
    amplitude=2.0,
    freqHz=sqrt(singlePeriodSine.amplitude/(4.5*2*Modelica.Constants.pi)))
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Modelica.Blocks.Continuous.Der der1
    annotation (Placement(transformation(extent={{-20,-30},{-40,-10}})));
  Modelica.Blocks.Continuous.Der der2
    annotation (Placement(transformation(extent={{-48,-30},{-68,-10}})));
equation

  RWA=if wz_peak_first>0 then wz_peak_last/wz_peak_first else -1.0;

  when abs(vehicle.wz_out[1])>pre(wz_peak_first) and der(abs(vehicle.wz_out[1]))<0 and abs(vehicle.wz_out[1])>0.05 then
      wz_peak_first=abs(vehicle.wz_out[1]);
  end when;

  when abs(vehicle.wz_out[end])>pre(wz_peak_last) and der(abs(vehicle.wz_out[end]))<0 and abs(vehicle.wz_out[end])>0.05 then
      wz_peak_last=abs(vehicle.wz_out[end]);
  end when;

  valid=if wz_peak_first>0 and wz_peak_last>0 then true else false;

  connect(vehicle.delta_in, inverseBlockConstraints.y2)
    annotation (Line(points={{22,6},{26,6},{26,0},{27,0}}, color={0,0,127}));
  connect(velocitySource.y, vehicle.vx_in) annotation (Line(points={{21,-30},{34,
          -30},{34,-6},{22,-6}}, color={0,0,127}));
  connect(der1.u, vehicle.ry_out[1, 1]) annotation (Line(points={{-18,-20},
          {-6,-20},{-6,-8},{-1,-8}}, color={0,0,127}));
  connect(der2.u, der1.y) annotation (Line(points={{-46,-20},{-41,-20},{-41,
          -20}}, color={0,0,127}));
  connect(der2.y, inverseBlockConstraints.u2) annotation (Line(points={{-69,
          -20},{-74,-20},{-74,-4},{-6,-4},{-6,0}}, color={0,0,127}));
  connect(inverseBlockConstraints.u1, singlePeriodSine.y)
    annotation (Line(points={{-12,0},{-79,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Documentation(info="<html>
<p><b>Rearward amplification</b> </p>
<p>In a sudden manoeuvre at high speeds, the lateral motion of the hauling unit of a heavy vehicle combination is amplified increasingly by each successive unit; this phenomenon is called rearward amplification and is a matter of concern for vehicle combinations with more than one articulation point. Rearward amplification is defined as the ratio of the peak value of a motion variable of interest for the rearmost unit to that of the hauling unit; it is usually given in terms of lateral acceleration or yaw rate. This performance measure indicates the increased risk for a swing out or rollover of the last unit compared to what the driver is experiencing in the towing unit. Rearward amplification improves with fewer articulation points, more forward location of coupling points, longer wheelbase and higher cornering-stiffness of tyres (Prem et al. 2000). </p>
<h4>Test method</h4>
<p>Same test method as for the high-speed transient offtracking can be used, i.e. performing a sudden manoeuvre such as lane change at high speed. It should be noted that the maximum rearward amplification occurs at different steering frequency for various heavy vehicle combinations. Thus, it is advised that the manoeuvring should be performed for a range of frequencies and the worst case be selected for fare comparison (Ervin &AMP; Guy 1986). In the Australian approach, a steer frequency of 0.4 Hz is used instead of finding the worst frequency as suggested in ISO 14791 (NTC 2008). </p>
<h4>Traffic/Real-world problem which is mitigated </h4>
<p>When doing lateral movements in high speed there is a risk to hit other objects and risk to rollover. During a lateral manoeuvres, each unit in the combination experiences different motion, typically amplified rearwards. Trafikverket says <a name=\"_x0000_t75\"><a name=\"_x0000_i1025\">&nbsp;on main road and . </a></p>
<p><b><a name=\"_Ref443970813\">T</a>est description</b> </p>
<p>ISO14791, section 8.2.3 Single lane-change. Defined with single sine on vehicle-lateral acceleration of centre of first axle. </p>
<p>Speed: 80 km/h </p>
<p>Frequency: Defined as highest yaw rate gain for stationary harmonic oscillation steering. </p>
<p>Amplitude: 2 m/s^2</p>
<p>Payload: Maximum allowed payload in each unit</p>
<p><b>Test parameters with default values</b> </p>
<p>Road friction: <a name=\"_x0000_i1025\">&nbsp;</a>{0.35 1} </p>
<h4>Measure definition</h4>
<p>See variable <code><span style=\"background-color: #ffffff;\">RWA</span></code></p>
<p><b>Numerical requirement</b> </p>
<pre>RWA&LT;2.4</pre>
</html>"));
end HighSpeedTransientOfftracking;
