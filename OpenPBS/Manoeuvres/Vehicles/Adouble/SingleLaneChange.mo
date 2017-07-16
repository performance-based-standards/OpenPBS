within OpenPBS.Manoeuvres.Vehicles.Adouble;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.Manoeuvres.SingleLaneChange(redeclare
      OpenPBS.VehicleParameters.Vehicles.Adouble6x4 paramSet);
end SingleLaneChange;
