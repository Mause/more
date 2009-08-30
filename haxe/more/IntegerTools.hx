/**
 * ...
 * @author Mark
 */

package haxe.more;

class IntegerTools {
	public static function even(value:Int):Bool {
		return (value % 2) == 0;
	}
	public static function to(from:Int, to:Int):Iterable<Int> {
		return new IntRangeIterable(from, to);
	}
}
class IntRangeIterable {
	private var _from:Int;
	private var _to:Int;
	public function new(from:Int, to:Int):Void {
		_from = from;
		_to = to;
	}
	public function iterator():Iterator<Int> {
		return new IntRangeIterator(_from, _to);
	}
}
class IntRangeIterator {
	private var _from:Int;
	private var _to:Int;
	public function new(from:Int, to:Int):Void {
		_from = from;
		_to = to;
	}
	public function hasNext():Bool {
		return _from < _to;
    }

    public function next():Int {
		return _from++;
    }
}