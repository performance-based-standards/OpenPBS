within OpenPBS.VehicleModels;
model LongitudinalAcceleration
  "Use max thrust force distributed on driving axles for dynamic simulation"
  extends Longitudinal(mode=1, inclination_angle=0);
  parameter Real friction=1;

  Modelica.SIunits.Force max_force=min(limiting_force)*friction;
  Modelica.Blocks.Interfaces.RealOutput s_out=rx[1,1]
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real limiting_force[nu,na];

equation
  Fxd=min(max_force,min(max_thrust_force_vx0,max_engine_power/max(0.1,vx[1]))/n_driven);
  for i in 1:nu loop
    for j in 1:na loop
      limiting_force[i,j] = if driven[i,j] then verticalForces.Fz[i,j] else 1e10;
    end for;
  end for;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LongitudinalAcceleration;
