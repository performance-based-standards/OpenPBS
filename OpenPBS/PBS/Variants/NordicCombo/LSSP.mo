within OpenPBS.PBS.Variants.NordicCombo;
model LSSP
  import OpenPBS;
  extends OpenPBS.PBS.LSSP(redeclare
      OpenPBS.Parameters.Variants.NordicCombination paramSet, const(k=
          50));
end LSSP;
