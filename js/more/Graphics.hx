/** Graphics.hx
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
import js.Dom;
import js.Lib;

class Graphics {
	var _base:HtmlDom;
	
	public function new() setUp()
	
	private function setUp():Void {
		_base = Lib.document.createElement("div");
		_base.className = "graphicsCore";
		_base.style.position = "fixed";
		_base.style.padding = "0";
		_base.style.margin = "0";
		_base.style.left = "0";
		_base.style.top = "0";
		_base.style.width = "100%";
		_base.style.height = "100%";
		Lib.document.body.appendChild(_base);		
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
		_base.appendChild(block);
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
		_base.appendChild(circle);
		return circle;
	}
	public function clear():Void {
		Lib.document.body.removeChild(_base);
		setUp();
	}
	public function dispose():Void {
		Lib.document.body.removeChild(_base);
	}
}