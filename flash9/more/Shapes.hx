/**
 * ...
 * @author Dykam
 */

package flash.more;
import flash.display.Graphics;

class Shapes {
	public static function drawArc(g:Graphics, x:Float, y:Float, radius:Float, arc:Float, angle:Float = 0):Graphics {
		var segAngle:Float;
		var angleMid:Float;
		var segments:Int;
		var outerX:Float;
		var outerY:Float;
		var controlX:Float;
		var controlY:Float;
		
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
		segAngle = arc / segments;
		var controlDisplacement = (radius / Math.cos(segAngle / 2));
		
		// Calculate the start point
		outerX = x + Math.cos(angle) * radius;
		outerY = y + Math.sin(angle) * radius;
		// Move the pen
		g.moveTo(outerX, outerY);
		for (i in 0...segments) {
			angle += segAngle;
			angleMid = angle - (segAngle / 2);
			outerX = x + Math.cos(angle) * radius;
			outerY = y + Math.sin(angle) * radius;
			controlX = x + Math.cos(angleMid) * controlDisplacement;
			controlY = y + Math.sin(angleMid) * controlDisplacement;
			g.curveTo(controlX, controlY, outerX, outerY);
		}
		
		return g;
	}
	
	public static function drawPie(g:Graphics, x:Float, y:Float, radius:Float, arc:Float, angle:Float = 0):Graphics {
		var segAngle:Float;
		var angleMid:Float;
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
		segAngle = arc / segments;
		var controlDisplacement = (radius / Math.cos(segAngle / 2));
		
		// Calculate the start point
		outerX = x + Math.cos(angle) * radius;
		outerY = y + Math.sin(angle) * radius;
		// Draw the first line
		g.lineTo(outerX, outerY);
		for (i in 0...segments) {
			angle += segAngle;
			angleMid = angle - (segAngle / 2);
			outerX = x + Math.cos(angle) * radius;
			outerY = y + Math.sin(angle) * radius;
			controlX = x + Math.cos(angleMid) * controlDisplacement;
			controlY = y + Math.sin(angleMid) * controlDisplacement;
			g.curveTo(controlX, controlY, outerX, outerY);
		}
		
		// Close the wedge
		g.lineTo(x, y);
		
		return g;
	}
}