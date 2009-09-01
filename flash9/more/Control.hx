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
import flash.display.DisplayObject;
import flash.events.KeyboardEvent;
import flash.Lib;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

class Control {
	/** Mouse **/
	public var mouseDown(default, null):Bool;
	public var mouseUp(default, null):Bool;
	/**
	 * Automatically resets after each frame.
	 */
	public var mouseClicked(default, null):Bool;
	
	public function new(object:DisplayObject):Void {
		object.addEventListener(MouseEvent.MOUSE_DOWN, mouseAction);
		object.addEventListener(MouseEvent.MOUSE_UP, mouseAction);
		object.addEventListener(Event.ENTER_FRAME, action);
		mouseClicked = false;
	}	
	private function action(e:Event):Void {
		switch(e.type) {
			case Event.ENTER_FRAME:
				mouseClicked = false;
		}
	} 
	private function mouseAction(e:MouseEvent):Void {
		switch(e.type) {
			case MouseEvent.MOUSE_DOWN:
				mouseUp = !(mouseDown = true);
			case MouseEvent.MOUSE_UP:
				mouseUp = !(mouseDown = false);
			case MouseEvent.CLICK:
				mouseClicked = true;
		}	
	}
	
	
	/** Keyboard **/
	static var keys;
	public static function isKeyDown(keyCode:Int):Bool {
		ready();
		return keys[keyCode];
	}
	
	static function ready() {
		if(keys == null) {
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			var k = new Array<Bool>();
			for (i in 0...256) {
				k.push(false);
			}
			keys = k;
		}
	}
	
	static private function keyUp(e:KeyboardEvent):Void {
		ready();
		keys[e.charCode] = false;
	}
	
	static private function keyDown(e:KeyboardEvent):Void {
		ready();
		keys[e.charCode] = true;	
	}
}