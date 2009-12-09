package haxe.more.data.flow;

interface Enumerable<T> {
	function getEnumerator():IEnumerator<T>;
}
/*
interface Enumerable<T> {
	var enumerator(getEnumerator, null):IEnumerator<T>;
}
*/