within OpenPBS.VehicleParameters.Vehicles;
record Adouble6x4 = OpenPBS.VehicleParameters.Base.VehicleModel (
    nu=4,
    na=3,
    L=[0.0,-3.0,-4.37; 0.0,-1.3,-2.6; 0.0,-1.3,0.0; 0.0,-1.3,-2.6],
    w=[2.5,2.5,2.5; 2.5,2.5,2.5; 2.5,2.5,2.5; 2.5,2.5,2.5],
    X={-1.3647,2.0656,0.0609,1.7499},
    cgh={1,1,1,1},
    A={0.0,6.4,3.9,6.4},
    B={-3.4,-4.0,-0.65,-4.0},
    driven=[false,true,true; false,false,false; false,false,false; false,false,
        false],
    Cc=[5.5,5.5,5.5; 5.5,5.5,5.5; 5.5,5.5,5.5; 5.5,5.5,5.5],
    m={9841.0,33101.0,3200.0,33800.0},
    I=1e5*{0.2991,5.7348,0.0728,5.5145},
    axlegroups=[1,2,2; 1,1,1; 1,1,0; 1,1,1],
    FOH={0.5,7.15,0.25,7.15},
    ROH={-4.8,-3,-1.55,-3.1}) "A-double with 6x4 tractor";
