/** FPSCounter.hx
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
package flash.more.precise;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.Lib;
import flash.text.TextField;

class FPSCounter extends Sprite {
	private var oldTime:Int;
	private var displayCounter:Int;
	private static inline var interval:Int = 10;
	private var view:TextField;
	public function new(color:Int):Void {
		super();
		oldTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, enterFrame);
		
		view = new TextField();
		view.textColor = color;
		var f = view.defaultTextFormat;
		f.bold = true;
		view.setTextFormat(f);
		view.width = 190;
		addChild(view);
		displayCounter = 0;
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