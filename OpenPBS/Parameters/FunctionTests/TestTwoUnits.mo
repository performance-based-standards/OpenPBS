within OpenPBS.Parameters.FunctionTests;
function TestTwoUnits
  extends OpenPBS.Parameters.Functions.ModelParametersFromSpecification(nu = 2, specification = {OpenPBS.Parameters.Vehicles.FromRegistry.SLX394(),OpenPBS.Parameters.Vehicles.FromRegistry.CNC134()});
end TestTwoUnits;
