/**
 * ...
 * @author Mark
 */

package haxe.more.threading;
import haxe.more.interaction.Event;
import haxe.more.interaction.EventArgs;
import haxe.more.threading.Threading;

class Task {
	public var task(default, null):ThreadRunnerDelegate;
	public var done(default, null):Event<EventArgs>;
	public var isDone(default, null):Bool;
	public function new(task:ThreadRunnerDelegate) {
		done = new Event<EventArgs>();
		this.task = task;
		isDone = false;
	}
	
	function onDone() {
		done.invoke(this, EventArgs.empty);
	}
	
	public function process(time:Int):Bool {
		return isDone || {
			if (task(time)) {
				onDone();
				return true;
			}
			false;
		}
	}
	
	public static function addTask(thread:IThread, task:Task):IThread {
		return thread.add(task.process);
	}
}