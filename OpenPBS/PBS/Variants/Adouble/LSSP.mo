within OpenPBS.PBS.Variants.Adouble;
model LSSP
  import OpenPBS;
  extends OpenPBS.PBS.LSSP(redeclare
      OpenPBS.Parameters.Variants.Adouble6x4 paramSet(w=2.2*ones(4,3)), const(k=50));
end LSSP;
