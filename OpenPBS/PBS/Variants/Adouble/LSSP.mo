within OpenPBS.PBS.Variants.Adouble;
model LSSP
  import OpenPBS;
  extends OpenPBS.PBS.LSSP(redeclare
      OpenPBS.Parameters.Variants.Adouble6x4 paramSet,                  const(k=50));
end LSSP;
