within OpenPBS.Vehicles;
package FunctionTests
  extends Modelica.Icons.UtilitiesPackage;
  function TestTwoUnits
    extends OpenPBS.Vehicles.Functions.ModelParametersFromSpecification(nu=2,
        specification={OpenPBS.Vehicles.Vehicles.FromRegistry.SLX394(),
          OpenPBS.Vehicles.Vehicles.FromRegistry.CNC134()});
  end TestTwoUnits;
end FunctionTests;
