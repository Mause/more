/** BalancedThreadProcessor.hx
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
package haxe.more.threading;
import haxe.more.Default;
import haxe.more.threading.Threading;
import haxe.more.exceptions.ArgumentNullException;

class BalancedThreadProcessor {
	// Is negative it the processor used more time than allowed in the previous run. It is an extra stabelizing mechanism.
	var _karma:Float;
	// The base node, simplifying modifications on the list.
	var _sentinel:LinkedThreadListNode;
	var _last:LinkedThreadListNode;
	var _disposeAtExhaustion:Bool;
	
	public var threads(default, null):Int;

	public function new(disposeAtExhaustion:Bool = false) {
		_last = _sentinel = new LinkedThreadListNode(null);
		_disposeAtExhaustion = disposeAtExhaustion;
		_karma = 0;
	}
	
	public function add(thread:ThreadRunnerDelegate, priority:Int = 128):AdjustThreadShareDelegate {
		if (thread == null) throw new ArgumentNullException("thread");
		threads++;
		_last = new LinkedThreadListNode(thread, _last);
		_last.share = priority;
		updateShares();
		var f:AddThreadDelegate = add;
		return adjust;
	}
	
	public function adjust(thread:ThreadRunnerDelegate, priority:Int):Bool {
		if (thread == null) throw new ArgumentNullException("thread");
		var current = _sentinel;
		while ((current = current.next) != null) {
			if (current.thread == thread) {
				current.share = priority;
				updateShares();
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Removes a thread.
	 * @param	thread the thread to remove.
	 * @return Returns true if the thread was found and removed.
	 */
	public function remove(thread:ThreadRunnerDelegate):Bool {
		if (thread == null) throw new ArgumentNullException("thread");
		var current = _sentinel;
		var previous = _sentinel;
		while ((current = current.next) != null) {
			if (current.thread == thread) {
				threads--;
				previous.next = current.next;
				if (_sentinel.next == null) {
					_last = _sentinel;
				}
				updateShares();
				return true;
			}
			previous = current;
		}
		return false;
	}
	
	public function process(time:Int):Bool {
		// No threads, no job
		if (_sentinel.next == null) {
			return _disposeAtExhaustion;
		}
		
		// If it used up waaay to much time the previous run, halt for a while.
		_karma += time;
		if (_karma <= 0) return false;
		
		// Start the payment of time here, saving the starting time in endTime.
		var endTime = Default.microtime + _karma;

		// Prepare the threads
		var current = _sentinel.next;
		do {
			current.timeLeft += _karma * current.relativeShare;
		} while ((current = current.next) != null);
		
		// Start executing the threads untill no time is left
		do {
			// check if there are threads left.
			if ((current = _sentinel.next) == null) {
				break;
			}
			//Ok, this is where the real hard job is done
			do {
				if(current.timeLeft > 0) {
					var startTime = Default.microtime;
					if (current.thread(Std.int(current.timeLeft))) {
						remove(current.thread);
					} else {
						current.timeLeft -= Default.microtime - startTime;
					}
				}
			} while ((current = current.next) != null);
		} while (endTime > Default.microtime);
		
		_karma = endTime - Default.microtime;
		if (_karma > 0) _karma = 0;
		
		return false;
	}
	
	function updateShares():Void {
		if (_sentinel.next == null) return;
		var totalShare = 0.0;
		var current = _sentinel.next;
		do {
			totalShare += current.share;
		} while ((current = current.next ) != null);
		
		current = _sentinel.next;
		do {
			current.relativeShare = current.share / totalShare;
		} while ((current = current.next )!= null);
	}	
}
class LinkedThreadListNode {
	public var next:LinkedThreadListNode;
	public var thread:ThreadRunnerDelegate;
	public var relativeShare:Float;
	public var timeLeft:Float;
	public var share:Int;
	
	public function new(thread:ThreadRunnerDelegate, ?previous:LinkedThreadListNode) {
		this.thread = thread;
		relativeShare = timeLeft = 0;
		if (previous != null) {
			this.next = previous.next;
			previous.next = this;
		}
	}
}