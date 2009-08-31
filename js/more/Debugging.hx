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