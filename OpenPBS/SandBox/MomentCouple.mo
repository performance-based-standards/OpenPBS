within OpenPBS.SandBox;
function MomentCouple "Determine moment coupled units"
  input Integer nu;
  input Integer nc "Number of coupled systems";
  input Boolean[nu-1] roll_couple;

  input Modelica.SIunits.Torque M[nu];

  output Modelica.SIunits.Torque Msum[nc];
protected
  Integer i,j;
algorithm
  i:=1;
  j:=1;
  Msum[i] := M[j] "First group always includes first unit";
  for i in 1:nu-1 loop
    if roll_couple[i] then
      Msum[j] :=Msum[j] + M[i + 1];
    else
      j:=j + 1;
      Msum[j] :=M[i + 1];
    end if;
  end for;

end MomentCouple;
