within OpenPBS;
package Manouvres

  package Blocks

    package PBS

      block RearWardAmplification
        extends Modelica.Blocks.Icons.Block;
        parameter Integer nu=2 "Number of units";

        Modelica.SIunits.AngularVelocity peak_first(start=0);
        Modelica.SIunits.AngularVelocity peak_last(start=0);

        Modelica.Blocks.Interfaces.RealOutput RWA "Rearward amplification"
          annotation (Placement(transformation(extent={{100,40},{120,60}})));

        Modelica.Blocks.Interfaces.RealInput motion[nu]
          "Lateral acceleration or yaw rate"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput valid
          "True if RWA was successfully calculated"
          annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      equation
        RWA=if peak_first > 0 then peak_last/peak_first else -1.0;

        when abs(motion[1]) > pre(peak_first) and der(abs(motion[1])) < 0 and abs(
            motion[1]) > 0.05 then
          peak_first = abs(motion[1]);
        end when;

        when abs(motion[end]) > pre(peak_last) and der(abs(motion[end])) < 0 and abs(
            motion[end]) > 0.05 then
          peak_last = abs(motion[end]);
        end when;

        valid=if peak_first > 0 and peak_last > 0 then true else false;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end RearWardAmplification;

      model Damping
        extends Modelica.Blocks.Icons.Block;
        parameter Integer nu=2;
        Modelica.Blocks.Interfaces.RealOutput D "Damping"
          annotation (Placement(transformation(extent={{100,40},{120,60}})));
        parameter Integer npeaks=3;
        parameter Modelica.SIunits.Time start_time=0;
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
        Modelica.Blocks.Logical.ZeroCrossing zeroCrossing(u=der(motion[end]),enable=time>start_time);

      equation
        when {zeroCrossing.y} then
            for i in 1:npeaks loop
              if (i==pre(ipeak)) then
                peaks[i] = abs(motion[end]);
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

      block HighSpeedTransientOfftracking
        extends Modelica.Blocks.Icons.Block;
        parameter Integer nu=4;
        parameter Integer na=3;
        parameter Modelica.SIunits.Length width=4.5 "width of lane change maneuver";

        RollingMax rollingMax(n1=nu, n2=na)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput ry[nu,na]
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput HSTO
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Math.Add add(k2=-1)
          annotation (Placement(transformation(extent={{42,-16},{62,4}})));
        Modelica.Blocks.Sources.Constant const(k=width)
          annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
      equation
        connect(rollingMax.u, ry)
          annotation (Line(points={{-12,0},{-120,0},{-120,0}}, color={0,0,127}));
        connect(add.u1, rollingMax.y)
          annotation (Line(points={{40,0},{11,0}},        color={0,0,127}));
        connect(add.y, HSTO) annotation (Line(points={{63,-6},{80,-6},{80,0},{110,0}},
              color={0,0,127}));
        connect(const.y, add.u2) annotation (Line(points={{21,-30},{30,-30},{30,-12},{
                40,-12}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end HighSpeedTransientOfftracking;

      block FrictionDemand
        extends Modelica.Blocks.Interfaces.BlockIcon;
        MaxFrictionUsage maxFrictionUsage(nu=nu, na=na,
          driven=driven)
          annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
        Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        parameter Integer nu=2;
        parameter Integer na=3;
        Modelica.Blocks.Interfaces.RealOutput FDST
          annotation (Placement(transformation(extent={{100,30},{140,70}})));
        Modelica.Blocks.Interfaces.RealOutput FDDT
          annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
        parameter Real max_friction=0.8 "Maximum allowed friction";
        Modelica.Blocks.Math.Gain steer_gain(k=1/max_friction)
          annotation (Placement(transformation(extent={{70,40},{90,60}})));
        Modelica.Blocks.Math.Gain drive_gain(k=1/max_friction)
          annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
        parameter Boolean driven[nu,na]=[false,true,true; false,false,false]
          "Driven axles";
        RollingMax rollingMax1_1(n1=1, n2=1)
          annotation (Placement(transformation(extent={{34,40},{54,60}})));
        RollingMax rollingMax1_2(n1=1, n2=1)
          annotation (Placement(transformation(extent={{34,-60},{54,-40}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001)
          annotation (Placement(transformation(extent={{0,2},{16,18}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.001)
          annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
      equation
        connect(maxFrictionUsage.friction_usage, friction_usage)
          annotation (Line(points={{-64,0},{-120,0}}, color={0,0,127}));
        connect(steer_gain.y, FDST)
          annotation (Line(points={{91,50},{120,50}}, color={0,0,127}));
        connect(drive_gain.y, FDDT)
          annotation (Line(points={{91,-50},{120,-50}}, color={0,0,127}));
        connect(steer_gain.u, rollingMax1_1.y)
          annotation (Line(points={{68,50},{55,50}}, color={0,0,127}));
        connect(drive_gain.u, rollingMax1_2.y)
          annotation (Line(points={{68,-50},{55,-50}}, color={0,0,127}));
        connect(maxFrictionUsage.y1, firstOrder.u)
          annotation (Line(points={{-18,10},{-1.6,10}}, color={0,0,127}));
        connect(firstOrder.y, rollingMax1_1.u[1, 1]) annotation (Line(points={{16.8,
                10},{24,10},{24,50},{32,50}}, color={0,0,127}));
        connect(firstOrder1.u, maxFrictionUsage.y2) annotation (Line(points={{-1.6,
                -10},{-9.8,-10},{-18,-10}}, color={0,0,127}));
        connect(firstOrder1.y, rollingMax1_2.u[1, 1]) annotation (Line(points={{16.8,
                -10},{24,-10},{24,-50},{32,-50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FrictionDemand;

      block FrictionDemand_New
        extends Modelica.Blocks.Interfaces.BlockIcon;
        MaxFrictionUsage_New
                         maxFrictionUsage(nu=nu, na=na,
          driven=driven)
          annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));
        Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        parameter Integer nu=2;
        parameter Integer na=3;
        Modelica.Blocks.Interfaces.RealOutput FDST
          annotation (Placement(transformation(extent={{100,30},{140,70}})));
        Modelica.Blocks.Interfaces.RealOutput FDDT
          annotation (Placement(transformation(extent={{100,-70},{140,-30}})));
        parameter Boolean driven[nu,na]=[false,true,true; false,false,false]
          "Driven axles";
        RollingMax rollingMax1_1(n1=1, n2=1)
          annotation (Placement(transformation(extent={{34,40},{54,60}})));
        RollingMax rollingMax1_2(n1=1, n2=1)
          annotation (Placement(transformation(extent={{34,-60},{54,-40}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.001)
          annotation (Placement(transformation(extent={{0,2},{16,18}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.001)
          annotation (Placement(transformation(extent={{0,-18},{16,-2}})));
      equation
        connect(maxFrictionUsage.friction_usage, friction_usage)
          annotation (Line(points={{-64,0},{-120,0}}, color={0,0,127}));
        connect(maxFrictionUsage.y1, firstOrder.u)
          annotation (Line(points={{-18,10},{-1.6,10}}, color={0,0,127}));
        connect(firstOrder1.u, maxFrictionUsage.y2) annotation (Line(points={{-1.6,
                -10},{-9.8,-10},{-18,-10}}, color={0,0,127}));
        connect(rollingMax1_1.y, FDST)
          annotation (Line(points={{55,50},{120,50}},          color={0,0,127}));
        connect(rollingMax1_2.y, FDDT)
          annotation (Line(points={{55,-50},{120,-50},{120,-50}}, color={0,0,127}));
        connect(firstOrder.y, rollingMax1_1.u[1, 1]) annotation (Line(points={{16.8,
                10},{24,10},{24,50},{32,50}}, color={0,0,127}));
        connect(firstOrder1.y, rollingMax1_2.u[1, 1]) annotation (Line(points={{16.8,
                -10},{24,-10},{24,-50},{32,-50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end FrictionDemand_New;
    end PBS;

    model SinglePeriodSine
      extends Modelica.Blocks.Interfaces.SO;
      Modelica.Blocks.Sources.Sine sineSource(
        amplitude=amplitude,
        freqHz=freqHz,
        startTime=startTime)
        annotation (Placement(transformation(extent={{-20,20},{0,40}})));
      parameter Real amplitude=1 "Amplitude of sine wave";
      parameter Modelica.SIunits.Frequency freqHz "Frequency of sine wave";
      parameter Modelica.SIunits.Time startTime=0;
      Modelica.Blocks.Sources.Step step(height=-1, offset=1,
        startTime=startTime + 1/freqHz)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    equation

      connect(sineSource.y, product.u1) annotation (Line(points={{1,30},{14,
              30},{14,6},{28,6}}, color={0,0,127}));
      connect(step.y, product.u2) annotation (Line(points={{1,-30},{14,-30},{
              14,-6},{28,-6}}, color={0,0,127}));
      connect(product.y, y)
        annotation (Line(points={{51,0},{76,0},{110,0}}, color={0,0,127}));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent=
                {{-100,-100},{100,100}})));
    end SinglePeriodSine;

    block RollingMax "Find max value of n signals during simulation"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer n1=1 "Number of rows in input matrix";
      parameter Integer n2=1 "Number of columns in input matrix";

      Real[n1,n2] umax;
      Modelica.Blocks.Interfaces.RealInput u[n1,n2](stateSelect=StateSelect.never)
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

      y = max(umax);

      for i in 1:n1 loop
        for j in 1:n2 loop
          when der(u[i,j])<0 then
            umax[i,j] = max(u[i,j],pre(umax[i,j]));
          end when;
        end for;
      end for;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end RollingMax;

    block Curvature "Curvature at each axle"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer nu=3 "Number of units";
      parameter Integer na=2 "Max number of axles per unit";

      Modelica.Blocks.Interfaces.RealInput vx[nu] "vx at c.o.g."
        annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
      Modelica.Blocks.Interfaces.RealInput vy[nu] "vy at c.o.g."
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealInput wz[nu] "wz at c.o.g."
        annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));

      parameter Modelica.SIunits.Length[nu,na] Lcog
        "Axle positions relative c.g.";

      Modelica.Blocks.Interfaces.RealOutput
                 y[nu,na] "Connector of Real output signals" annotation (Placement(
            transformation(extent={{100,-10},{120,10}})));

    equation

      for i in 1:nu loop
        for j in 1:na loop
          y[i,j] = wz[i]/sqrt((vy[i]+Lcog[i,j]*wz[i])^2+vx[i]^2);
        end for;
      end for;
         annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Curvature;

    block InstantMax "Find max value of n signals"
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer n1=1 "Number of rows in input matrix";
      parameter Integer n2=1 "Number of columns in input matrix";

      Modelica.Blocks.Interfaces.RealInput u[n1,n2]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    equation

      y = max(u);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end InstantMax;

    function booleanToInteger
      input Boolean u;
      output Integer y;
    algorithm
      y :=if u then 1 else 0;
    end booleanToInteger;

    block MaxFrictionUsage
      "Calculate the maximum friction used for the front axle and all driven axles (max value)."
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer nu=2 "Number of rows in input matrix";
      parameter Integer na=3 "Numnber of colums in input matrix";
      parameter Boolean[nu,na] driven=[false,true,true;false,false,false]
                                                      "Driven axles"
                                                                    annotation(Evaluate=true);

      Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y1
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Interfaces.RealOutput y2
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

    protected
      parameter Integer[nu,na] matrix=booleanToInteger(driven);
    equation
      y1=friction_usage[1, 1];
      y2=max(friction_usage .* matrix);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MaxFrictionUsage;

    block MaxFrictionUsage_New
      "Calculate the maximum friction used for the front axle and all driven axles (max value)."
      extends Modelica.Blocks.Interfaces.BlockIcon;
      parameter Integer nu=2 "Number of rows in input matrix";
      parameter Integer na=3 "Numnber of colums in input matrix";
      parameter Boolean[nu,na] driven=[false,true,true;false,false,false]
                                                      "Driven axles"
                                                                    annotation(Evaluate=true);

      Modelica.Blocks.Interfaces.RealInput friction_usage[nu,na]
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y1
        annotation (Placement(transformation(extent={{100,40},{120,60}})));
      Modelica.Blocks.Interfaces.RealOutput y2
        annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

    protected
      parameter Integer[nu,na] matrix=booleanToInteger(driven);
    equation
      y1=friction_usage[1, 1]; //assuming axle [1,1] is steered and only steered
      y2=max(friction_usage .* matrix);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MaxFrictionUsage_New;
  end Blocks;

  package Vehicles

    package Adouble

      model SingleLaneChange
        import OpenPBS;
        extends OpenPBS.Manouvres.SingleLaneChange(redeclare
            OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet);
      end SingleLaneChange;
    end Adouble;

    package NordicCombo

      model SingleLaneChange
        import OpenPBS;
        extends OpenPBS.Manouvres.SingleLaneChange(redeclare
            OpenPBS.Vehicles.Vehicles.NordicCombination paramSet);
      end SingleLaneChange;
    end NordicCombo;

    package Vehicles

    end Vehicles;
  end Vehicles;

  model SingleLaneChange
    import OpenPBS;
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
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
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
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">HSTO, High Speed Transient Off Tracking</span></b></p>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/HSTO_Description.png\"/></p>
</html>"));
  end SingleLaneChange;

  model SingleSineSteering
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.SIunits.Frequency freqHz=0.4 "Frequency of lateral acceleration in ground coordinates";
    parameter Modelica.SIunits.Velocity vx=80/3.6 "Longitudinal velocity";
    parameter Real amplitude=0.050 "Amplitude of sine wave";
    VehicleModels.SingleTrack vehicle(paramSet=paramSet)
      annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
    Modelica.Blocks.Sources.Constant velocitySource(k=80/3.6)
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
    Blocks.SinglePeriodSine singlePeriodSine(
      startTime=5,
      freqHz=freqHz,
      amplitude=amplitude)
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
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
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">RWA, Rearward Amplification</span></b></p>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/RWA_Description.png\"/></p>
<h4><span style=\"color: #0000ff\">====================================================================================</span></h4>
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">YD, Yaw Damping</span></b></p>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/YD_Description.png\"/></p>
</html>"));
  end SingleSineSteering;

  model LowSpeedCurve
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu=4 "Number of units";
    parameter Integer na=3 "Number of axles (max across all units)";

    Modelica.Blocks.Interfaces.RealOutput LSSP "Low speed swept path"
      annotation (Placement(transformation(extent={{100,56},{120,76}})));
    Components.PathPosition pathPositionRight[nu,na](n0=0, s0=
          vehicle.vehicle.rx0) "Path position of right side wheels"
      annotation (Placement(transformation(extent={{-24,-24},{-4,-4}})));
    Modelica.Blocks.Sources.Constant const(k=5)
      annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));
    Components.Curve90deg curve90deg[nu,na](radius=curve_radius,
        s_start=curve_start)
      annotation (Placement(transformation(extent={{10,4},{-10,24}})));
    VehicleModels.DirectionInput vehicle(paramSet=paramSet,
      nu=nu,
      na=na)
      annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression3[nu,
      na](y=matrix(vehicle.vehicle.vy)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
    Modelica.Blocks.Sources.RealExpression realExpression4[nu,
      na](y=matrix(vehicle.vehicle.pz)*ones(1, na))
      annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
    Modelica.Blocks.Sources.RealExpression realExpression5[nu,
      na](y=matrix(vehicle.vehicle.vx)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
    Components.PathPosition pathPositionLeft[nu,na](s0=vehicle.vehicle.rx0,
        n0=paramSet.w) "Path position of left side wheels"
      annotation (Placement(transformation(extent={{-20,52},{0,72}})));
    Components.Curve90deg curve90deg1[nu,na](radius=
          curve_radius, s_start=curve_start)
      annotation (Placement(transformation(extent={{20,76},{0,96}})));
    Components.MotionOffset motionOffsetLeft[nu,na](x_offset=
          vehicle.vehicle.Lcog, y_offset=paramSet.w/2)
      "Position and velocity of left wheels on all axles"
      annotation (Placement(transformation(extent={{-60,56},{-40,76}})));
    Modelica.Blocks.Sources.RealExpression realExpression7[nu,
      na](y=matrix(vehicle.vehicle.wz)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Components.MotionOffset motionOffsetRight[nu,na](x_offset=
          vehicle.vehicle.Lcog, y_offset=-paramSet.w/2)
      "Position and velocity of right wheels on all axles"
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Blocks.RollingMax rollingMax(n1=nu, n2=na)
      "Maximum of all left wheel offsets"
      annotation (Placement(transformation(extent={{60,56},{80,76}})));
    parameter Modelica.SIunits.Length curve_radius=12.5;
    parameter Modelica.SIunits.Position curve_start=50
      "Distance along path when curve starts";
    Modelica.Blocks.Interfaces.BooleanOutput valid
      "True if Yaw damping was successfully calculated"
      annotation (Placement(transformation(extent={{100,-34},{120,-14}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThan(threshold=
          curve_start + curve_radius*Modelica.Constants.pi/2)
      annotation (Placement(transformation(extent={{40,-24},{60,-4}})));
    Blocks.RollingMax rollingMax1(
                                 n1=nu, n2=na)
      annotation (Placement(transformation(extent={{36,6},{46,16}})));
    Modelica.Blocks.Math.Gain gain[nu,na](k=-1) annotation (
       Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={26,6})));
    Modelica.Blocks.Logical.LessThreshold lessThan(threshold=0.05)
      annotation (Placement(transformation(extent={{56,6},{66,16}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{74,-10},{94,10}})));
    Components.PathPosition90degCurve overHangCalculatorRigth[nu,2](
      radius=curve_radius,
      s_start=curve_start,
      s0=vehicle.vehicle.rx0_oh,
      nu=paramSet.nu,
      na=paramSet.na,
      x_offset=vehicle.vehicle.Lcog_oh,
      y_offset=-paramSet.w/2,
      n0=0) "Calculate all overhang positions on the rigth side."
      annotation (Placement(transformation(extent={{24,-88},{44,-68}})));
    Modelica.Blocks.Sources.RealExpression realExpression9[nu,2](y=matrix(vehicle.vehicle.vx)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-70},{
              -80,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression10[
                                                           nu,2](y=matrix(vehicle.vehicle.vy)
          *ones(1, 2))
      annotation (Placement(transformation(extent={{-100,-82},{-80,-62}})));
    Modelica.Blocks.Sources.RealExpression realExpression11[
                                                           nu,2](y=matrix(vehicle.vehicle.wz)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-94},{
              -80,-74}})));
    Modelica.Blocks.Sources.RealExpression realExpression12[
                                                           nu,2](y=matrix(vehicle.vehicle.pz)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-106},{
              -80,-86}})));
    Blocks.RollingMax     rollingMax4(
                                     n1=nu, n2=1)
      "Maximum of all front rigth offsets for each unit"
      annotation (Placement(transformation(extent={{62,-64},{82,-44}})));
    Blocks.RollingMax     rollingMax5(
                                     n1=nu, n2=1)
      "Maximum of all rear rigth offsets for each unit"
      annotation (Placement(transformation(extent={{66,-98},{86,-78}})));
    Modelica.Blocks.Math.Gain gain1[nu,1](k=-1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={52,-62})));
    Modelica.Blocks.Math.Gain gain2[nu,1](k=-1) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={54,-84})));
    Modelica.Blocks.Interfaces.RealOutput FS "Front Swing(rigth side)"
      annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
    Modelica.Blocks.Interfaces.RealOutput RS "Rear swing(rigth side)"
      annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
    Blocks.PBS.FrictionDemand frictionDemand(
      nu=nu,
      na=na,
      driven=paramSet.driven,
      max_friction=max_friction)
      annotation (Placement(transformation(extent={{40,28},{60,48}})));
    Modelica.Blocks.Sources.RealExpression realExpression1[nu,
      na](y=vehicle.vehicle.friction_usage)
      annotation (Placement(transformation(extent={{10,28},{30,48}})));
    parameter Real max_friction=0.8
      "Maximum allowed friction (for friction demand calculation)";
    Modelica.Blocks.Interfaces.RealOutput FDST "Friction demand on steer tyres"
      annotation (Placement(transformation(extent={{100,34},{120,54}})));
    Modelica.Blocks.Interfaces.RealOutput FDDT "Friction demand on drive tyres"
      annotation (Placement(transformation(extent={{100,14},{120,34}})));
  equation
    connect(pathPositionRight.s_out, curve90deg.u) annotation (Line(points={{-3,-7},
            {18,-7},{18,14},{12,14}},        color={0,0,127}));
    connect(curve90deg.y,pathPositionRight. c) annotation (Line(points={{-11,14},
            {-11,14},{-14,14},{-14,-2}},        color={0,0,127}));
    connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-47},{10,-47},{
            -40,-47},{-40,-38},{-59,-38}},
                                       color={0,0,127}));
    connect(pathPositionLeft.s_out, curve90deg1.u) annotation (Line(points={{1,69},{
            26,69},{26,86},{22,86}},             color={0,0,127}));
    connect(curve90deg1.y,pathPositionLeft. c) annotation (Line(points={{-1,86},{
            -1,86},{-10,86},{-10,74}},               color={0,0,127}));
    connect(realExpression4.y,pathPositionLeft. pz) annotation (Line(points={{-39,36},
            {-30,36},{-30,56},{-22,56}},              color={0,0,127}));
    connect(realExpression5.y, motionOffsetLeft.vx) annotation (Line(points={{-79,62},
            {-68,62},{-68,72},{-62,72}},     color={0,0,127}));
    connect(realExpression3.y, motionOffsetLeft.vy)
      annotation (Line(points={{-79,46},{-70,46},{-70,66},{-62,66}},
                                                   color={0,0,127}));
    connect(realExpression7.y, motionOffsetLeft.wz) annotation (Line(points={{-79,30},
            {-72,30},{-72,60},{-62,60}},     color={0,0,127}));
    connect(motionOffsetLeft.vx_offset, pathPositionLeft.vx) annotation (Line(
          points={{-38,72},{-34,72},{-34,68},{-30,68},{-22,68}},
          color={0,0,127}));
    connect(motionOffsetRight.vy_offset, pathPositionRight.vy) annotation (Line(
          points={{-38,-16},{-34,-16},{-34,-14},{-26,-14}}, color={0,0,127}));
    connect(motionOffsetRight.vx_offset, pathPositionRight.vx) annotation (Line(
          points={{-38,-4},{-34,-4},{-34,-8},{-26,-8}},     color={0,0,127}));
    connect(pathPositionLeft.n_out, rollingMax.u) annotation (Line(points={{1,65},{
            32,65},{32,66},{58,66}},             color={0,0,127}));
    connect(rollingMax.y, LSSP) annotation (Line(points={{81,66},{81,66},{110,66}},
                            color={0,0,127}));
    connect(pathPositionRight[1, 1].pp_out, vehicle.front_direction_in)
      annotation (Line(points={{-3,-21},{10,-21},{10,-28},{10,-37},{18,-37}},
          color={0,0,127}));
    connect(pathPositionRight.pz, realExpression4.y) annotation (Line(points={{-26,-20},
            {-30,-20},{-30,36},{-39,36}},      color={0,0,127}));
    connect(motionOffsetLeft.vy_offset, pathPositionLeft.vy) annotation (Line(
          points={{-38,60},{-34,60},{-34,62},{-22,62}}, color={0,0,127}));
    connect(motionOffsetRight.vx, realExpression5.y) annotation (Line(points={{-62,-4},
            {-68,-4},{-68,62},{-79,62}},       color={0,0,127}));
    connect(motionOffsetRight.vy, realExpression3.y) annotation (Line(points={{-62,-10},
            {-70,-10},{-70,46},{-79,46}},      color={0,0,127}));
    connect(motionOffsetRight.wz, realExpression7.y) annotation (Line(points={{-62,-16},
            {-66,-16},{-72,-16},{-72,30},{-79,30}},      color={0,0,127}));
    connect(greaterThan.u, pathPositionRight[end, 1].s_out) annotation (Line(
          points={{38,-14},{8,-14},{8,-7},{-3,-7}},   color={0,0,127}));
    connect(gain.y, rollingMax1.u)
      annotation (Line(points={{26,10.4},{26,11},{35,11}}, color={0,0,127}));
    connect(gain.u, pathPositionRight.n_out) annotation (Line(points={{26,1.2},{
            26,-11},{-3,-11}},         color={0,0,127}));
    connect(rollingMax1.y, lessThan.u) annotation (Line(points={{46.5,11},{46.5,
            11},{55,11}},      color={0,0,127}));
    connect(lessThan.y, and1.u1) annotation (Line(points={{66.5,11},{68,11},{68,4},
            {68,0},{72,0}},                    color={255,0,255}));
    connect(greaterThan.y, and1.u2) annotation (Line(points={{61,-14},{66,-14},{
            66,-8},{72,-8}},    color={255,0,255}));
    connect(and1.y, valid) annotation (Line(points={{95,0},{98,0},{98,-24},{110,
            -24}},      color={255,0,255}));
    connect(realExpression9.y,overHangCalculatorRigth. vx) annotation (Line(points={{-79,-60},
            {6,-60},{6,-71.7},{22.3,-71.7}},        color={0,0,127}));
    connect(realExpression10.y,overHangCalculatorRigth. vy) annotation (Line(points={{-79,-72},
            {-6,-72},{-6,-76.6},{22.2,-76.6}},        color={0,0,127}));
    connect(realExpression11.y,overHangCalculatorRigth. wz) annotation (Line(points={{-79,-84},
            {-30,-84},{-22,-84},{-22,-80.8},{22.2,-80.8}},                color={0,0,127}));
    connect(realExpression12.y,overHangCalculatorRigth. pz) annotation (Line(points={{-79,-96},
            {-58,-96},{-24,-96},{-24,-88},{-14,-88},{-14,-85.4},{22.2,-85.4}},
                     color={0,0,127}));
    connect(rollingMax4.y, FS) annotation (Line(points={{83,-54},{86,-54},{86,-62},
            {110,-62}}, color={0,0,127}));
    connect(rollingMax5.y, RS)
      annotation (Line(points={{87,-88},{87,-82},{110,-82}}, color={0,0,127}));
    connect(gain1.y,rollingMax4. u) annotation (Line(points={{52,-57.6},{56,-57.6},
            {56,-54},{60,-54}}, color={0,0,127}));
    connect(overHangCalculatorRigth[:, 2].n_out,gain2 [:, 1].u)
      annotation (Line(points={{45,-76},{54,-76},{54,-79.2}}, color={0,0,127}));
    connect(gain2.y,rollingMax5. u)
      annotation (Line(points={{54,-88.4},{54,-88},{64,-88}},    color={0,0,127}));
    connect(gain1[:, 1].u,overHangCalculatorRigth [:, 1].n_out)
      annotation (Line(points={{52,-66.8},{52,-76},{45,-76}}, color={0,0,127}));
    connect(realExpression1.y, frictionDemand.friction_usage)
      annotation (Line(points={{31,38},{38,38}}, color={0,0,127}));
    connect(frictionDemand.FDST, FDST) annotation (Line(points={{62,43},{82,43},{
            82,44},{110,44}}, color={0,0,127}));
    connect(frictionDemand.FDDT, FDDT) annotation (Line(points={{62,33},{82,33},{
            82,24},{110,24}},                 color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">LSSP, Low Speed Swept Path</span></b></p>
<p><b><span style=\"font-size: 12pt;\">Manoeuvre: </span></b></p>
<ul>
<li>Speed=0+</li>
<li>Friction=High</li>
<li>Unit loading=Max load, evenly distributed</li>
<li>guide: R=12.5 m, 90 deg </li>
</ul>
<p><b><span style=\"font-size: 12pt;\">Measure: </span></b></p>
<p>LSSP=Max perpendicular distance from guide to follower. </p>
<p>Relevant alternatives and selection: </p>
<ul>
<li>guide=FAO, follower=worst of all other [HCTinSWE and OpenPBS] </li>
<li>guide=FBO, follower=worst of all other [approx. Australia] </li>
</ul>
<p><i><b><span style=\"font-size: 12pt; color: #ff0000;\">Present known issues with selected definition: </span></b></i></p>
<ul>
<li><i><span style=\"color: #ff0000;\">Low or high mu? What value if hi (1?), and if low (0.35?)</span></i></li>
<li><i><span style=\"color: #ff0000;\">HCTinSWE and OpenPBS does not punish long overhang, e.g. city buses or &ldquo;nose-built&rdquo; cabins </span></i></li>
<li><i><span style=\"color: #ff0000;\">OpenPBS presently does not saturate axle forces to mu_max*F_z. </span></i></li>
</ul>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/LSSP_Description.png\"/></p>
<p>￼</p>
</html>"));
  end LowSpeedCurve;

  model LowSpeedCurve_SaturatedTyre
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu=4 "Number of units";
    parameter Integer na=3 "Number of axles (max across all units)";

    Modelica.Blocks.Interfaces.RealOutput LSSP "Low speed swept path"
      annotation (Placement(transformation(extent={{100,56},{120,76}})));
    Components.PathPosition pathPositionRight[nu,na](n0=0, s0=
          vehicle.vehicle.rx0) "Path position of right side wheels"
      annotation (Placement(transformation(extent={{-24,-24},{-4,-4}})));
    Modelica.Blocks.Sources.Constant const(k=5)
      annotation (Placement(transformation(extent={{-80,-48},{-60,-28}})));
    Components.Curve90deg curve90deg[nu,na](radius=curve_radius,
        s_start=curve_start)
      annotation (Placement(transformation(extent={{10,4},{-10,24}})));
    VehicleModels.DirectionInput_SaturatedTyre
                                 vehicle(paramSet=paramSet,
      nu=nu,
      na=na,
      mu=max_friction)
      annotation (Placement(transformation(extent={{20,-52},{40,-32}})));
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression3[nu,
      na](y=matrix(vehicle.vehicle.vy)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,36},{-80,56}})));
    Modelica.Blocks.Sources.RealExpression realExpression4[nu,
      na](y=matrix(vehicle.vehicle.pz)*ones(1, na))
      annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
    Modelica.Blocks.Sources.RealExpression realExpression5[nu,
      na](y=matrix(vehicle.vehicle.vx)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,52},{-80,72}})));
    Components.PathPosition pathPositionLeft[nu,na](s0=vehicle.vehicle.rx0,
        n0=paramSet.w) "Path position of left side wheels"
      annotation (Placement(transformation(extent={{-20,52},{0,72}})));
    Components.Curve90deg curve90deg1[nu,na](radius=
          curve_radius, s_start=curve_start)
      annotation (Placement(transformation(extent={{20,76},{0,96}})));
    Components.MotionOffset motionOffsetLeft[nu,na](x_offset=
          vehicle.vehicle.Lcog, y_offset=paramSet.w/2)
      "Position and velocity of left wheels on all axles"
      annotation (Placement(transformation(extent={{-60,56},{-40,76}})));
    Modelica.Blocks.Sources.RealExpression realExpression7[nu,
      na](y=matrix(vehicle.vehicle.wz)*ones(1, na))
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Components.MotionOffset motionOffsetRight[nu,na](x_offset=
          vehicle.vehicle.Lcog, y_offset=-paramSet.w/2)
      "Position and velocity of right wheels on all axles"
      annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
    Blocks.RollingMax rollingMax(n1=nu, n2=na)
      "Maximum of all left wheel offsets"
      annotation (Placement(transformation(extent={{60,56},{80,76}})));
    parameter Modelica.SIunits.Length curve_radius=12.5;
    parameter Modelica.SIunits.Position curve_start=50
      "Distance along path when curve starts";
    Modelica.Blocks.Interfaces.BooleanOutput valid
      "True if Yaw damping was successfully calculated"
      annotation (Placement(transformation(extent={{100,-34},{120,-14}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThan(threshold=
          curve_start + curve_radius*Modelica.Constants.pi/2)
      annotation (Placement(transformation(extent={{40,-24},{60,-4}})));
    Blocks.RollingMax rollingMax1(
                                 n1=nu, n2=na)
      annotation (Placement(transformation(extent={{36,6},{46,16}})));
    Modelica.Blocks.Math.Gain gain[nu,na](k=-1) annotation (
       Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={26,6})));
    Modelica.Blocks.Logical.LessThreshold lessThan(threshold=0.05)
      annotation (Placement(transformation(extent={{56,6},{66,16}})));
    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{74,-10},{94,10}})));
    Components.PathPosition90degCurve overHangCalculatorRigth[nu,2](
      radius=curve_radius,
      s_start=curve_start,
      s0=vehicle.vehicle.rx0_oh,
      nu=paramSet.nu,
      na=paramSet.na,
      x_offset=vehicle.vehicle.Lcog_oh,
      y_offset=-paramSet.w/2,
      n0=0) "Calculate all overhang positions on the rigth side."
      annotation (Placement(transformation(extent={{24,-88},{44,-68}})));
    Modelica.Blocks.Sources.RealExpression realExpression9[nu,2](y=matrix(vehicle.vehicle.vx)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-70},{
              -80,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression10[
                                                           nu,2](y=matrix(vehicle.vehicle.vy)
          *ones(1, 2))
      annotation (Placement(transformation(extent={{-100,-82},{-80,-62}})));
    Modelica.Blocks.Sources.RealExpression realExpression11[
                                                           nu,2](y=matrix(vehicle.vehicle.wz)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-94},{
              -80,-74}})));
    Modelica.Blocks.Sources.RealExpression realExpression12[
                                                           nu,2](y=matrix(vehicle.vehicle.pz)
          *ones(1, 2)) annotation (Placement(transformation(extent={{-100,-106},{
              -80,-86}})));
    Blocks.RollingMax     rollingMax4(
                                     n1=nu, n2=1)
      "Maximum of all front rigth offsets for each unit"
      annotation (Placement(transformation(extent={{62,-64},{82,-44}})));
    Blocks.RollingMax     rollingMax5(
                                     n1=nu, n2=1)
      "Maximum of all rear rigth offsets for each unit"
      annotation (Placement(transformation(extent={{66,-98},{86,-78}})));
    Modelica.Blocks.Math.Gain gain1[nu,1](k=-1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=90,
          origin={52,-62})));
    Modelica.Blocks.Math.Gain gain2[nu,1](k=-1) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={54,-84})));
    Modelica.Blocks.Interfaces.RealOutput FS "Front Swing(rigth side)"
      annotation (Placement(transformation(extent={{100,-72},{120,-52}})));
    Modelica.Blocks.Interfaces.RealOutput RS "Rear swing(rigth side)"
      annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
    Blocks.PBS.FrictionDemand_New
                              frictionDemand(
      nu=nu,
      na=na,
      driven=paramSet.driven)
      annotation (Placement(transformation(extent={{40,28},{60,48}})));
    Modelica.Blocks.Sources.RealExpression realExpression1[nu,
      na](y=vehicle.vehicle.friction_usage)
      annotation (Placement(transformation(extent={{4,28},{30,48}})));
    parameter Real max_friction=0.3
      "Maximum allowed friction (for friction demand calculation)";
    Modelica.Blocks.Interfaces.RealOutput FDST "Friction demand on steer tyres"
      annotation (Placement(transformation(extent={{100,34},{120,54}})));
    Modelica.Blocks.Interfaces.RealOutput FDDT "Friction demand on drive tyres"
      annotation (Placement(transformation(extent={{100,14},{120,34}})));
  equation
    connect(pathPositionRight.s_out, curve90deg.u) annotation (Line(points={{-3,-7},
            {18,-7},{18,14},{12,14}},        color={0,0,127}));
    connect(curve90deg.y,pathPositionRight. c) annotation (Line(points={{-11,14},
            {-11,14},{-14,14},{-14,-2}},        color={0,0,127}));
    connect(vehicle.vx_in,const. y) annotation (Line(points={{18,-47},{10,-47},{
            -40,-47},{-40,-38},{-59,-38}},
                                       color={0,0,127}));
    connect(pathPositionLeft.s_out, curve90deg1.u) annotation (Line(points={{1,69},{
            26,69},{26,86},{22,86}},             color={0,0,127}));
    connect(curve90deg1.y,pathPositionLeft. c) annotation (Line(points={{-1,86},{
            -1,86},{-10,86},{-10,74}},               color={0,0,127}));
    connect(realExpression4.y,pathPositionLeft. pz) annotation (Line(points={{-39,36},
            {-30,36},{-30,56},{-22,56}},              color={0,0,127}));
    connect(realExpression5.y, motionOffsetLeft.vx) annotation (Line(points={{-79,62},
            {-68,62},{-68,72},{-62,72}},     color={0,0,127}));
    connect(realExpression3.y, motionOffsetLeft.vy)
      annotation (Line(points={{-79,46},{-70,46},{-70,66},{-62,66}},
                                                   color={0,0,127}));
    connect(realExpression7.y, motionOffsetLeft.wz) annotation (Line(points={{-79,30},
            {-72,30},{-72,60},{-62,60}},     color={0,0,127}));
    connect(motionOffsetLeft.vx_offset, pathPositionLeft.vx) annotation (Line(
          points={{-38,72},{-34,72},{-34,68},{-30,68},{-22,68}},
          color={0,0,127}));
    connect(motionOffsetRight.vy_offset, pathPositionRight.vy) annotation (Line(
          points={{-38,-16},{-34,-16},{-34,-14},{-26,-14}}, color={0,0,127}));
    connect(motionOffsetRight.vx_offset, pathPositionRight.vx) annotation (Line(
          points={{-38,-4},{-34,-4},{-34,-8},{-26,-8}},     color={0,0,127}));
    connect(pathPositionLeft.n_out, rollingMax.u) annotation (Line(points={{1,65},{
            32,65},{32,66},{58,66}},             color={0,0,127}));
    connect(rollingMax.y, LSSP) annotation (Line(points={{81,66},{81,66},{110,66}},
                            color={0,0,127}));
    connect(pathPositionRight[1, 1].pp_out, vehicle.front_direction_in)
      annotation (Line(points={{-3,-21},{10,-21},{10,-28},{10,-37},{18,-37}},
          color={0,0,127}));
    connect(pathPositionRight.pz, realExpression4.y) annotation (Line(points={{-26,-20},
            {-30,-20},{-30,36},{-39,36}},      color={0,0,127}));
    connect(motionOffsetLeft.vy_offset, pathPositionLeft.vy) annotation (Line(
          points={{-38,60},{-34,60},{-34,62},{-22,62}}, color={0,0,127}));
    connect(motionOffsetRight.vx, realExpression5.y) annotation (Line(points={{-62,-4},
            {-68,-4},{-68,62},{-79,62}},       color={0,0,127}));
    connect(motionOffsetRight.vy, realExpression3.y) annotation (Line(points={{-62,-10},
            {-70,-10},{-70,46},{-79,46}},      color={0,0,127}));
    connect(motionOffsetRight.wz, realExpression7.y) annotation (Line(points={{-62,-16},
            {-66,-16},{-72,-16},{-72,30},{-79,30}},      color={0,0,127}));
    connect(greaterThan.u, pathPositionRight[end, 1].s_out) annotation (Line(
          points={{38,-14},{8,-14},{8,-7},{-3,-7}},   color={0,0,127}));
    connect(gain.y, rollingMax1.u)
      annotation (Line(points={{26,10.4},{26,11},{35,11}}, color={0,0,127}));
    connect(gain.u, pathPositionRight.n_out) annotation (Line(points={{26,1.2},{
            26,-11},{-3,-11}},         color={0,0,127}));
    connect(rollingMax1.y, lessThan.u) annotation (Line(points={{46.5,11},{46.5,
            11},{55,11}},      color={0,0,127}));
    connect(lessThan.y, and1.u1) annotation (Line(points={{66.5,11},{68,11},{68,4},
            {68,0},{72,0}},                    color={255,0,255}));
    connect(greaterThan.y, and1.u2) annotation (Line(points={{61,-14},{66,-14},{
            66,-8},{72,-8}},    color={255,0,255}));
    connect(and1.y, valid) annotation (Line(points={{95,0},{98,0},{98,-24},{110,
            -24}},      color={255,0,255}));
    connect(realExpression9.y,overHangCalculatorRigth. vx) annotation (Line(points={{-79,-60},
            {6,-60},{6,-71.7},{22.3,-71.7}},        color={0,0,127}));
    connect(realExpression10.y,overHangCalculatorRigth. vy) annotation (Line(points={{-79,-72},
            {-6,-72},{-6,-76.6},{22.2,-76.6}},        color={0,0,127}));
    connect(realExpression11.y,overHangCalculatorRigth. wz) annotation (Line(points={{-79,-84},
            {-30,-84},{-22,-84},{-22,-80.8},{22.2,-80.8}},                color={0,0,127}));
    connect(realExpression12.y,overHangCalculatorRigth. pz) annotation (Line(points={{-79,-96},
            {-58,-96},{-24,-96},{-24,-88},{-14,-88},{-14,-85.4},{22.2,-85.4}},
                     color={0,0,127}));
    connect(rollingMax4.y, FS) annotation (Line(points={{83,-54},{86,-54},{86,-62},
            {110,-62}}, color={0,0,127}));
    connect(rollingMax5.y, RS)
      annotation (Line(points={{87,-88},{87,-82},{110,-82}}, color={0,0,127}));
    connect(gain1.y,rollingMax4. u) annotation (Line(points={{52,-57.6},{56,-57.6},
            {56,-54},{60,-54}}, color={0,0,127}));
    connect(overHangCalculatorRigth[:, 2].n_out,gain2 [:, 1].u)
      annotation (Line(points={{45,-76},{54,-76},{54,-79.2}}, color={0,0,127}));
    connect(gain2.y,rollingMax5. u)
      annotation (Line(points={{54,-88.4},{54,-88},{64,-88}},    color={0,0,127}));
    connect(gain1[:, 1].u,overHangCalculatorRigth [:, 1].n_out)
      annotation (Line(points={{52,-66.8},{52,-76},{45,-76}}, color={0,0,127}));
    connect(realExpression1.y, frictionDemand.friction_usage)
      annotation (Line(points={{31.3,38},{31.3,38},{38,38}},
                                                 color={0,0,127}));
    connect(frictionDemand.FDST, FDST) annotation (Line(points={{62,43},{82,43},{
            82,44},{110,44}}, color={0,0,127}));
    connect(frictionDemand.FDDT, FDDT) annotation (Line(points={{62,33},{82,33},{82,
            24},{110,24}},                    color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p><b><span style=\"font-size: 20pt; color: #0000ff;\">LSSP, Low Speed Swept Path</span></b></p>
<p><b><span style=\"font-size: 12pt;\">Manoeuvre: </span></b></p>
<ul>
<li>Speed=0+</li>
<li>Friction=High</li>
<li>Unit loading=Max load, evenly distributed</li>
<li>guide: R=12.5 m, 90 deg </li>
</ul>
<p><b><span style=\"font-size: 12pt;\">Measure: </span></b></p>
<p>LSSP=Max perpendicular distance from guide to follower. </p>
<p>Relevant alternatives and selection: </p>
<ul>
<li>guide=FAO, follower=worst of all other [HCTinSWE and OpenPBS] </li>
<li>guide=FBO, follower=worst of all other [approx. Australia] </li>
</ul>
<p><i><b><span style=\"font-size: 12pt; color: #ff0000;\">Present known issues with selected definition: </span></b></i></p>
<ul>
<li><i><span style=\"color: #ff0000;\">Low or high mu? What value if hi (1?), and if low (0.35?)</span></i></li>
<li><i><span style=\"color: #ff0000;\">HCTinSWE and OpenPBS does not punish long overhang, e.g. city buses or &ldquo;nose-built&rdquo; cabins </span></i></li>
<li><i><span style=\"color: #ff0000;\">OpenPBS presently does not saturate axle forces to mu_max*F_z. </span></i></li>
</ul>
<p><img src=\"modelica://OpenPBS/Resources/illustrations/LSSP_Description.png\"/></p>
<p>￼</p>
</html>"),
      experiment(StopTime=30));
  end LowSpeedCurve_SaturatedTyre;

  model HighSpeedCurve
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    parameter Integer nu=4;
    parameter Integer na=3;
    parameter Modelica.SIunits.Length curve_radius=350
      "Radius of steady-state curve (at front axle)";
    parameter Modelica.SIunits.Velocity velocity=15 "Velocity reference";
    Modelica.Blocks.Sources.Constant velocitySource(k=velocity)
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
    Modelica.Blocks.Sources.Constant curvature(k=1/curve_radius)
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    VehicleModels.CurvatureInput vehicle(
      paramSet=paramSet,
      nu=nu,
      na=na) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
    Modelica.Blocks.Math.Division division[nu,na]
      annotation (Placement(transformation(extent={{-10,10},{10,30}})));
    Modelica.Blocks.Sources.Constant const[nu,na](each k=1)
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));

    Modelica.Blocks.Sources.Constant const1[
                                           nu,na](each k=curve_radius)
      annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
    Modelica.Blocks.Math.Add add[nu,na](k2=-1)
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Blocks.InstantMax instantMax(n1=nu, n2=na)
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput HSSO
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput valid
      "True if Yaw damping was successfully calculated"
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Sources.BooleanConstant booleanConstant
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  equation
    connect(vehicle.curvature_in, curvature.y) annotation (Line(points={{-51,26},{
            -52,26},{-52,26},{-50,26},{-50,26},{-64,26},{-64,30},{-79,30}},
                                                   color={0,0,127}));
    connect(vehicle.vx_in, velocitySource.y) annotation (Line(points={{-51,14},{-64,
            14},{-64,-30},{-79,-30}}, color={0,0,127}));
    connect(division.u2, vehicle.curvature_out)
      annotation (Line(points={{-12,14},{-8,14},{-29,14}},
                                                         color={0,0,127}));
    connect(const.y, division.u1)
      annotation (Line(points={{-29,50},{-20,50},{-20,26},{-12,26}},
                                                               color={0,0,127}));
    connect(division.y, add.u1)
      annotation (Line(points={{11,20},{18,20},{18,6},{28,6}}, color={0,0,127}));
    connect(const1.y, add.u2) annotation (Line(points={{11,-20},{18,-20},{18,-6},{
            28,-6}}, color={0,0,127}));
    connect(add.y, instantMax.u)
      annotation (Line(points={{51,0},{54.5,0},{58,0}}, color={0,0,127}));
    connect(instantMax.y, HSSO)
      annotation (Line(points={{81,0},{96,0},{96,60},{110,60}},
                                                color={0,0,127}));
    connect(booleanConstant.y, valid)
      annotation (Line(points={{81,-60},{110,-60}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end HighSpeedCurve;

  model SteadyStateRollOver
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Vehicles.Adouble6x4
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SteadyStateRollOver;

  model HighSpeedStraightPath
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu=paramSet.nu;
    parameter Integer na=paramSet.na;
    parameter Modelica.SIunits.Velocity velocity=15 "Reference velocity";
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    VehicleModels.SingleTrack vehicle(
      paramSet=paramSet,
      inclination=inclination,
      mode=1) annotation (Placement(transformation(extent={{26,0},{6,20}})));

    Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
      annotation (Placement(transformation(extent={{-10,-2},{40,22}})));
    Modelica.Blocks.Sources.Constant velocitySource(k=velocity)
      annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-96,2},{-76,22}})));
    Modelica.Blocks.Interfaces.RealOutput TASP
      "Swept area when driving on constant crossfall"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    parameter Modelica.SIunits.Angle inclination=0.05 "Lateral road inclination";
    Modelica.Blocks.Math.Abs abs1
      annotation (Placement(transformation(extent={{64,-10},{84,10}})));
  equation
    connect(vehicle.delta_in,inverseBlockConstraints. y2)
      annotation (Line(points={{28,16},{36,16},{36,10},{36.25,10}},
                                                             color={0,0,127}));
    connect(velocitySource.y,vehicle. vx_in) annotation (Line(points={{31,-30},{44,
            -30},{44,4},{28,4}},   color={0,0,127}));
    connect(const.y, inverseBlockConstraints.u1) annotation (Line(points={{-75,12},
            {-44,12},{-44,10},{-12.5,10}}, color={0,0,127}));
    connect(vehicle.ry_out[1, 1], inverseBlockConstraints.u2)
      annotation (Line(points={{5,2},{0,2},{0,10},{-5,10}}, color={0,0,127}));
    connect(abs1.y, TASP)
      annotation (Line(points={{85,0},{92,0},{110,0}}, color={0,0,127}));
    connect(abs1.u, vehicle.ry_out[nu, na]) annotation (Line(points={{62,0},{50,0},{
            50,-12},{0,-12},{0,2},{5,2}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={Text(
            extent={{-36,60},{34,38}},
            lineColor={28,108,200},
            textString="Mode=1
Hence the model should be simulated until
no transient behavior is seen.
For deafult values more than 10 s")}));
  end HighSpeedStraightPath;

  model Longitudinal
    import OpenPBS;
    extends Modelica.Blocks.Icons.Block;

    parameter Integer nu=paramSet.nu;
    parameter Integer na=paramSet.na;
    replaceable parameter OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet
      constrainedby OpenPBS.Vehicles.Base.VehicleModel
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));

    Modelica.Blocks.Interfaces.RealOutput S "Startability"
      annotation (Placement(transformation(extent={{100,60},{120,80}})));
    parameter Modelica.SIunits.Angle inclination=0.05 "Lateral road inclination";
    Modelica.Blocks.Interfaces.RealOutput G "gradeability"
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealOutput AC "Acceleration capability"
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    VehicleModels.LongitudinalAccelerationQS startability(
      paramSet=paramSet,
      acceleration_demand=acceleration_demand,
      friction=friction)
      annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    VehicleModels.LongitudinalAccelerationQS gradeability(
      acceleration_demand=0.001,
      paramSet=paramSet,
      vx0=vx_gradeability,
      friction=friction)
      annotation (Placement(transformation(extent={{-20,20},{0,40}})));
    VehicleModels.LongitudinalAcceleration longitudinalAcceleration(
      vx0=0,
      paramSet=paramSet,
      friction=friction)
      annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
    parameter Modelica.SIunits.Acceleration acceleration_demand=0.001
      "Required acceleration for startability and gradeability";
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
          distance_target)
      annotation (Placement(transformation(extent={{-32,-80},{-12,-60}})));
    Modelica.Blocks.Interfaces.BooleanOutput valid
      annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
    Modelica.Blocks.Logical.Switch switch1
      annotation (Placement(transformation(extent={{38,-40},{58,-20}})));
    parameter Real distance_target=100
      "Distance target for acceleration capability";
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{8,-20},{28,0}})));
    Modelica.Blocks.Sources.Constant const1(k=1)
      annotation (Placement(transformation(extent={{8,-60},{28,-40}})));
    Modelica.Blocks.Continuous.Integrator derivative
      annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
    parameter Modelica.SIunits.Velocity vx_gradeability=15
      "Longitudinal velocity for gradeability calculation";
    parameter Real friction=1 "Road friction coefficient";
  equation
    connect(startability.inclination_out, S) annotation (Line(points={{1,70},{1,
            70},{58,70},{110,70}}, color={0,0,127}));
    connect(gradeability.inclination_out, G) annotation (Line(points={{1,30},{18,
            30},{26,30},{110,30}}, color={0,0,127}));
    connect(greaterThreshold.u, longitudinalAcceleration.s_out) annotation (Line(
          points={{-34,-70},{-44,-70},{-44,-40},{-49,-40}}, color={0,0,127}));
    connect(greaterThreshold.y, valid)
      annotation (Line(points={{-11,-70},{110,-70}}, color={255,0,255}));
    connect(switch1.u2, greaterThreshold.y) annotation (Line(points={{36,-30},{-2,
            -30},{-2,-70},{-11,-70}}, color={255,0,255}));
    connect(const.y, switch1.u1) annotation (Line(points={{29,-10},{32,-10},{32,
            -22},{36,-22}}, color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{29,-50},{32,-50},{32,
            -38},{36,-38}}, color={0,0,127}));
    connect(switch1.y, derivative.u)
      annotation (Line(points={{59,-30},{68,-30}}, color={0,0,127}));
    connect(AC, derivative.y)
      annotation (Line(points={{110,-30},{91,-30}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Longitudinal;
end Manouvres;
