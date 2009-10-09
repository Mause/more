/**
 * ...
 * @author Mark
 */

package flash.more;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.more.Control;

class ExtraControl extends Control {
	public var mouseX(default, null):Float;
	public var mouseY(default, null):Float;
	public var mouseStageX(default, null):Float;
	public var mouseStageY(default, null):Float;
	public var mouseMoved(default, null):Bool;
	
	public function new(object:EventDispatcher) {
		super(object);
		object.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		mouseX = mouseY = mouseStageX = mouseStageY = 0;
		mouseMoved = false;
	}
	
	override function enterFrame(e:Event) { 
		super.enterFrame(e);
		mouseMoved = false;
	}
	function mouseMove(e:MouseEvent) {
		mouseMoved = true;
		mouseX = e.localX;
		mouseY = e.localY;
		mouseStageX = e.stageX;
		mouseStageY = e.stageY;
	}
}