/** Helpers.hx
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
package haxe.more;
import haxe.more.threading.ThreadShares;

class Helpers {
	static var init = (function() {
		var max = 1;
		while (max > 0) {
			maxInt = max;
			max = (max << 1) | 1;
		}
	})();
	
	/**
		Get's the current time in miliseconds.
	**/
	public static inline var microtime(get_time, null):Float;
	static inline function get_time():Float {
		#if flash
		return flash.Lib.getTimer();
		#elseif php
		return untyped __php__("microtime()");
		#elseif cpp
		return cpp.Sys.time();
		#else
		return Date.now().getTime();
		#end
	}
	public static var maxInt(default, null):Int;
	
	public static inline function even(value:Int):Bool {
		return value & 1 == 1;
	}
	public static inline function uneven(value:Int):Bool {
		return !even(value);
	}
}