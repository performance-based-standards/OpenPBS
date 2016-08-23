within OpenPBS.SandBox;
model AccInput
  //Single period sine for lateral acceleration
  VehicleModels.SingleTrack vehicle(steadystate=false,
    L=L,
    X=X,
    m=m,
    nu=nu,
    na=na)
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Math.InverseBlockConstraints inverseBlockConstraints
    annotation (Placement(transformation(extent={{-10,-12},{30,12}})));

  Modelica.Blocks.Interfaces.RealOutput a_y_out[vehicle.nu]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Modelica.SIunits.Length L[nu,na]=[0,-3,-4.37; 0,-1.3,-2.6; 0,-1.3,
      0; 0,-1.3,-2.6];
  parameter Modelica.SIunits.Length X[nu]={-1.3647,2.0656,0.0609,1.7499};
  parameter Modelica.SIunits.Mass m[nu]={9841,33101,3200,33800} "Masses";
  parameter Integer nu=4 "Number of units";
  parameter Integer na=3 "Max number of axles per unit";
  Modelica.Blocks.Interfaces.RealInput a_y_first "Input signal 1 (u1 = u2)"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Modelica.Blocks.Interfaces.RealInput vx_in "First unit velocity input"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
equation

  a_y_out = vehicle.ay;

  connect(vehicle.delta_in, inverseBlockConstraints.y2)
    annotation (Line(points={{22,6},{26,6},{26,0},{27,0}}, color={0,0,127}));
  connect(inverseBlockConstraints.u1, a_y_first)
    annotation (Line(points={{-12,0},{-66,0},{-66,50},{-120,50}},
                                                color={0,0,127}));
  connect(vehicle.vx_in, vx_in) annotation (Line(points={{22,-6},{40,-6},{
          40,-50},{-120,-50}}, color={0,0,127}));
  connect(vehicle.ay_out[1, 1], inverseBlockConstraints.u2) annotation (
      Line(points={{-1,-6},{-2,-6},{-2,0},{-6,0}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end AccInput;
