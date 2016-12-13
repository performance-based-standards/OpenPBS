within OpenPBS.VehicleModels;
model LongitudinalAccelerationQS
  "Use max thrust force distributed on driving axles and solve for the highest inclination angle where the desired acceleration can be achieved"
  extends Longitudinal(mode=2, inclination_angle(fixed=false,start=0),vx0=0);

  parameter Modelica.SIunits.Acceleration acceleration_demand=0.02 "Required acceleration";


  Modelica.Blocks.Interfaces.RealOutput inclination_out=inclination_angle
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
initial equation
  Fxd=min(max_thrust_force_vx0,max_engine_power/max(0.1,vx[1]))/n_driven;
equation

  ax[1]=acceleration_demand;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LongitudinalAccelerationQS;
