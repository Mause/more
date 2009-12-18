package haxe.more.data.flow;

interface Enumerable<T> {
	function getEnumerator():Enumerator<T>;
}