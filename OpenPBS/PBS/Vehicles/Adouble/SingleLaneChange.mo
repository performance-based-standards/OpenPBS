within OpenPBS.PBS.Vehicles.Adouble;
model SingleLaneChange
  import OpenPBS;
  extends OpenPBS.PBS.SingleLaneChange(redeclare
      OpenPBS.Parameters.Variants.Adouble6x4 paramSet);
end SingleLaneChange;
