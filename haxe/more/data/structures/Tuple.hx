﻿/**
 * ...
 * @author Mark
 */

package haxe.more.data.structures;
typedef Tuple2<T1, T2> = {
	var first(default, null):T1;
	var second(default, null):T2;
}
typedef Tuple3<T1, T2, T3> = {> Tuple2<T1, T2>,
	var third(default, null):T3;
}
typedef Tuple4<T1, T2, T3, T4> = {> Tuple3<T1, T2, T3>,
	var fourth(default, null):T4;
}
typedef Tuple5<T1, T2, T3, T4, T5> = {> Tuple4<T1, T2, T3, T4>,
	var fifth(default, null):T5;
}

class Tuple {
	public static function five<T1, T2, T3, T4, T5>(first:T1, second:T2, third:T3, fourth:T4, fifth:T5):Tuple5<T1, T2, T3, T4, T5> {
		return new InternalTuple5(first, second, third, fourth, fifth);
	}
	public static function four<T1, T2, T3, T4>(first:T1, second:T2, third:T3, fourth:T4):Tuple4<T1, T2, T3, T4> {
		return new InternalTuple4(first, second, third, fourth);
	}
	public static function three<T1, T2, T3>(first:T1, second:T2, third:T3):Tuple3<T1, T2, T3> {
		return new InternalTuple3(first, second, third);
	}
	public static function two<T1, T2>(first:T1, second:T2):Tuple2<T1, T2> {
		return new InternalTuple2(first, second);
	}
	
	public static inline function asTuple2<T1, T2, T3>(tuple:Tuple3<T1, T2, T3>):Tuple2<T1, T2>
		return tuple
	public static inline function asTuple3<T1, T2, T3, T4>(tuple:Tuple4<T1, T2, T3, T4>):Tuple3<T1, T2, T3>
		return tuple
	public static inline function asTuple4<T1, T2, T3, T4, T5>(tuple:Tuple5<T1, T2, T3, T4, T5>):Tuple4<T1, T2, T3, T4>
		return tuple
}
class InternalTuple2<T1, T2> {
	public var first(default, null):T1;
	public var second(default, null):T2;
	
	/**
	 * Creates a new tuple.
	 * @param	first The first value.
	 * @param	second The second value.
	 */
	public function new(first:T1, second:T2) {
		this.first = first;
		this.second = second;
	}
}
class InternalTuple3<T1, T2, T3> extends InternalTuple2<T1, T2> {
	public var third(default, null):T3;
	
	/**
	 * Creates a new tuple.
	 * @param	first The first value.
	 * @param	second The second value.
	 * @param	third The third value.
	 */
	public function new(first:T1, second:T2, third:T3) {
		super(first, second);
		this.third = third;
	}
}
class InternalTuple4<T1, T2, T3, T4> extends InternalTuple3<T1, T2, T3> {
	public var fourth(default, null):T4;
	
	/**
	 * Creates a new tuple.
	 * @param	first The first value.
	 * @param	second The second value.
	 * @param	third The third value.
	 * @param	fourth The fourth value.
	 */
	public function new(first:T1, second:T2, third:T3, fourth:T4) {
		super(first, second, third);
		this.fourth = fourth;
	}
}
class InternalTuple5<T1, T2, T3, T4, T5> extends InternalTuple4<T1, T2, T3, T4> {
	public var fifth(default, null):T5;
	
	/**
	 * Creates a new tuple.
	 * @param	first The first value.
	 * @param	second The second value.
	 * @param	third The third value.
	 * @param	fourth The fourth value.
	 * @param	fifth The fifth value.
	 */
	public function new(first:T1, second:T2, third:T3, fourth:T4, fifth:T5) {
		super(first, second, third, fourth);
		this.fifth = fifth;
	}
	
	public function toString():String {
		return "Tuple("
			+ first + ", "
			+ second + ", "
			+ third + ", "
			+ fourth + ", "
			+ fifth + ")";
	}
}