package haxe.more.data.flow;

interface Enumerator<T> {
	function moveNext():Bool;
	var current(default, null):T;
}