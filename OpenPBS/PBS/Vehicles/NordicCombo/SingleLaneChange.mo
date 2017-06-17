within OpenPBS.PBS.Vehicles.NordicCombo;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.PBS.SingleLaneChange(redeclare
      OpenPBS.Parameters.Vehicles.NordicCombination paramSet);
end SingleLaneChange;
