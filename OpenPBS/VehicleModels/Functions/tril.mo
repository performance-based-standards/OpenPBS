within OpenPBS.VehicleModels.Functions;
function tril "Create n x n triangular lower matrix"
  input Integer n;
  output Integer m[n,n];
algorithm
  for i in 1:n loop
    for j in 1:n loop
      if i>=j then
        m[i,j]:=1;
      else
        m[i,j]:=0;
      end if;
    end for;
  end for;
end tril;
