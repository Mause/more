/** Stopwatch.hx
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
package haxe.more.timing;

class StopWatch {
	var _times:SingleLinkedList<Float>;
	public var latest(default, null):Float;
	
	public function new() _times = new SingleLinkedList<Float>()
	public function time() return {
		_times.push(latest = Helpers.microtime);
		return latest;
	}
	public function iterator()
		return _times.fold(
			function(item:Float, seed: { previous:Float, array:Array<Float> }) {
				if (seed == null) {
					seed = { previous: item, array: new Array<Float>() };
				} else {
					seed.array.push(item - seed.previous);
					seed.previous = item;
				}
				return seed;
			}
		).array.iterator()			
}