within OpenPBS.Manoeuvres.Blocks;
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
