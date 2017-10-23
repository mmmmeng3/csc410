// This takes about 10 seconds to verify

method stoogeSort(a: array<int>, left: int, right: int)
	requires a != null
	requires 0 <= left <= right < a.Length
	modifies a
	decreases right - left
	ensures forall i :: 0 <= i < left || right < i < a.Length ==> a[i] == old(a[i])
	ensures forall i :: left <= i <= right ==> exists j :: left <= j <= right && a[i] == old(a[j])
	ensures forall i, j :: left <= i < j <= right ==> a[i] <= a[j]
	ensures forall x :: count(a[..], 0, a.Length, x) == count(old(a[..]), 0, a.Length, x)
{
	if a[left] > a[right]
	{
		// swap a[left] and a[right]
		var tmp := a[left];
		a[left] := a[right];
		a[right] := tmp;

		assert old(a[..]) == a[..][left := a[right]][right := a[left]];
		countSwap(a[..], 0, a.Length, left, right);
	}

	if left + 1 >= right
	{
		return;
	}

	var k := (right - left + 1) / 3;

	stoogeSort(a, left, right - k); // First two-thirds

	ghost var a' := a[..];
	countRange(a', left + k, right - k + 1, right + 1, a[left + k - 1]);
	assert count(a', left + k, right + 1, a[left + k - 1]) > (right - k) - (left + k);

	stoogeSort(a, left + k, right); // Last two-thirds

	ghost var a'' := a[..];
	countInner(a', a'', left + k, right + 1);
	countPigeon(a'', left + k, right + 1, a[left + k - 1]);
	assert a[left + k - 1] <= a[right - k + 1];

	stoogeSort(a, left, right - k); // First two-thirds again
}

function count(xs: seq<int>, l: int, r: int, x: int): int
	requires 0 <= l <= r <= |xs|
	ensures 0 <= count(xs, l, r, x) <= r - l
	decreases r - l
{
	if l == r then
		0
	else
		(if xs[l] >= x then 1 else 0) + count(xs, l + 1, r, x)
}

lemma countSplit(xs: seq<int>, l: int, m: int, r: int)
	requires 0 <= l <= m <= r <= |xs|
	ensures forall x :: count(xs, l, r, x) == count(xs, l, m, x) + count(xs, m, r, x)
	decreases r - l
{ }

lemma countEqual(xs: seq<int>, ys: seq<int>, l: int, r: int)
	requires 0 <= l <= r <= |xs| == |ys|
	requires forall i :: l <= i < r ==> xs[i] == ys[i]
	ensures forall x :: count(xs, l, r, x) == count(ys, l, r, x)
	decreases r - l
{ }

lemma countSwap(xs: seq<int>, l: int, r: int, i: int, j: int)
	requires 0 <= l <= i < j < r <= |xs|
	ensures forall x :: count(xs[i := xs[j]][j := xs[i]], l, r, x) == count(xs, l, r, x)
{
	var ys := xs[i := xs[j]][j := xs[i]];

	countSplit(ys, l, j + 1, r);
	countSplit(ys, l, j, j + 1);
	countSplit(ys, l, i + 1, j);
	countSplit(ys, l, i, i + 1);
	countSplit(xs, l, j + 1, r);
	countSplit(xs, l, j, j + 1);
	countSplit(xs, l, i + 1, j);
	countSplit(xs, l, i, i + 1);
	countEqual(xs, ys, l, i);
	countEqual(xs, ys, i + 1, j);
	countEqual(xs, ys, j + 1, r);

	assert forall x ::
		count(ys, l, r, x)
		== count(ys, l, j + 1, x) + count(ys, j + 1, r, x)
		== count(ys, l, j, x)     + count(ys, j, j + 1, x) + count(ys, j + 1, r, x)
		== count(ys, l, i + 1, x) + count(ys, i + 1, j, x) + count(ys, j, j + 1, x) + count(ys, j + 1, r, x)
		== count(ys, l, i, x)     + count(ys, i, i + 1, x) + count(ys, i + 1, j, x) + count(ys, j, j + 1, x) + count(ys, j + 1, r, x)
		== count(xs, l, i, x)     + count(xs, i, i + 1, x) + count(xs, i + 1, j, x) + count(xs, j, j + 1, x) + count(xs, j + 1, r, x)
		== count(xs, l, i + 1, x) + count(xs, i + 1, j, x) + count(xs, j, j + 1, x) + count(xs, j + 1, r, x)
		== count(xs, l, j, x)     + count(xs, j, j + 1, x) + count(xs, j + 1, r, x)
		== count(xs, l, j + 1, x) + count(xs, j + 1, r, x)
		== count(xs, l, r, x);
}

lemma countInner(xs: seq<int>, ys: seq<int>, l: int, r: int)
	requires 0 <= l <= r <= |xs| == |ys|
	requires forall i :: 0 <= i < l || r <= i < |xs| ==> xs[i] == ys[i]
	requires forall x :: count(xs, 0, |xs|, x) == count(ys, 0, |ys|, x)
	ensures forall x :: count(xs, l, r, x) == count(ys, l, r, x)
{
	countSplit(xs, 0, r, |xs|);
	countSplit(xs, 0, l, r);
	countSplit(ys, 0, r, |xs|);
	countSplit(ys, 0, l, r);
	countEqual(xs, ys, 0, l);
	countEqual(xs, ys, r, |xs|);

	assert forall x ::
		count(xs, l, r, x)
		== count(xs, 0, |xs|, x) - count(xs, 0, l, x) - count(xs, r, |xs|, x)
		== count(ys, 0, |ys|, x) - count(ys, 0, l, x) - count(ys, r, |ys|, x)
		== count(ys, l, r, x);
}

lemma countRange(xs: seq<int>, l: int, m: int, r: int, x: int)
	requires 0 <= l <= m <= r <= |xs|
	requires forall i :: l <= i < m ==> xs[i] >= x
	ensures count(xs, l, r, x) >= m - l
	decreases r - l
{ }

lemma countPigeon(xs: seq<int>, l: int, r: int, x: int)
	requires 0 <= l <= r <= |xs|
	requires forall i, j :: l <= i < j < r ==> xs[i] <= xs[j]
	ensures forall i :: r - count(xs, l, r, x) <= i < r ==> xs[i] >= x
	decreases r - l
{ }
