Iterable<int> range(int stop) sync* {
	for (int index = 0; index < stop; index++) yield index;
}

class Pair<T> {
	final int index;
	final T value;
	const Pair (this.index, this.value);
}

Iterable<Pair<E>> enumerate<E>(List<E> list) sync* {
	for (final int index in range (list.length)) 
		yield Pair (index, list [index]);
}