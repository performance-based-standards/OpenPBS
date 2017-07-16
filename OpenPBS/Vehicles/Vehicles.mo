within OpenPBS.Vehicles;
package Vehicles

  record Adouble6x4=OpenPBS.Vehicles.Base.VehicleModel (
      nu=4,
      na=3,
      L=[0.0,-3.0,-4.37; 0.0,-1.3,-2.6; 0.0,-1.3,0.0; 0.0,-1.3,-2.6],
      w=[2.5,2.5,2.5; 2.5,2.5,2.5; 2.5,2.5,2.5; 2.5,2.5,2.5],
      X={-1.3647,2.0656,0.0609,1.7499},
      cgh={1,1,1,1},
      A={0.0,6.4,3.9,6.4},
      B={-3.4,-4.0,-0.65,-4.0},
      driven=[false,true,true; false,false,false; false,false,false; false,
          false,false],
      Cc=[5.5,5.5,5.5; 5.5,5.5,5.5; 5.5,5.5,5.5; 5.5,5.5,5.5],
      m={9841.0,33101.0,3200.0,33800.0},
      I=1e5*{0.2991,5.7348,0.0728,5.5145},
      axlegroups=[1,2,2; 1,1,1; 1,1,0; 1,1,1],
      FOH={0.5,7.15,0.25,7.15},
      ROH={-4.8,-3,-1.55,-3.1})
    "A-double with 6x4 tractor";
  record TractorSemitrailer6x2 =
                    OpenPBS.Vehicles.Base.VehicleModel (
      nu=2,
      na=3,
      L=[0.0,-3.0,-4.37; 0.0,-1.3,-2.6],
      w=[2.5,2.5,2.5; 2.5,2.5,2.5],
      X={-1.3647,2.0656},
      A={0.0,6.4},
      B={-3.4,-4.0},
      driven=[false,true,false; false,false,false],
      Cc=[5.5,5.5,5.5; 5.5,5.5,5.5],
      m={9841.0,33101.0},
      I={0.2991,5.7348},
      axlegroups=[1,2,2; 1,1,1],
      FOH={1,7},
      ROH={-4.8,-3.5})                                                                                                                                                                                                         "6x2 tractor with semitrailer";
  record NordicCombination =
                    OpenPBS.Vehicles.Base.VehicleModel (
      nu=3,
      L=[0,-4.8,-6.2; 0,-1.3,0; 0,-1.3,-2.6],
      w=[2.5,2.5,2.5; 2.5,2.5,2.5; 2.5,2.5,2.5],
      X={-1.3647,0.0609,1.7499},
      cgh={1,1,1},
      A={0,3.9,6.4},
      B={-8,-0.65,-4},
      driven=[false,true,false; false,false,false; false,false,false],
      Cc=[5.5,5.5,5.5; 5.5,5.5,5.5; 5.5,5.5,5.5],
      m={26000,3200,33800},
      I=1e5*{3.2991,0.0728,5.5145},
      axlegroups=[1,2,2; 1,1,0; 1,1,1],
      FOH={1,0.5,7.5},
      ROH={-8.2,-1.7,-3.6})                                                                                                                                                                                                         "6x2 truck with dolly and semitrailer";
  package FromRegistry

    record SLX394 = OpenPBS.Vehicles.Base.UnitSpecification (
        n_axles=3,
        n_wheels=10,
        max_payload_mass=0,
        coupling_distance_EU=5.0,
        coupling_distance_front=0,
        rear_overhang=1.0,
        wheelbase={3.0,1.37,0.0},
        tyre_dimension1={385.0,385.0,295.0,295.0,295.0,295.0,295.0,295.0,
            295.0,295.0},
        tyre_dimension2={65.0,65.0,55.0,55.0,55.0,55.0,55.0,55.0,55.0,55.0},
        tyre_dimension3={22.5,22.5,22.5,22.5,22.5,22.5,22.5,22.5,22.5,22.5},
        length=6.75,
        height=3.844,
        width=2.55,
        kerb_mass=9875.0,
        load_index=1.0,
        max_engine_power=551000.0,
        chassis_height=1.0,
        max_load_height=4.0,
        load_space_length=5.0,
        load_space_position=0,
        yaw_inertia_unloaded=30000.0,
        pitch_inertia_unloaded=30000.0,
        roll_inertia_unloaded=3000.0,
        cg_x_location_unloaded=-1,
        cg_z_location_unloaded=1,
        front_overhang=1,
        cornering_coefficient=5.5,
        n_wheels_per_axle={1,2,2},
        axle_width={2.5,2.5,2.5},
        axle_groups={1,2,2},
        load_distribution={1.0,0.5,0.5},
        nominal_axle_load={10000.0,10000.0,10000.0},
        max_thrust_vx0=150000.0)
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    record CNC134 = OpenPBS.Vehicles.Base.UnitSpecification (
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
        load_distribution={0.3333333333333333,0.3333333333333333,
            0.3333333333333333},
        nominal_axle_load={15000.0,24000.0,24000.0},
        max_thrust_vx0=0.0)
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
  end FromRegistry;

  package Vehicles "Data from vehicle registry"

  end Vehicles;
end Vehicles;
