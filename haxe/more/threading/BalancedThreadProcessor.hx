/**
 * Copyright (c) 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the University of California, Berkeley nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package haxe.more.threading;
import haxe.more.Helpers;
import haxe.more.threading.Threading;

class BalancedThreadProcessor {
	// Is negative it the processor used more time than allowed in the previous run. It is an extra stabelizing mechanism.
	var _karma:Float;
	// The base node, simplifying modifications on the list.
	var _sentinel:LinkedThreadListNode;
	var _last:LinkedThreadListNode;
	var _disposeAtExhaustion:Bool;

	public function new(disposeAtExhaustion:Bool = false) {
		_last = _sentinel = new LinkedThreadListNode(null);
		_disposeAtExhaustion = disposeAtExhaustion;
		_karma = 0;
	}
	
	public function add(thread:ThreadRunnerDelegate, priority:Int = 128):AdjustThreadShareDelegate {
		_last = new LinkedThreadListNode(thread, _last);
		_last.share = priority;
		updateShares();
		var f:AddThreadDelegate = add;
		return adjust;
	}
	
	public function adjust(thread:ThreadRunnerDelegate, priority:Int):Bool {
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
		var current = _sentinel;
		var previous = _sentinel;
		while ((current = current.next) != null) {
			if (current.thread == thread) {
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
		var endTime = Helpers.microtime + _karma;

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
					var startTime = Helpers.microtime;
					if (current.thread(Std.int(current.timeLeft))) {
						remove(current.thread);
					} else {
						current.timeLeft -= Helpers.microtime - startTime;
					}
				}
			} while ((current = current.next) != null);
		} while (endTime > Helpers.microtime);
		
		_karma = endTime - Helpers.microtime;
		if (_karma > 0) _karma = 0;
		
		return false;
	}
	
	private function updateShares():Void {
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