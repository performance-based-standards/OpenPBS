within OpenPBS.VehicleModels;
model CurvatureInput "Steady-state curve"
  parameter Integer nu=2;
  parameter Integer na=3;
  Modelica.Blocks.Interfaces.RealInput curvature_in annotation (Placement(
        transformation(rotation=0, extent={{-120,50},{-100,70}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-16,28},{32,52}})));
  SingleTrack               vehicle(paramSet=paramSet,
    theta(start=ones(nu - 1)*0.001),
    wz(start=ones(nu)*0.001),
    vy(start=ones(nu)*0.001),
    mode=3,
    alpha(start=-0.001*ones(nu, na)),
    Fcx(start=ones(nu - 1)*1000),
    Fcy(start=ones(nu - 1)*10000))
    annotation (Placement(transformation(extent={{26,-16},{6,4}})));
  Modelica.Blocks.Interfaces.RealInput vx_in annotation (Placement(
        transformation(rotation=0, extent={{-120,-70},{-100,-50}})));
  PBS.Blocks.Curvature curvature(
    nu=paramSet.nu,
    na=paramSet.na,
    Lcog=vehicle.Lcog)
    annotation (Placement(transformation(extent={{-12,-10},{-30,8}})));
  Modelica.Blocks.Interfaces.RealOutput curvature_out[nu,na]
    "Curvature per axle"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  parameter Parameters.Base.VehicleModel paramSet
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput delta_out "Front steer angle"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
equation
  connect(vehicle.vx_out,curvature. vx) annotation (Line(points={{5,2},{0,2},{0,
          5.3},{-10.2,5.3}},      color={0,0,127}));
  connect(vehicle.vy_out,curvature. vy) annotation (Line(points={{5,-1},{-2,-1},
          {-10.2,-1}},                       color={0,0,127}));
  connect(vehicle.wz_out,curvature. wz) annotation (Line(points={{5,-4.2},{-0.5,
          -4.2},{-0.5,-7.3},{-10.2,-7.3}},     color={0,0,127}));
  connect(curvature.y[1, 1],inverseBlockConstraints. u2) annotation (Line(
        points={{-30.9,-1},{-44,-1},{-44,20},{-6,20},{-6,40},{-11.2,40}},
        color={0,0,127}));
  connect(curvature_in, inverseBlockConstraints.u1) annotation (Line(points={{
          -110,60},{-54,60},{-54,40},{-18.4,40}}, color={0,0,127}));
  connect(vx_in, vehicle.vx_in) annotation (Line(points={{-110,-60},{70,-60},{
          70,-12},{28,-12}}, color={0,0,127}));
  connect(curvature.y, curvature_out) annotation (Line(points={{-30.9,-1},{-44,
          -1},{-44,-34},{78,-34},{78,-60},{110,-60}},      color={0,0,127}));
  connect(inverseBlockConstraints.y1, delta_out) annotation (Line(points={{33.2,
          40},{80,40},{80,60},{110,60}}, color={0,0,127}));
//   connect(inverseBlockConstraints.y2, vehicle.delta_in[1, 1]) annotation (
//       Line(points={{28.4,40},{22,40},{22,6},{34,6},{34,-1},{28,-1}}, color={0,
//           0,127}));
  connect(inverseBlockConstraints.y2, vehicle.delta_in) annotation (Line(points=
         {{28.4,40},{24,40},{24,10},{40,10},{40,0},{28,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CurvatureInput;
