/** Debugging.hx
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
package js.more;
import haxe.Log;
import haxe.PosInfos;
import js.Dom;
import js.Lib;

class Debugging {	
	static var traceView:HtmlDom;
	static var traceStrings:Array<String>;
	/**
	 * A trace function inspired by the default haxe flash trace.
	 */
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