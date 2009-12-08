/**
 * ...
 * @author Mark
 */

package haxe.more;
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.exceptions.NotImplementedException;
using haxe.more.data.Manipulation;

class StringBuilder {
	var _strings:SingleLinkedList<String>;
	var _newLine:String;
	public function new(?initial:Iterable<String>) {
		_strings = new SingleLinkedList(initial);
	}
	
	public function append(string:String):StringBuilder {
		_strings.push(string);
		return this;
	}
	
	public function appendLine(string:String):StringBuilder {
		return append(string).append(Default.newLine);
	}
	
	public function iterator():Iterator<String> {
		return _strings.iterator();
	}
	
	public function toString():String {
		//var length = _strings.sumGeneric(function(s) return s.length);
		var string = "";
		for (s in _strings)
			string += s;
		return string;
	}
}