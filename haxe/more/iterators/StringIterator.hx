/**
 * ...
 * @author ...
 */

package haxe.more.iterators;

class StringIterator {
	private var index:Int;
	private var string:String;
	private var r:Bool;
	public function new(s:String, ?reverse:Bool) {
		r = reverse;
		index = reverse ? s.length : 0;
		string = s;
	}
	public function hasNext():Bool {
		return r ? (index > 0) : (index < string.length);
	}
	public function next():String {
		return string.charAt(r ? --index : index++);
	}

}