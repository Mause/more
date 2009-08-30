/**
 * ...
 * @author Dykam
 */

package js.more;
import haxe.Log;
import haxe.PosInfos;
import js.Dom;
import js.Lib;

class Debugging {
	
	static var traceView:HtmlDom;
	static var traceStrings:Array<String>;
	public static function trace(v:Dynamic, ?infos:PosInfos):Void {
		if(traceView == null) {
			traceView = Lib.document.createElement("div");
			traceView.style.position = "fixed";
			traceView.style.top = "0";
			traceView.style.left = "0";
			traceView.style.zIndex = 0xFFFF;
			traceView.style.fontFamily = "Courier New, Courier New, Courier, monospace";
			traceStrings = new Array<String>();
			Lib.document.body.insertBefore(traceView, Lib.document.body.firstChild);
		}
		traceStrings.push(Std.string(v));
		traceView.innerHTML = traceStrings.join("<br />");
		while (traceView.clientHeight > Lib.window.innerHeight) {
			traceStrings.shift();
			traceView.innerHTML = traceStrings.join("<br />");
			// Just joins every string in this array.
		}	
	}
}