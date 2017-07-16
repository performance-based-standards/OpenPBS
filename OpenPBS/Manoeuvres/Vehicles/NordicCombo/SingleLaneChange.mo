within OpenPBS.Manoeuvres.Vehicles.NordicCombo;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.Manoeuvres.SingleLaneChange(redeclare
      OpenPBS.VehicleParameters.Vehicles.NordicCombination paramSet);
end SingleLaneChange;
