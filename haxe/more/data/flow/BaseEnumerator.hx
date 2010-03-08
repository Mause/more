/**
 * ...
 * @author 
 */

package haxe.more.data.flow;
import haxe.more.exceptions.NotImplementedException;

class BaseEnumerator#if!H<T>#end implements Enumerator<T> {
	public var current(default, null):T;
	
	public function moveNext():Bool {
		throw new NotImplementedException("moveNext");
		return false;
	}
	
	public function toString():String {
		return Std.string("[...," + current + ",...]");
	}
}