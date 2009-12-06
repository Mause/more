/**
 * ...
 * @author Mark
 */

package haxe.more.threading;
import haxe.more.exceptions.NotImplementedException;
import haxe.more.threading.Threading;

class Task {
	public var task(default, null):ThreadRunnerDelegate;
	public var isDone(default, null):Bool;
	public function new(task:ThreadRunnerDelegate) {
		this.task = task;
		isDone = false;
	}
	
	function onDone() {
		throw new NotImplementedException("onDone");
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