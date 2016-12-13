within OpenPBS.VehicleModels;
model LongitudinalAcceleration
  "Use max thrust force distributed on driving axles for dynamic simulation"
  extends Longitudinal(mode=1, inclination_angle=0);

  Modelica.Blocks.Interfaces.RealOutput s_out=rx[1,1]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  Fxd=min(max_thrust_force_vx0,max_engine_power/max(0.1,vx[1]))/n_driven;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LongitudinalAcceleration;
