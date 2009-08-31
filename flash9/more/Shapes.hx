/**
 * Copyright (c) 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * Thanks Lee Brimelow (http://theflashblog.com/?p=430) for the idea and
 * base to build on. This code is heavely modified to actually work. Properly.
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
import flash.display.Graphics;

class Shapes {
	public static function drawArc(g:Graphics, x:Float, y:Float, radius:Float, arc:Float, angle:Float = 0):Graphics {
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