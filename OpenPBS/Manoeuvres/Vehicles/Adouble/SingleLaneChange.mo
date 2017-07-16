within OpenPBS.Manoeuvres.Vehicles.Adouble;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.Manoeuvres.SingleLaneChange(
                                             redeclare
      OpenPBS.Vehicles.Vehicles.Adouble6x4 paramSet);
end SingleLaneChange;
