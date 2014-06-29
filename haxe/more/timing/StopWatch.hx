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
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.Default;
import haxe.PosInfos;
using haxe.more.data.Manipulation;
using Std;

/**
 * A lightweight and fast class to do profiling.
 */
class StopWatch {
	var _times:SingleLinkedList<Float>;
	public var latest(default, null):Float;

	/**
	 * Creates a new stopwatch.
	 */
	public function new() _times = new SingleLinkedList<Float>();
	/**
	 * Saves a timestamp, so you can iterate through it later on.
	 * @return the current time.
	 */
	public function time():Float {
		_times.push(latest = Default.microtime);
		return latest;
	}
	/**
	 * Returns an iterator to iterate trough the timings.
	 * @return an iterator to iterate trough the timings.
	 */
	public function iterator():Iterator<Float>
		return _times.iterator();

	public function toString():String {
		return
			this
			.asEnumerable()
			.delta()
			.select(function(timing) return timing.string() + " ms" + Default.newLine)
			.fold(function(string, folded) return folded + string, "");
	}
}
