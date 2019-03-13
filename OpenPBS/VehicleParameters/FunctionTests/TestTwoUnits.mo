within OpenPBS.VehicleParameters.FunctionTests;
function TestTwoUnits
  extends OpenPBS.VehicleParameters.Functions.ModelParametersFromSpecification(
      nu=2, specification={OpenPBS.Parameters.Variants.FromRegistry.SLX394(),
        OpenPBS.Parameters.Variants.FromRegistry.CNC134()});
end TestTwoUnits;
