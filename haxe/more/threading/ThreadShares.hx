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

class ThreadShares {
	static var init = (function() {
		Critical = 512;
		Important = 256;
		Low = 64;
		Medium = 128;
		RealTime = Helpers.maxInt;		
	}());
	
	/**
	 * Critical share. Threads with this share get twice as many steps as threads with ThreadPriority.Important.
	 */
	public static var Critical(default, null):Int;
	/**
	 * Important share. Threads with this share get twice as many steps as threads with ThreadPriority.Medium.
	 */
	public static var Important(default, null):Int;
	/**
	 * Low share. Threads with this share get half the number of steps as threads with ThreadPriority.Medium. This share can be used for threads that do
	 *  not have to be stapped.
	 */
	public static var Low(default, null):Int;
	/**
	 * Medium share. This share can be used for normal threads.
	 */
	public static var Medium(default, null):Int;
	/**
	 * Realtime share. this process will retrieve virtually all cpu time.
	 */
	public static var RealTime(default, null):Int;
}