/** Processing.hx
 *
 * Copyright 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 * http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/
package haxe.more.data;
import haxe.more.data.flow.Enumerable;
import haxe.more.data.flow.Enumerator;
import haxe.Timer;
import haxe.more.exceptions.ArgumentNullException;
using haxe.more.data.Processing;

class Processing {	
	public static function evaluate<T>(subject:Enumerable<T>, timeSpan:Int = 0, evaluationsPerTick:Int = 1, ?completed:Void -> Void):Void {
		if (subject == null) throw new ArgumentNullException("subject");
		var ator = subject.getEnumerator();
		if (timeSpan != 0) {
			if (evaluationsPerTick != 1) {
				var evaluations:Int;
				var t = new Timer(timeSpan);
				t.run = function() {
					evaluations = evaluationsPerTick;
					while(evaluations-- != 0) {
						if (!ator.moveNext()) {
							t.stop();
							if(completed != null) completed();
							break;
						}
					}
				};
			} else {
				var t = new Timer(timeSpan);
				t.run = function() {
					if (!ator.moveNext()) {
						t.stop();
						if(completed != null) completed();
					}
				};
			}
		} else {
			while (ator.moveNext()) {}
			if(completed != null) completed();
		}
	}
	
	public static function trace<T>(subject:Enumerable<T>):Enumerable<T> {
		return subject.apply(function(item) trace(item));
	}
	
	public static function apply<T>(subject:Enumerable<T>, action: T -> Void):Enumerable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (action == null) throw new ArgumentNullException("action");
		return new ApplyEnumerable(subject, action);
	}
}

private class ApplyEnumerable<T> implements Enumerable<T> {
	var _subject:Enumerable<T>;
	var _action: T -> Void;
	
	public function new(subject:Enumerable<T>, action: T -> Void) {
		_subject = subject;
		_action = action;
	}
	
	public function getEnumerator():Enumerator<T> {
		return new ApplyEnumerator(_subject.getEnumerator(), _action);
	}
}
private class ApplyEnumerator<T> implements Enumerator<T> {
	var _subject:Enumerator<T>;
	var _action: T -> Void;
	
	public var current(default, null):T;
	
	public function new(subject:Enumerator<T>, action: T -> Void) {
		_subject = subject;
		_action = action;
	}
	
	public function moveNext():Bool {
		if (_subject.moveNext()) {
			current = _subject.current;
			_action(current);
			return true;
		}
		return false;
	}
}