/** LimitedCapacityQueue.hx
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
package haxe.more.data.structures;

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