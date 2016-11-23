within OpenPBS.VehicleModels;
model DirectionInput
  "Single track model with direction of travel at front axle as input"
  parameter Integer nu=2;
  parameter Integer na=3;

  VehicleModels.SingleTrack vehicle(            mode=2, paramSet=paramSet,
    nu=nu,
    na=na)
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-34,52},{26,88}})));

  Modelica.Blocks.Interfaces.RealOutput delta_out
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealInput front_direction_in
    "Direction of travel at first axle"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput vx_in "First unit velocity input"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Modelica.Blocks.Math.Atan2 headingAngle
    annotation (Placement(transformation(extent={{-40,-20},{-60,0}})));
  Components.MotionOffset motionOffset(y_offset=-paramSet.w[1, 1]/2,
      x_offset=vehicle.Lcog[1, 1])
    annotation (Placement(transformation(extent={{0,-20},{-20,0}})));
  parameter Parameters.Base.VehicleModel paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=vehicle.pz[1])
    annotation (Placement(transformation(extent={{-40,-44},{-60,-24}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-72,-30},{-92,-10}})));
equation

  connect(vehicle.delta_in, inverseBlockConstraints.y2)
    annotation (Line(points={{42,-4},{72,-4},{72,40},{18,40},{18,70},{21.5,
          70}},                                            color={0,0,127}));
  connect(inverseBlockConstraints.u1, front_direction_in) annotation (Line(
        points={{-37,70},{-66,70},{-66,50},{-120,50}}, color={0,0,127}));
  connect(vehicle.vx_in, vx_in) annotation (Line(points={{42,-16},{66,-16},
          {66,-50},{-120,-50}},
                       color={0,0,127}));
  connect(inverseBlockConstraints.y1, delta_out) annotation (Line(points={{27.5,70},
          {96,70},{96,0},{110,0}}, color={0,0,127}));
  connect(vehicle.vx_out[1], motionOffset.vx)
    annotation (Line(points={{19,-2},{10,-2},{10,-4},{2,-4}},
                                              color={0,0,127}));
  connect(vehicle.vy_out[1], motionOffset.vy) annotation (Line(points={{19,-5},
          {12,-5},{12,-10},{2,-10}},     color={0,0,127}));
  connect(vehicle.wz_out[1], motionOffset.wz) annotation (Line(points={{19,-8.2},
          {12,-8.2},{12,-16},{2,-16}},     color={0,0,127}));
  connect(motionOffset.vy_offset, headingAngle.u1) annotation (Line(points=
          {{-22,-16},{-30,-16},{-30,-4},{-38,-4}}, color={0,0,127}));
  connect(motionOffset.vx_offset, headingAngle.u2) annotation (Line(points=
          {{-22,-4},{-28,-4},{-28,-16},{-38,-16}}, color={0,0,127}));
  connect(add.u1, headingAngle.y) annotation (Line(points={{-70,-14},{-66,
          -14},{-66,-10},{-61,-10}}, color={0,0,127}));
  connect(add.u2, realExpression2.y) annotation (Line(points={{-70,-26},{
          -66,-26},{-66,-34},{-61,-34}}, color={0,0,127}));
  connect(add.y, inverseBlockConstraints.u2) annotation (Line(points={{-93,
          -20},{-100,-20},{-100,20},{-20,20},{-20,70},{-28,70}}, color={0,0,
          127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end DirectionInput;
