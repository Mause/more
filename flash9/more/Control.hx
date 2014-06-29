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
import flash.ui.Keyboard;
import org.hsl.Signaler;
import org.hsl.SlotList;
import haxe.more.exceptions.ArgumentNullException;

class Control {
	var _keys:Array<Bool>;

	public var mouseDown(default, null):Bool;
	public var mouseUp(default, null):Bool;
	// Automatically resets after each frame.
	public var mouseClicked(default, null):Bool;

	public var mouseX(default, null):Float;
	public var mouseY(default, null):Float;
	public var mouseStageX(default, null):Float;
	public var mouseStageY(default, null):Float;
	public var mouseMoved(default, null):Bool;

	public function new(object:EventDispatcher):Void {
		if (object == null) throw new ArgumentNullException("object");
		object.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		object.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
		object.addEventListener(MouseEvent.CLICK, _mouseClicked);
		object.addEventListener(Event.ENTER_FRAME, _enterFrame);
		mouseClicked = false;

		object.addEventListener(MouseEvent.MOUSE_MOVE, _mouseMove);
		mouseX = mouseY = mouseStageX = mouseStageY = 0;
		mouseMoved = false;

		keyDown = new SlotList(_keyDownSignaller = new Signaler(this));
		keyUp = new SlotList(_keyUpSignaller = new Signaler(this));
		keyPressed = new SlotList(_keyPressedSignaller = new Signaler(this));

		object.addEventListener(KeyboardEvent.KEY_DOWN, _keyDown);
		object.addEventListener(KeyboardEvent.KEY_UP, _keyUp);
		_keys = new Array<Bool>();
		for (i in 0...256)
			_keys.push(false);
	}

	public var keyDown(default, null):ISlotList<Int>;
	var _keyDownSignaller(default, null):ISignaler<Int>;
	public var keyUp(default, null):ISlotList<Int>;
	var _keyUpSignaller(default, null):ISignaler<Int>;
	public var keyPressed(default, null):ISlotList<Int>;
	var _keyPressedSignaller(default, null):ISignaler<Int>;

	public function isKeyDown(keyCode:Int):Bool return _keys[keyCode]
	public function isKeyUp(keyCode:Int):Bool return !_keys[keyCode]

	public inline var isCtrlDown(gIsCtrlDown, null):Bool;
	inline function gIsCtrlDown() return _keys[Keyboard.CONTROL]
	public inline var isEnterDown(gIsEnterDown, null):Bool;
	inline function gIsEnterDown() return _keys[Keyboard.ENTER]
	public inline var isShiftDown(gIsShiftDown, null):Bool;
	inline function gIsShiftDown() return _keys[Keyboard.SHIFT]
	public inline var isSpaceDown(gIsSpaceDown, null):Bool;
	inline function gIsSpaceDown() return _keys[Keyboard.SPACE]

	function _mouseDown(e:MouseEvent) mouseUp = !(mouseDown = true)
	function _mouseUp(e:MouseEvent) mouseUp = !(mouseDown = false)
	function _mouseClicked(e:MouseEvent) mouseClicked = true
	function _keyUp(e:KeyboardEvent) {
		_keys[e.keyCode] = false;
		_keyUpSignaller.dispatchSignal(e.keyCode);
	}
	function _keyDown(e:KeyboardEvent) {
		_keys[e.keyCode] = true;
		_keyDownSignaller.dispatchSignal(e.keyCode);
	}

	function _enterFrame(e:Event) {
		mouseClicked = mouseMoved = false;
		for (key in 0..._keys.length) {
			if (_keys[key])
				_keyPressedSignaller.dispatchSignal(key);
		}
	}

	function _mouseMove(e:MouseEvent) {
		mouseMoved = true;
		mouseX = e.localX;
		mouseY = e.localY;
		mouseStageX = e.stageX;
		mouseStageY = e.stageY;
	}
}
