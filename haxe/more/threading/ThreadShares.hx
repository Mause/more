package haxe.more.threading;

class ThreadShares {
	static var initor = init();
	static function init() {
		Critical = 512;
		Important = 256;
		Low = 64;
		Medium = 128;
		var max = 1;
		while (max > 0) {
			RealTime = max;
			max = (max << 1) | 1;
		}
	}
	/**
	 * Critical share. Threads with this share get twice as many steps as threads with ThreadPriority.Important.
	 */
	public static var Critical(default, null):Int;
	static function critical() return 512
	/**
	 * Important share. Threads with this share get twice as many steps as threads with ThreadPriority.Medium.
	 */
	public static var Important(default, null):Int;
	static function important() return 256
	/**
	 * Low share. Threads with this share get half the number of steps as threads with ThreadPriority.Medium. This share can be used for threads that do
	 *  not have to be stapped.
	 */
	public static var Low(default, null):Int;
	static function low() return 64
	/**
	 * Medium share. This share can be used for normal threads.
	 */
	public static var Medium(default, null):Int;
	static function medium() return 128
	/**
	 * Realtime share. this process will retrieve virtually all cpu time.
	 */
	public static var RealTime(default, null):Int;
}