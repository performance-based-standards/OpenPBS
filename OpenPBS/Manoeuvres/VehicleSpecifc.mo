within OpenPBS.Manoeuvres;
package VehicleSpecifc

  package Adouble

    model SingleLaneChange
      import OpenPBS;
      extends OpenPBS.Manoeuvres.SingleLaneChange(redeclare
          OpenPBS.VehicleParameters.Vehicles.Adouble6x4 paramSet);
    end SingleLaneChange;
  end Adouble;

  package NordicCombo

    model SingleLaneChange
      import OpenPBS;
      extends OpenPBS.Manoeuvres.SingleLaneChange(redeclare
          OpenPBS.VehicleParameters.Vehicles.NordicCombination paramSet);
    end SingleLaneChange;
  end NordicCombo;

  package Vehicles

  end Vehicles;
end VehicleSpecifc;
