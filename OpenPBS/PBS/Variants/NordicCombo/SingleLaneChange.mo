within OpenPBS.PBS.Variants.NordicCombo;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.PBS.SingleLaneChange(redeclare
      OpenPBS.Parameters.Variants.NordicCombination paramSet);
end SingleLaneChange;
