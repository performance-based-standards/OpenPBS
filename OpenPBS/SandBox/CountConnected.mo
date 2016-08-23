within OpenPBS.SandBox;
function CountConnected
  "Count number of connected true values in boolean vector"
  input Boolean b[:];

  output Integer n "Number of connected sets";
algorithm
  n:=1;
  for i in 2:length(b) loop
    if b[i] and not b[i-1] then
      n:=n + 1;
    end if;
  end for;
end CountConnected;
