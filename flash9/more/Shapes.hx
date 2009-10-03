/** Shapes.hx
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
import flash.display.Graphics;
import haxe.more.exceptions.ArgumentNullException;

class Shapes {
	public static function drawArc(g:Graphics, x:Float, y:Float, radius:Float, arc:Float, angle:Float = 0):Graphics {
		if (g == null) throw new ArgumentNullException("g");
		// No need to draw more than needed
		arc %= Math.PI * 4;
		
		if (arc > Math.PI * 2) {
			var swap = arc;
			arc = Math.PI * 4 - arc;
			angle += swap % (Math.PI * 2);
		}
		angle %= Math.PI * 2;
		arc %= Math.PI * 2;
		
		var segments = Std.int(Math.ceil(Math.abs(arc) / (Math.PI * .25)));
		var segmentAngle = arc / segments;
		var controlDisplacement = (radius / Math.cos(segmentAngle / 2));
		
		// Calculate the start point
		var outerX = x + Math.cos(angle) * radius;
		var outerY = y + Math.sin(angle) * radius;
		// Move the pen
		g.moveTo(outerX, outerY);
		for (i in 0...segments) {
			angle += segmentAngle;
			var controlAngle = angle - (segmentAngle / 2);
			outerX = x + Math.cos(angle) * radius;
			outerY = y + Math.sin(angle) * radius;
			var controlX = x + Math.cos(controlAngle) * controlDisplacement;
			var controlY = y + Math.sin(controlAngle) * controlDisplacement;
			g.curveTo(controlX, controlY, outerX, outerY);
		}
		
		return g;
	}
	
	public static function drawPie(g:Graphics, x:Float, y:Float, radius:Float, arc:Float, angle:Float = 0):Graphics {
		if (g == null) throw new ArgumentNullException("g");
		var segmentAngle:Float;
		var controlAngle:Float;
		var segments:Int;
		var outerX:Float;
		var outerY:Float;
		var controlX:Float;
		var controlY:Float;
		
		// Move the pen
		g.moveTo(x, y);
		
		// No need to draw more than needed
		arc %= Math.PI * 4;
		
		if (arc > Math.PI * 2) {
			var swap = arc;
			arc = Math.PI * 4 - arc;
			angle += swap % (Math.PI * 2);
		}
		angle %= Math.PI * 2;
		arc %= Math.PI * 2;
		
		segments = Math.ceil(Math.abs(arc) / (Math.PI * .25));
		segmentAngle = arc / segments;
		var controlDisplacement = (radius / Math.cos(segmentAngle / 2));
		
		// Calculate the start point
		outerX = x + Math.cos(angle) * radius;
		outerY = y + Math.sin(angle) * radius;
		// Draw the first line
		g.lineTo(outerX, outerY);
		for (i in 0...segments) {
			angle += segmentAngle;
			controlAngle = angle - (segmentAngle / 2);
			outerX = x + Math.cos(angle) * radius;
			outerY = y + Math.sin(angle) * radius;
			controlX = x + Math.cos(controlAngle) * controlDisplacement;
			controlY = y + Math.sin(controlAngle) * controlDisplacement;
			g.curveTo(controlX, controlY, outerX, outerY);
		}
		
		// Close the wedge
		g.lineTo(x, y);
		
		return g;
	}
}