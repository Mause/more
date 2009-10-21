/**
 * ...
 * @author Mark
 */

package haxe.more.data.sources;

class ExposedIterable<T> {
	var _next: Void -> T;
	var _hasNext: Void -> Bool;
	public function new(next: Void -> T, hasNext: Void -> Bool) {
		_next = next;
		_hasNext = hasNext;
	}
	
	public function iterator():Iterator<T>
		return new ExposedIterator(_next, _hasNext)
}
class ExposedIterator<T> {
	var _next: Void -> T;
	var _hasNext: Void -> Bool;
	public function new(next: Void -> T, hasNext: Void -> Bool) {
		_next = next;
		_hasNext = hasNext;
	}
	
	public function hasNext() return _hasNext()
	public function next() return _next()
}