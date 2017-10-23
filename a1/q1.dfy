predicate sorted(a: array<int>, l1: int, u1: int)
	requires a != null 
	reads a
{
	forall i,j::  (0 <= i && j < a.Length && l1 <= i <= j <= u1) ==> a[i] <= a[j]
}

method insertSort(a : array<int>)
  requires a != null;
  modifies a;
  ensures sorted (a, 0, a.Length - 1)
{
    var i := 1;
    while (i < a.Length)
      invariant sorted(a, 0, i-1);
    {
        var j := i;
        var value := a[i];
        a[i] := a[i-1];
        while (j > 0 && a[j-1] > value)
          invariant sorted(a, 0, i)  
                    && (forall k :: j + 1 <= k <= i ==> value <= a[k])
										
        {
            a[j] := a[j-1];
            j := j - 1;
        }
				assert j == 0 || value >= a[j-1]; 
        a[j] := value;
        i := i + 1;
    }
}
