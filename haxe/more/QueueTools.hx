/**
 * ...
 * @author Mark
 */

package haxe.more;

class QueueTools {
	public static function indexOf < T > (Queue:Queue < T > , value:T):Int {
		var index:Int = 0;
		for (v in Queue) {
			if (v == value) {
				return index;
			}
			index++;
		}
		return -1;
	}
}