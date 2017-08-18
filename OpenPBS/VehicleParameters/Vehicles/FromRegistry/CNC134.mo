within OpenPBS.VehicleParameters.Vehicles.FromRegistry;
record CNC134 = OpenPBS.VehicleParameters.Base.UnitSpecification (
    n_axles=3,
    n_wheels=6,
    max_payload_mass=29930.0,
    coupling_distance_EU=10.0,
    coupling_distance_front=0,
    rear_overhang=3.02,
    wheelbase={1.3,1.3,0.0},
    tyre_dimension1={385.0,385.0,385.0,385.0,385.0,385.0},
    tyre_dimension2={55.0,55.0,55.0,55.0,55.0,55.0},
    tyre_dimension3={22.5,22.5,22.5,22.5,22.5,22.5},
    length=13.8,
    height=4.45,
    width=2.6,
    kerb_mass=9070.0,
    load_index=1.0,
    max_engine_power=0.0,
    chassis_height=1.0,
    max_load_height=4.45,
    load_space_length=10.0,
    load_space_position=7,
    yaw_inertia_unloaded=30000.0,
    pitch_inertia_unloaded=30000.0,
    roll_inertia_unloaded=3000.0,
    cg_x_location_unloaded=3,
    cg_z_location_unloaded=1,
    front_overhang=1,
    cornering_coefficient=5.5,
    n_wheels_per_axle={2,2,2},
    axle_width={2.6,2.6,2.6},
    axle_groups={1,1,1},
    load_distribution={0.3333333333333333,0.3333333333333333,0.3333333333333333},

    nominal_axle_load={15000.0,24000.0,24000.0},
    max_thrust_vx0=0.0) annotation (Icon(coordinateSystem(preserveAspectRatio=
          false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
