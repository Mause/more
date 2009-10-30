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
import haxe.more.Default;
import haxe.more.exceptions.ArgumentNullException;
using haxe.more.data.sources.Integer;
using haxe.more.data.Manipulation;

class Integer {
	public static function to(from:Int, to:Int, step:Int = 1):Iterable<Int>
		return new IntRangeIterable(from, to, step)
	
	public inline static var naturals(gNaturals, null):Iterable<Int>;
	inline static function gNaturals() return 0.to(Default.maxInt)
	
	public inline static var evenNaturals(gEvenNaturals, null):Iterable<Int>;
	inline static function gEvenNaturals() return 0.to(Default.maxInt, 2)
	
	public inline static var unevenNaturals(gUnevenNaturals, null):Iterable<Int>;
	inline static function gUnevenNaturals() return 1.to(Default.maxInt, 2)
}
class IntRangeIterable {
	var _from:Int;
	var _to:Int;
	var _step:Int;
	public function new(from:Int, to:Int, step:Int = 1) {
		_from = from;
		_to = to;
		_step = step;
	}
	public function iterator():Iterator<Int>
		return new IntRangeIterator(_from, _to)
}
class IntRangeIterator {
	var _from:Int;
	var _to:Int;
	var _step:Int;
	public function new(from:Int, to:Int, step:Int = 1) {
		_from = from;
		_to = to;
		_step = step;
	}
	public function hasNext() return _from < _to
    public function next() {
		var result = _from;
		_from += _step;
		return result;
	}
}