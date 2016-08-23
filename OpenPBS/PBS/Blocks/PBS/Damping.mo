within OpenPBS.PBS.Blocks.PBS;
model Damping
  parameter Integer nu=2;
  Modelica.Blocks.Interfaces.RealOutput D "Damping"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  parameter Integer npeaks=3;
  Real peaks[npeaks](start=zeros(npeaks));
  //Modelica.SIunits.Time t_peaks[npeaks](start=zeros(npeaks));

  Integer ipeak(start=1);
  Real s;

  Modelica.Blocks.Interfaces.BooleanOutput valid
    "True if Yaw damping was successfully calculated"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealInput motion[nu]
    "Lateral acceleration or yaw rate"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  when {der(motion[end])<0 and motion[end]>0.001} then
    for i in 1:npeaks loop
      if i==pre(ipeak) then
        peaks[i] = motion[end];
      else
        peaks[i] = pre(peaks[i]);
      end if;
    end for;
    ipeak=pre(ipeak)+1;
  end when;
  if peaks[1] > 0 and peaks[end] > 0 then
    s =1/(npeaks - 1)*log(peaks[end]/peaks[1]);
  else
    s = 0;
  end if;
  if s<0 then
    D = 1/sqrt(1 + (2*Modelica.Constants.pi/s)^2);
    valid=true;
  else
    D = -1;
    valid=false;
  end if;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end Damping;
