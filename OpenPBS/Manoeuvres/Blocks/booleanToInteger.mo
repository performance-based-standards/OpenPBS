within OpenPBS.Manoeuvres.Blocks;
function booleanToInteger
  input Boolean u;
  output Integer y;
algorithm
  y :=if u then 1 else 0;
end booleanToInteger;
