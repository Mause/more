/**
 * ...
 * @author Mark
 */

package haxe.more.timing;
import org.hsl.SlotList;
import org.hsl.Signaler;
using Std;
using haxe.more.Default;

class Timer {
	var _timer:haxe.Timer;
	var _tickSignaler:ISignaler<Void>;
	var _lastTickSignaler:ISignaler<Void>;
	var _repeatsLeft:Int;
	var _interval:Int;
	
	public var repeatsLeft(gRepeatsLeft, sRepeatsLeft):Int;
	function gRepeatsLeft():Int
		return _repeatsLeft
	function sRepeatsLeft(value:Int):Int
		return _repeatsLeft = value.max(0).int()
		
	public var running(default, null):Bool;
		
	public var tick(default, null):ISlotList<Void>;
	public var lastTick(default, null):ISlotList<Void>;
	
	public function new(interval:Int, repeatCount:Int = 0, initialDelay:Int = -1) {
		tick = new SlotList(_tickSignaler = new Signaler(this));
		lastTick = new SlotList(_lastTickSignaler = new Signaler(this));
		running = false;
		
		_interval = interval;
		_repeatsLeft = repeatCount;
		
		var self = this;
		if (initialDelay != -1)
			delay(function() {
				self.internalTick();
				self.start();
			}, initialDelay);
	}
	
	public function start():Timer {
		if (running)
			return this;
			
		running = true;
			
		_timer = new haxe.Timer(_interval);
		_timer.run = internalTick;
		
		return this;
	}
	
	public function stop():Timer {
		if (!running)
			return this;
			
		running = false;
			
		_timer.stop();
		_timer = null;
		
		return this;
	}
	
	
	
	function internalTick() {
		_tickSignaler.dispatchSignal();
		if (repeatsLeft != 0) {
			_repeatsLeft--;
			if (repeatsLeft == 0) {
				stop();
				_lastTickSignaler.dispatchSignal();
			}
		}
	}
	
	public static function delay(callBack: Void -> Void, delay:Int):Void {
		haxe.Timer.delay(callBack, delay);
	}
}