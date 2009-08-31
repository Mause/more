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
import js.Dom;
import js.Lib;

class Graphics {
	public var base:HtmlDom;
	public function new():Void {
		setUp();
	}
	private function setUp():Void {
		base = Lib.document.createElement("div");
		base.className = "graphicsCore";
		base.style.position = "fixed";
		base.style.padding = "0";
		base.style.margin = "0";
		base.style.left = "0";
		base.style.top = "0";
		base.style.width = "100%";
		base.style.height = "100%";
		Lib.document.body.appendChild(base);		
	}
	public function drawRect(x:Int, y:Int, width:Int, height:Int, ?backgroundColor:String, ?borderColor:String, ?borderSize:Int):HtmlDom {
		var block:HtmlDom = Lib.document.createElement("div");
		block.className = "drawedSquare";
		if(backgroundColor != null) block.style.background = backgroundColor;
		if(borderColor != null) block.style.border = borderColor + (borderSize != null ? Std.string(borderSize) : "");
		block.style.position = "absolute";
		block.style.padding = "0";
		block.style.margin = "0";
		block.style.left = Std.string(x) + "px";
		block.style.top = Std.string(y) + "px";
		block.style.width = Std.string(width) + "px";
		block.style.height = Std.string(height) + "px";
		base.appendChild(block);
		return block;
	}
	public function drawCircle(x:Int, y:Int, radius:Int, ?color:String):HtmlDom {
		var circle:HtmlDom = Lib.document.createElement("div");
		circle.className = "drawedCircle";
		circle.innerHTML = "&bull;";
		circle.style.position = "absolute";
		circle.style.padding = "0";
		circle.style.margin = "0";
		circle.style.fontSize = Std.string(radius*4) + "px";
		circle.style.left = Std.string(x- (.2 * radius)) + "px";
		circle.style.top = Std.string(y-(1.9 * radius)) + "px";
		circle.style.width = Std.string(radius) + "px";
		circle.style.height = Std.string(radius) + "px";
		if(color != null) circle.style.color = color;
		base.appendChild(circle);
		return circle;
	}
	public function clear():Void {
		Lib.document.body.removeChild(base);
		setUp();
	}
	public function dispose():Void {
		Lib.document.body.removeChild(base);
	}
}