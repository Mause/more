/** ThreadShares.hx
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

class ThreadShares {
	static var init = (function() {
		Critical = 512;
		Important = 256;
		Low = 64;
		Medium = 128;
		RealTime = Default.maxInt;		
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