/** Default.hx
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
using Std;
using haxe.more.data.sources.StringSource;
using haxe.more.data.IterableManipulation;

typedef Disposable = {
	function dispose():Void;
}

class Default {
	static var init = (function() {
		var max = 1;
		while (max > 0) {
			maxInt = max;
			max = (max << 1) | 1;
		}

		newLine = "\n"; // Needs to be replaced with, depending on the platform, OS checks.
	})();

	/**
	 * Returns the highest argument, [a] or[b].
	 * @param	a
	 * @param	b
	 * @return the highest  argument, [a] or[b].
	 */
	public static inline function max(a:Float, b:Float):Float return a > b ? a : b;

	/**
	 * Tests for a float to be NaN/null.
	 * @param	a? The float to test for NaN.
	 * @return True if [a] equals NaN.
	 */
	public static inline function isNaN(?a:Float):Bool return (a == null || Math.isNaN(a) || a.string() == "NaN");

	public static inline function sign(a:Float):Float return (a < 0 ? -1 : 1);

	public static inline function equals(a:Float, b:Float, margin:Float):Bool return (abs(a - b) < margin);


	public static inline function abs(a:Float):Float {
		return a < 0 ? -a : a;
	}

	public static inline function random(max:Float, min:Float = 0) return (Math.random() * (max - min) + min);

	/**
	 * Returns the lowest  argument, [a] or [b].
	 * @param	a
	 * @param	b
	 * @return the lowest  argument, [a] or [b].
	 */
	public static inline function min(a:Float, b:Float):Float return a < b ? a : b;

	public static inline function as<T>(subject:Dynamic, to:Class<T>):T
		return subject.is(to) ? subject : null;

	public static inline function isNullOrEmpty(string:String):Bool
		return string == null || string == "";

	public static function isNullOrWhiteSpace(string:String):Bool
		return string == null || string.iterable().all(function(char) return " \t\r\n".indexOf(char) != -1)

	/**
		Gets the current time in milliseconds.
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

	public static var newLine(default, null):String;

	public static inline function even(value:Int):Bool {
		return value & 1 == 1;
	}
	public static inline function uneven(value:Int):Bool {
		return !even(value);
	}
}
