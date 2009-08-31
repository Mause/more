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
	public function new():Void {
		super();
		oldTime = Lib.getTimer();
		addEventListener(Event.ENTER_FRAME, enterFrame);
		
		view = new TextField();
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