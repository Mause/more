/** Functional.hx
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
package haxe.more;
import haxe.more.exceptions.ArgumentNullException;

typedef Func<R> = Void -> R;
typedef Func1<A, R> = A -> R;
typedef Func2<A1, A2, R> = A1 -> A2 -> R;
typedef Func3<A1, A2, A3, R> = A1 -> A2 -> A3 -> R;
typedef Func4<A1, A2, A3, A4, R> = A1 -> A2 -> A3 -> A4 -> R;

typedef Action = Func<Void>;
typedef Action1<A> = Func1<A, Void>;
typedef Action2<A1, A2> = Func2<A1, A2, Void>;
typedef Action3<A1, A2, A3> = Func3<A1, A2, A3, Void>;
typedef Action4<A1, A2, A3, A4> = Func4<A1, A2, A3, A4, Void>;

typedef Recursive1<A, R> = Recursive1<A, R> -> Func1<A, R>;
typedef Recursive2<A1, A2, R> = Recursive2<A1, A2, R> -> Func2<A1, A2, R>;
typedef Recursive3<A1, A2, A3, R> = Recursive3<A1, A2, A3, R> -> Func3<A1, A2, A3, R>;
typedef Recursive4<A1, A2, A3, A4, R> = Recursive4<A1, A2, A3, A4, R> -> Func4<A1, A2, A3, A4, R>;

class Functional {
	public static function y1<A, R>(f: Func1<A, R> -> Func1<A, R>):Func1<A, R> {
		if (f == null) throw new ArgumentNullException("f");
		var rec:Recursive1<A, R> =function(r) return function(a) return f(r(r))(a);
		return rec(rec);
	}

	public static function y2<A1, A2, R>(f: Func2<A1, A2, R> -> Func2<A1, A2, R>):Func2<A1, A2, R> {
		if (f == null) throw new ArgumentNullException("f");
		var rec:Recursive2<A1, A2, R> = function(r) return function(a1, a2) return f(r(r))(a1, a2);
		return rec(rec);
	}

	public static function y3<A1, A2, A3, R>(f: Func3<A1, A2, A3, R> -> Func3<A1, A2, A3, R>):Func3<A1, A2, A3, R> {
		if (f == null) throw new ArgumentNullException("f");
		var rec:Recursive3<A1, A2, A3, R> = function(r) return function(a1, a2, a3) return f(r(r))(a1, a2, a3);
		return rec(rec);
	}

	public static function y4<A1, A2, A3, A4, R>(f: Func4<A1, A2, A3, A4, R> -> Func4<A1, A2, A3, A4, R>):Func4<A1, A2, A3, A4, R> {
		if (f == null) throw new ArgumentNullException("f");
		var rec:Recursive4<A1, A2, A3, A4, R> = function(r) return function(a1, a2, a3, a4) return f(r(r))(a1, a2, a3, a4);
		return rec(rec);
	}

	public static function compose2<A, B, C>(f1:Func1<A, B>,  f2:Func1<B, C>):Func1<A, C> {
		if (f1 == null) throw new ArgumentNullException("f1");
		if (f2 == null) throw new ArgumentNullException("f2");
		return function(a) return f2(f1(a));
	}

	public static function compose3<A, B, C, D>(f1:Func1<A, B>, f2:Func1<B, C>, f3:Func1<C, D>):Func1<A, D> {
		if (f1 == null) throw new ArgumentNullException("f1");
		if (f2 == null) throw new ArgumentNullException("f2");
		if (f3 == null) throw new ArgumentNullException("f3");
		return function(a) return f3(f2(f1(a)));
	}

	public static function compose4<A, B, C, D, E>(f1:Func1<A, B>, f2:Func1<B, C>, f3:Func1<C, D>, f4:Func1<D, E>):Func1<A, E> {
		if (f1 == null) throw new ArgumentNullException("f1");
		if (f2 == null) throw new ArgumentNullException("f2");
		if (f3 == null) throw new ArgumentNullException("f3");
		if (f4 == null) throw new ArgumentNullException("f4");
		return function(a) return f4(f3(f2(f1(a))));
	}
}
