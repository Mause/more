/**
 * ...
 * @author Mark
 */

package haxe.more.threading;
import haxe.more.threading.Threading;

interface IThread {	
	public var count(default, null):Int;
	public function add(thread:ThreadRunnerDelegate, priority:Int = 128):IThread;	
	public function adjust(thread:ThreadRunnerDelegate, priority:Int):Bool;	
	/**
	 * Removes a thread.
	 * @param	thread the thread to remove.
	 * @return Returns true if the thread was found and removed.
	 */
	public function remove(thread:ThreadRunnerDelegate):Bool;	
	public function process(time:Int):Bool;
	public function contains(thread:ThreadRunnerDelegate):Int;
}