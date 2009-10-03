/** Control.hx
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
package flash.more;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import haxe.more.exceptions.ArgumentNullException;

class Control {
	var keys:Array<Bool>;
	
	public var mouseDown(default, null):Bool;
	public var mouseUp(default, null):Bool;
	// Automatically resets after each frame.
	public var mouseClicked(default, null):Bool;
	
	public function new(object:EventDispatcher):Void {
		if (object == null) throw new ArgumentNullException("object");
		object.addEventListener(MouseEvent.MOUSE_DOWN, mouseIsDown);
		object.addEventListener(MouseEvent.MOUSE_UP, mouseIsUp);
		object.addEventListener(MouseEvent.CLICK, mouseIsClicked);
		object.addEventListener(Event.ENTER_FRAME, enterFrame);
		mouseClicked = false;
		
		object.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		object.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		var k = new Array<Bool>();
		for (i in 0...256) {
			k.push(false);
		}
		keys = k;
	}
	
	public function isKeyDown(keyCode:Int):Bool return keys[keyCode]
	public function isKeyUp(keyCode:Int):Bool return !keys[keyCode]
	
	function enterFrame(e:Event) mouseClicked = false	
	function mouseIsDown(e:MouseEvent) mouseUp = !(mouseDown = true)
	function mouseIsUp(e:MouseEvent) mouseUp = !(mouseDown = false)
	function mouseIsClicked(e:MouseEvent) mouseClicked = true	
	function keyUp(e:KeyboardEvent) keys[e.keyCode] = false	
	function keyDown(e:KeyboardEvent) keys[e.keyCode] = true
}