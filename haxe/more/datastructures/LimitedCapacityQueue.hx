/**
 * ...
 * @author Mark
 */

package haxe.more.datastructures;

class LimitedCapacityQueue < T > extends Queue < T > {
	public var maxLength(getMaxLength, setMaxLength):Int;
	private var _maxLength:Int;
	public var full(isFull, null):Bool;
	public function new(maxLength:Int) {
		super();
		_maxLength = maxLength;
	}
	private function isFull():Bool {
		return length > maxLength;
	}
	private function getMaxLength():Int {
		return _maxLength;
	}
	private function setMaxLength(value:Int):Int {
		if (value < 0) {
			_maxLength = 0;
		} else {
			_maxLength = value;
		}
		cleanUp();
		return _maxLength;
	}
	public override function push(value:T):T {
		var result:T = super.push(value);
		cleanUp();
		return result;
	}
	private function cleanUp():Void {
		while (length > _maxLength) {
			pop();
		}
	}
}