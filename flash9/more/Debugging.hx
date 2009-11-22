/**
 * ...
 * @author Mark
 */

package flash.more;
import flash.Boot;
import haxe.Log;
import haxe.PosInfos;

class Debugging {
	public static function trace(v:Dynamic, ?pos:PosInfos):Void {
		Boot.__trace(v, pos);
		var formatted = pos == null ? "(null)" : pos.fileName + ":" + pos.lineNumber;
		untyped __global__["trace"](formatted +": " + Boot.__string_rec(v, ""));
	}
}