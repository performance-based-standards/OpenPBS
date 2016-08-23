within OpenPBS.Parameters.Variants;
record NordicCombination =
                  OpenPBS.Parameters.Base.VehicleModel (
  nu=3,
  L=[0,-4.8,-6.2; 0,-1.3,0; 0,-1.3,-2.6],
  X={-1.3647,0.0609,1.7499},
  A={0,3.9,6.4},
  B={-8,-0.65,-4},
  m={26000,3200,33800},
  I=1e5*{3.2991,0.0728,5.5145},
  cgh={1,1,1},
  Cc=[5.5, 5.5, 5.5;
  5.5, 5.5, 5.5;
  5.5, 5.5, 5.5],
  driven=[false,true,false; false,false,false; false,false,false],
  w=
  [2.5, 2.5, 2.5;
  2.5, 2.5, 2.5;
  2.5, 2.5, 2.5],
  axlegroups=[1,2,2;1,1,0;1,1,1]) "6x2 truck with dolly and semitrailer";
