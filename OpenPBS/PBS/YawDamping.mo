within OpenPBS.PBS;
model YawDamping
  //Single period sine for steering angle
  VehicleModels.SingleTrack vehicle(paramSet=paramSet)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Blocks.SinglePeriodSine singlePeriodSine(
    amplitude=0.05,
    freqHz=0.4,
    startTime=5)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant velocitySource(k=80/3.6)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Interfaces.RealOutput YD "Yaw damping"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  parameter Integer npeaks=3;
  Modelica.SIunits.AngularVelocity wz_peaks[npeaks](start=zeros(npeaks));
  //Modelica.SIunits.Time t_peaks[npeaks](start=zeros(npeaks));

  Integer ipeak(start=1);
  Real s;

  inner replaceable parameter Parameters.Variants.Adouble6x4
                                       paramSet constrainedby
    Parameters.Base.VehicleModel
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
equation
  when {der(vehicle.wz_out[end])<0 and vehicle.wz_out[end]>0.001} then
    for i in 1:npeaks loop
      if i==pre(ipeak) then
        wz_peaks[i]=vehicle.wz_out[end];
      else
        wz_peaks[i]=pre(wz_peaks[i]);
      end if;
    end for;
    ipeak=pre(ipeak)+1;
  end when;
  if wz_peaks[1]>0 and wz_peaks[end]>0 then
    s = 1/(npeaks-1)*log(wz_peaks[end]/wz_peaks[1]);
  else
    s = 0;
  end if;
  if s<0 then
    YD = 1/sqrt(1+(2*Modelica.Constants.pi/s)^2);
    valid=true;
  else
    YD = -1;
    valid=false;
  end if;
  connect(singlePeriodSine.y, vehicle.delta_in) annotation (Line(points={{-39,20},
          {-26,20},{-26,6},{-12,6}}, color={0,0,127}));

  connect(velocitySource.y, vehicle.vx_in) annotation (Line(points={{-39,-30},{-26,
          -30},{-26,-6},{-12,-6}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end YawDamping;
