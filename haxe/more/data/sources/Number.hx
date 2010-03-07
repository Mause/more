/** Integer.hx
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
package haxe.more.data.sources;
import haxe.more.data.flow.Enumerable;
import haxe.more.data.flow.Enumerator;
import haxe.more.Default;
import haxe.more.exceptions.ArgumentNullException;
using haxe.more.data.sources.Number;
using haxe.more.data.Manipulation;

class Number {
	public inline static var evenNaturals(gEvenNaturals, null):Enumerable<Int>;
	inline static function gEvenNaturals() return 0.to(Default.maxInt, 2)
	
	public inline static var naturals(gNaturals, null):Enumerable<Int>;
	inline static function gNaturals() return 0.to(Default.maxInt)
	
	public inline static var random(gRandom, null):Enumerable<Float>;
	inline static function gRandom() return Functions.endlessGather(Math.random)
	
	public static function to(from:Int, to:Int, step:Int = 1):Enumerable<Int>
		return new IntRangeEnumerable(from, to, step)
	
	public inline static var unevenNaturals(gUnevenNaturals, null):Enumerable<Int>;
	inline static function gUnevenNaturals() return 1.to(Default.maxInt, 2)
}
class IntRangeEnumerable implements Enumerable<Int> {
	var _from:Int;
	var _to:Int;
	var _step:Int;
	public function new(from:Int, to:Int, step:Int = 1) {
		_from = from;
		_to = to;
		_step = step;
	}
	public function getEnumerator():Enumerator<Int>
	return new IntRangeEnumerator(_from, _to, _step)
}
class IntRangeEnumerator implements Enumerator<Int> {
	var _state:Int; // -1=clean;0=end;1=taking
	var _to:Int;
	var _step:Int;
	
	public var current(default, null):Int;
	
	public function new(from:Int, to:Int, step:Int = 1) {
		current = from;
		_to = to;
		_step = step;
		_state = -1;
	}
	
	public function moveNext():Bool {
		switch(_state) {
			case -1:
				_state = 1;
				_state = current >= _to ? 0 : 1;
				return true;
			case 1:
				if(current + _step >= _to) {
					_state = 0;
					return false;
				}
				current += _step;
				return true;
		}
		return false;
	}
	
}