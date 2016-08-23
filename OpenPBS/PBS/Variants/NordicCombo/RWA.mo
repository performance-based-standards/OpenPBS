within OpenPBS.PBS.Variants.NordicCombo;
model RWA
  extends RearWardAmplification(redeclare
      Parameters.Variants.NordicCombination paramSet);
  annotation (experiment(StopTime=15), __Dymola_experimentSetupOutput);
end RWA;
