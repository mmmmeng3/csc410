function method unpair(n: nat): (nat, nat)
{
	if n == 0 then
		(0, 0)
	else
		var (x, y) := unpair(n - 1);
		if y == 0 then
			(0, x + 1)
		else
			(x + 1, y - 1)
}

function method pick(i: nat): nat
{
	var (x, y) := unpair(i);
	x + i * y
}

function pair(x: nat, y: nat): nat
	ensures unpair(pair(x, y)) == (x, y)
	decreases x + y, x
{
	if x == 0 && y == 0 then
		0
	else if x > 0 then
		pair(x - 1, y + 1) + 1
	else
		pair(y - 1, 0) + 1
}

method catchTheSpy(a: nat, b: nat)
{
	var n := 0;

	var i := 0;
	while a + i * b != pick(i)
		invariant i <= pair(a, b)
		decreases pair(a, b) - i
	{
		i := i + 1;
	}
}
