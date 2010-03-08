package haxe.more.data.flow;

interface Enumerator#if!H<T>#end {
	function moveNext():Bool;
	var current(default, null):T;
}