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
package flash.more;
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
	
	public function new(stage:Stage):Void {
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseAction);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseAction);
		stage.addEventListener(Event.ENTER_FRAME, action);
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