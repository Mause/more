/**
 * ...
 * @author Dykam
 */

package haxe.more;

class Helpers {
	/**
		Get's the current time in miliseconds.
	**/
	public static var microtime(get_time, null):Float;
	static function get_time():Float {
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
}