/** AdvancedStopWatch.hx
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
using haxe.more.Default;
using haxe.more.data.Manipulation;

class AdvancedStopWatch {
	var _times:SingleLinkedList<Timing>;
	public var latest(default, null):Float;

	/**
	 * Creates a new stopwatch.
	 */
	public function new() _times = new SingleLinkedList<Timing>();
	/**
	 * Saves a timestamp, so you can iterate through it later on.
	 * @return the current time.
	 */
	public function time(?message:String, ?posInfos:PosInfos):Float {
		_times.push(new Timing(latest = Default.microtime, message, posInfos));
		return latest;
	}
	/**
	 * Returns an iterator to iterate trough the timings.
	 * @return an iterator to iterate trough the timings.
	 */
	public function iterator():Iterator<Timing>
		return _times.iterator();

	public function toString():String {
		return
			this
			.asEnumerable()
			.historyDuo(function(first, second)
				return first.posInfos.fileName
					+ (first.message.isNullOrWhiteSpace() ? ": " : "(\"" + first.message + "\"): ")
					+ first.posInfos.lineNumber
					+ " -> "
					+ second.posInfos.fileName
					+ (second.message.isNullOrWhiteSpace() ? ": " : "(\"" + second.message + "\"): ")
					+ second.posInfos.lineNumber
					+ ": "
					+ (second.time - first.time)
					+ " ms"
					+ Default.newLine)
			.fold(function(string, folded) return folded + string, "");
	}
}

class Timing {
	public var time:Float;
	public var message:String;
	public var posInfos:PosInfos;
	public function new(time:Float, message:String, posInfos:PosInfos) {
		this.time = time;
		this.posInfos = posInfos;
		this.message = message;
	}
}
