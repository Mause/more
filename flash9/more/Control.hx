/**
 * ...
 * @author Dykam
 */

package flash.more;
import flash.events.KeyboardEvent;
import flash.Lib;

class Control {
	static var keys = init();
	public static function isKeyDown(keyCode:Int):Bool {
		return keys[keyCode];
	}
	
	static function init() {
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		var k = new Array<Bool>();
		for (i in 0...256) {
			k.push(false);
		}
		return k;
	}
	
	static private function keyUp(e:KeyboardEvent):Void {
		keys[e.charCode] = false;
	}
	
	static private function keyDown(e:KeyboardEvent):Void {
		keys[e.charCode] = true;	
	}
}