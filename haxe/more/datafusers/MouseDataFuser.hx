/**
 * ...
 * @author Mark
 */

package haxe.more.datafusers;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

class MouseDataFuser {
	public var mouseDown(default, null):Bool;
	public var mouseUp(default, null):Bool;
	/**
	 * Automatically resets after each frame.
	 */
	public var mouseClicked(get_clicked, null):Bool;
	private var _mouseClicked:Bool;
	
	public function new(stage:Stage):Void {
		stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseAction);
		stage.addEventListener(MouseEvent.MOUSE_UP, mouseAction);
		stage.addEventListener(Event.ENTER_FRAME, action);
		_mouseClicked = false;
	}	
	private function action(e:Event):Void {
		switch(e.type) {
			case Event.ENTER_FRAME:
				_mouseClicked = false;
		}
	}
	private function get_clicked():Bool {
		return _mouseClicked;
	}
	private function mouseAction(e:MouseEvent):Void {
		switch(e.type) {
			case MouseEvent.MOUSE_DOWN:
				mouseUp = !(mouseDown = true);
			case MouseEvent.MOUSE_UP:
				mouseUp = !(mouseDown = false);
			case MouseEvent.CLICK:
				_mouseClicked = true;
		}	
	}
}