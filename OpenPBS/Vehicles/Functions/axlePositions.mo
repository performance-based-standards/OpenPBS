within OpenPBS.Parameters.Functions;
function axlePositions "Calculate axle positions relative first axle"
  input Integer na;

  input Modelica.SIunits.Length wheelbase[na];

  output Modelica.SIunits.Position L[na];
algorithm
  L[1]:=0;
  for i in 2:na loop
    L[i]:=L[i - 1] - wheelbase[i - 1];
  end for;
end axlePositions;
