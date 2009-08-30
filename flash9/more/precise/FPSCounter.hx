/**
 * ...
 * @author Mark
 */

package flash.more.precise;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import haxe.more.positioning.Alignment;
import haxe.more.positioning.HorizontalAlignment;
import haxe.more.positioning.VerticalAlignment;

class FPSCounter extends Sprite {
	private var oldTime:Int;
	private var displayCounter:Int;
	public var alignment(getAlignment, setAlignment):Alignment;
	private var _alignment:Alignment;
	private static inline var interval:Int = 10;
	private var view:TextField;
	public function new(?alignment:Alignment, ?stage:Stage):Void {
		super();
		if (alignment == null) {
			alignment = new Alignment(HorizontalAlignment.left, VerticalAlignment.top);
		}
		if (stage != null) {
			stage.addChild(this);
		}
		oldTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, enterFrame);
		
		view = new TextField();
		view.width = 190;
		addChild(view);
		this.alignment = alignment;
		displayCounter = 0;
	}
	private function getAlignment():Alignment {
		return _alignment;
	}
	private function setAlignment(value:Alignment):Alignment {
		_alignment = value;
		view.x = _alignment.horizontal == HorizontalAlignment.left ? 10 : _alignment.horizontal == HorizontalAlignment.middle ? stage.stageWidth / 2 - 190 / 2 : stage.stageWidth - 190 - 10;
		view.y = _alignment.vertical == VerticalAlignment.top ? 10 : _alignment.vertical == VerticalAlignment.middle ? stage.stageHeight / 2 - 190 / 2 : stage.stageHeight - 190 - 10;
		var format:TextFormat = new TextFormat();
		format.align = _alignment.horizontal == left ? TextFormatAlign.LEFT : _alignment.horizontal == HorizontalAlignment.middle ? TextFormatAlign.CENTER : TextFormatAlign.RIGHT;
		view.setTextFormat(format);
		return value;
	}
	
	private function enterFrame(e:Event):Void {
		var newTime:Int = Lib.getTimer();
		if(++displayCounter % interval == 0) {
			var diff:Int = newTime - oldTime;
			view.text = Math.round(1000 / diff) + " fps";
			displayCounter = 0;
		}
		oldTime = newTime;
	}
}