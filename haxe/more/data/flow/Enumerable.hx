package haxe.more.data.flow;

interface Enumerable#if!H<T>#end {
	function getEnumerator():Enumerator<T>;
}