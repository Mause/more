/**
 * ...
 * @author 
 */

package haxe.more.data.flow;
import haxe.more.Default;
using Std;

class RangeEnumerator<T> extends BaseEnumerator<T> {
	var _subject:Enumerator<T>;
	var _skip:Int;
	var _take:Int;
	var _state:Int;//-1=clean;0=end;1=taking;2=endless
	
	public function new(subject:Enumerator<T>, skip:Int = 0, take:Int = -1) {
		_subject = subject;
		_skip = Default.max(skip, 0).int();
		_take = take;
		_state = -1;
	}
	
	public override function moveNext():Bool {
		switch(_state) {
			case -1:
				while (_skip != 0) {
					if (!_subject.moveNext()) return false;
					_skip--;
				}
				_state = (_take == -1) ? 2 : 1;
				return moveNext();
			case 1:
				if (_subject.moveNext() && _take != 0) {
					current = _subject.current;
					_take--;
					return true;
				}
				_state = 0;
			case 2:
				if (_subject.moveNext()) {
					current = _subject.current;
					return true;
				}
				_state = 0;		
		}
		return false;
	}
}