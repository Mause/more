/** EnumerableManipulation.hx
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
package haxe.more.data;
import haxe.more.data.flow.Enumerable;
import haxe.more.data.flow.Enumerator;
import haxe.more.data.flow.AfterEnumerable;
import haxe.more.data.flow.ConcatEnumerable;
import haxe.more.data.flow.EnumerableIterable;
import haxe.more.data.flow.HistoryDuoEnumerable;
import haxe.more.data.flow.HistoryQuattroEnumerable;
import haxe.more.data.flow.HistoryTrioEnumerable;
import haxe.more.data.flow.IterableEnumerable;
import haxe.more.data.flow.IteratorEnumerator;
import haxe.more.data.flow.SelectEnumerable;
import haxe.more.data.flow.RangeEnumerable;
import haxe.more.data.flow.ReverseEnumerable;
import haxe.more.data.flow.UntilEnumerable;
import haxe.more.data.flow.WhereEnumerable;
import haxe.more.data.flow.ZipSelect2Enumerable;
import haxe.more.data.structures.DoubleLinkedList;
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.data.structures.Tuple;
import haxe.more.exceptions.ArgumentNullException;
import haxe.more.exceptions.Exception;
import haxe.more.exceptions.NotImplementedException;
using haxe.more.data.IterableManipulation;
using haxe.more.data.Manipulation;
using haxe.more.Default;

/**
 * If you know Microsofts Linq, this will feel familiar to you.
 * OMG, code code!
 */
class Manipulation {
	public static function after<T>(subject:Enumerable<T>, predicate: T -> Bool):Enumerable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new AfterEnumerable(subject, predicate);
	}
	
	public static function all<T>(subject:Enumerable<T>, predicate: T -> Bool):Bool {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext())
			if (!predicate(enumerator.current))
				return false;
		return true;
	}
	
	public static function any<T>(subject:Enumerable<T>, predicate: T -> Bool):Bool {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext())
			if (predicate(enumerator.current))
				return true;
		return false;
	}
	
	public static function average(subject:Enumerable<Float>):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		var amount = 0;
		var total = 0.0;
		var enumerator = subject.getEnumerator();
		//Avoid Division by zero
		if (!enumerator.moveNext()) return 0.0;
		do {
			total += enumerator.current;
			amount++;
		} while (enumerator.moveNext());
		return total / amount;
	}
	
	public static function averageGeneric<T>(subject:Enumerable<T> , converter:T->Float):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		if (converter == null) throw new ArgumentNullException("converter");
		return subject.select(converter).average();
	}
	
	public static function averageInt(subject:Enumerable<Int>):Float {
		if (subject == null) throw new ArgumentNullException("subject");		
		return averageGeneric(subject, function(x) return x);
	}
	
	public static function as<T, V>(subject:Enumerable<T>, type:Class<V>):Enumerable<V> {
		if (subject == null) throw new ArgumentNullException("subject");	
		return subject.select(function(item) return item.as(type));
	}
	
	public static function asEnumerable<T>(iterable:Iterable<T>):Enumerable<T> {
		return iterable == null ? null : new IterableEnumerable(iterable);
	}
	
	public static function asEnumerator<T>(iterator:Iterator<T>):Enumerator<T> {
		return iterator == null ? null : new IteratorEnumerator(iterator);
	}
	

	public static function at<T>(subject:Enumerable<T>, index:Int):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var enumerator = subject.getEnumerator();
		while (enumerator.moveNext()) {
			if (index-- < 0) {
				return enumerator.current;
			}
		}
		return null;
	}
	
	public static function castTo<T, V>(subject:Enumerable<T>, type:Class<V>):Enumerable<V> {
		if (subject == null) throw new ArgumentNullException("subject");	
		return subject.select(function(item) return cast item);
	}
	
	public static function concat<T>(subject:Enumerable<T>, postfix1:Enumerable<T>, ?postfix2:Enumerable<T>, ?postfix3:Enumerable<T>, ?postfix4:Enumerable<T>):Enumerable<T> {// Hey, a programming style experiment! Came out a little flawed.
		if (subject == null) throw new ArgumentNullException("subject");
		if (postfix1 == null) throw new ArgumentNullException("postfix1");
		return postfix2 == null
			? new ConcatEnumerable([subject, postfix1].asEnumerable())
			: postfix3 == null
				? new ConcatEnumerable([subject, postfix1, postfix2].asEnumerable())
				: postfix4 == null
					? new ConcatEnumerable([subject, postfix1, postfix2, postfix3].asEnumerable())
					: new ConcatEnumerable([subject, postfix1, postfix2, postfix3, postfix4].asEnumerable());
	}
	
	public static function delta(subject:Enumerable<Float>):Enumerable<Float> {
		if (subject == null) throw new ArgumentNullException("subject");
		return subject.historyDuo(function(first, second) return second - first);
	}
	
	public static function deltaInt(subject:Enumerable<Int>):Enumerable<Int> {
		if (subject == null) throw new ArgumentNullException("subject");
		return subject.historyDuo(function(first, second) return second - first);		
	}

	public static function first<T>(subject:Enumerable<T>, ?predicate: T -> Bool):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var enumerator = predicate != null ? subject.where(predicate).getEnumerator() : subject.getEnumerator();
		if (!enumerator.moveNext()) throw new Exception("Element not found");
		return enumerator.current;
	}

	public static function firstOrNull<T>(subject:Enumerable<T>, ?predicate: T -> Bool):T {
		return subject.firstOrDefault(null, predicate);
	}
	
	public static function firstOrDefault<T>(subject:Enumerable<T>, defaultValue:T, ?predicate: T -> Bool):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var enumerator = predicate != null ? subject.where(predicate).getEnumerator() : subject.getEnumerator();
		return enumerator.moveNext() ? enumerator.current : defaultValue;
	}
	
	public static function fold<T, C>(subject:Enumerable<T>, aggregator: T -> C -> C, ?seed:C):C {
		if (subject == null) throw new ArgumentNullException("subject");
		if (aggregator == null) throw new ArgumentNullException("aggregator");
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext()) {
			seed = aggregator(enumerator.current, seed);
		}
		return seed;
	}
	
	public static function groupBy<T, G>(subject:Enumerable<T>):Enumerable<G> {
		return null;
	}
	
	public static function historyDuo<T, V>(subject:Enumerable<T>, selector: T -> T -> V):Enumerable<V> {
		return new HistoryDuoEnumerable(subject, selector);
	}
	
	public static function historyTrio<T, V>(subject:Enumerable<T>, selector: T -> T -> T -> V):Enumerable<V> {
		return new HistoryTrioEnumerable(subject, selector);		
	}
	
	public static function historyQuattro<T, V>(subject:Enumerable<T>, selector: T -> T -> T -> T -> V):Enumerable<V> {
		return new HistoryQuattroEnumerable(subject, selector);	
	}

	public static function join<T>(scattered:Enumerable<Enumerable<T>>):Enumerable<T> {
		if (scattered == null) throw new ArgumentNullException("scattered");
		return new ConcatEnumerable(scattered);
	}

	public static function select<T, V>(subject:Enumerable<T>, selector: T -> V):Enumerable<V> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (selector == null) throw new ArgumentNullException("selector");
		return new SelectEnumerable(subject, selector);
	}
	
	public static function skip<T>(subject:Enumerable<T>, skip:Int):Enumerable<T> {
		return return subject.range(skip, -1);
	}
	
	public static function sum(subject:Enumerable<Float>):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		return subject.fold(function(number, total) return total + number, 0.0);
	}
	
	public static function sumGeneric<T>(subject:Enumerable<T> , converter:T->Float):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		if (converter == null) throw new ArgumentNullException("converter");
		return subject.select(converter).sum();
	}
	
	public static function range<T>(subject:Enumerable<T>, skip:Int, take:Int):Enumerable<T> {
		return new RangeEnumerable(subject, skip, take);
	}

	public static function reverse<T>(subject:Enumerable<T>):Enumerable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		return new ReverseEnumerable(subject);
	}
	
	public static function take<T>(subject:Enumerable<T>, take:Int):Enumerable<T> {
		return return subject.range(0, take);
	}
	
	public static function toArray<T>(subject:Enumerable<T>):Array<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new Array<T>();
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext())
			result.push(enumerator.current);
		return result;
	}
	
	public static function toDoubleLinkedList<T>(subject:Enumerable<T>):DoubleLinkedList<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new DoubleLinkedList<T>();
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext())
			result.push(enumerator.current);
		return result;
	}
	
	public static function toList<T>(subject:Enumerable<T>):List<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new List<T>();
		var enumerator = subject.getEnumerator();
		while(enumerator.moveNext())
			result.add(enumerator.current);
		return result;
	}
	
	public static function toSingleLinkedList<T>(subject:Enumerable<T>):SingleLinkedList<T> {
		return new SingleLinkedList(subject);
	}

	public static function until<T>(subject:Enumerable<T>, predicate: T -> Bool):Enumerable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new UntilEnumerable(subject, predicate);
	}
	
	public static function where<T>(subject:Enumerable<T>, predicate: T -> Bool):Enumerable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new WhereEnumerable(subject, predicate);	
	}
	
	public static function zip2<T1, T2>(subject1:Enumerable<T1>, subject2:Enumerable<T2>):Enumerable<Tuple2<T1, T2>> {
		if (subject1 == null) throw new ArgumentNullException("subject1");
		if (subject2 == null) throw new ArgumentNullException("subject2");
		return new ZipSelect2Enumerable(subject1, subject2, function(item1, item2) return Tuple.two(item1, item2));
	}
}
