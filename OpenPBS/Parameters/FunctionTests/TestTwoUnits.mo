within OpenPBS.Parameters.FunctionTests;
function TestTwoUnits
  extends OpenPBS.Parameters.Functions.ModelParametersFromSpecification(nu = 2, specification = {OpenPBS.Parameters.Variants.FromRegistry.SLX394(),OpenPBS.Parameters.Variants.FromRegistry.CNC134()});
end TestTwoUnits;
