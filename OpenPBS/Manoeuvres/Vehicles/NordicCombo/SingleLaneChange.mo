within OpenPBS.Manoeuvres.Vehicles.NordicCombo;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.Manoeuvres.SingleLaneChange(
                                             redeclare
      OpenPBS.Vehicles.Vehicles.NordicCombination paramSet);
end SingleLaneChange;
