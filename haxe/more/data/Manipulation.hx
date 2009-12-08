/** Manipulation.hx
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
import haxe.more.data.flow.AfterIterable;
import haxe.more.data.flow.ConcatIterable;
import haxe.more.data.flow.HistoryDuoIterable;
import haxe.more.data.flow.HistoryQuattroIterable;
import haxe.more.data.flow.HistoryTrioIterable;
import haxe.more.data.flow.IteratorIterable;
import haxe.more.data.flow.ReverseIterable;
import haxe.more.data.flow.SelectIterable;
import haxe.more.data.flow.UntilIterable;
import haxe.more.data.flow.WhereIterable;
import haxe.more.data.flow.ZipSelect2Iterable;
import haxe.more.data.structures.DoubleLinkedList;
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.data.structures.Tuple;
import haxe.more.exceptions.ArgumentNullException;
import haxe.more.exceptions.Exception;
import haxe.more.exceptions.NotImplementedException;
using haxe.more.data.Manipulation;
using haxe.more.Default;

/**
 * If you know Microsofts Linq, this will feel familiar to you.
 * OMG, code code!
 */
class Manipulation {
	public static function after<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new AfterIterable(subject, predicate);
	}
	
	public static function all<T>(subject:Iterable<T>, predicate: T -> Bool):Bool {
		for (item in subject)
			if (!predicate(item))
				return false;
		return true;
	}
	
	public static function any<T>(subject:Iterable<T>, predicate: T -> Bool):Bool {
		for (item in subject)
			if (predicate(item))
				return true;
		return false;
	}
	
	public static function average(subject:Iterable<Float>):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		var amount = 0;
		var total = 0.0;
		var iter = subject.iterator();
		//Avoid Division by zero
		if (!iter.hasNext()) return 0.0;
		do {
			total += iter.next();
			amount++;
		} while (iter.hasNext());
		return total / amount;
	}
	
	public static function averageGeneric<T>(subject:Iterable<T> , converter:T->Float):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		if (converter == null) throw new ArgumentNullException("converter");
		return subject.select(converter).average();
	}
	
	public static function averageInt(subject:Iterable<Int>):Float {
		if (subject == null) throw new ArgumentNullException("subject");		
		return averageGeneric(subject, function(x) return x);
	}
	
	public static function as<T, V>(subject:Iterable<T>, type:Class<V>):Iterable<V> {
		if (subject == null) throw new ArgumentNullException("subject");	
		return subject.select(function(item) return item.as(type));
	}
	

	public static function at<T>(subject:Iterable<T>, index:Int):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var iter = subject.iterator();
		while (iter.hasNext()) {
			if (index-- < 0) {
				return iter.next();
			}
			iter.next();
		}
		return null;
	}
	
	public static function castTo<T, V>(subject:Iterable<T>, type:Class<V>):Iterable<V> {
		if (subject == null) throw new ArgumentNullException("subject");	
		return subject.select(function(item) return cast item);
	}
	
	public static function concat<T>(subject:Iterable<T>, postfix1:Iterable<T>, ?postfix2:Iterable<T>, ?postfix3:Iterable<T>, ?postfix4:Iterable<T>):Iterable<T> {// Hey, a programming style experiment! Came out a little flawed.
		if (subject == null) throw new ArgumentNullException("subject");
		if (postfix1 == null) throw new ArgumentNullException("postfix1");
		return postfix2 == null
			? new ConcatIterable([subject, postfix1])
			: postfix3 == null
				? new ConcatIterable([subject, postfix1, postfix2])
				: postfix4 == null
					? new ConcatIterable([subject, postfix1, postfix2, postfix3])
					: new ConcatIterable([subject, postfix1, postfix2, postfix3, postfix4]);
	}
	
	public static function delta(subject:Iterable<Float>):Iterable<Float> {
		if (subject == null) throw new ArgumentNullException("subject");
		return subject.historyDuo(function(first, second) return second - first);
	}
	
	public static function deltaGeneric<T>(subject:Iterable<T> , converter:T->Float):Iterable<Float> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (converter == null) throw new ArgumentNullException("converter");
		return subject.select(converter).delta();
	}

	public static function first<T>(subject:Iterable<T>, ?predicate: T -> Bool):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var iter = predicate != null ? subject.where(predicate).iterator() : subject.iterator();
		if (!iter.hasNext()) throw new Exception("Element not found");
		return iter.next();
	}

	public static function firstOrNull<T>(subject:Iterable<T>, ?predicate: T -> Bool):T {
		return subject.firstOrDefault(null, predicate);
	}
	
	public static function firstOrDefault<T>(subject:Iterable<T>, defaultValue:T, ?predicate: T -> Bool):T {
		if (subject == null) throw new ArgumentNullException("subject");
		var iter = predicate != null ? subject.where(predicate).iterator() : subject.iterator();
		return iter.hasNext() ? iter.next() : defaultValue;
	}
	
	public static function fold<T, C>(subject:Iterable<T>, aggregator: T -> C -> C, ?seed:C):C {
		if (subject == null) throw new ArgumentNullException("subject");
		if (aggregator == null) throw new ArgumentNullException("aggregator");
		for (item in subject) {
			seed = aggregator(item, seed);
		}
		return seed;
	}
	
	public static function historyDuo<T, V>(subject:Iterable<T>, selector: T -> T -> V):Iterable<V> {
		return new HistoryDuoIterable(subject, selector);
	}
	
	public static function historyTrio<T, V>(subject:Iterable<T>, selector: T -> T -> T -> V):Iterable<V> {
		return new HistoryTrioIterable(subject, selector);		
	}
	
	public static function historyQuattro<T, V>(subject:Iterable<T>, selector: T -> T -> T -> T -> V):Iterable<V> {
		return new HistoryQuattroIterable(subject, selector);	
	}

	public static function iterable<T>(subject:Iterator<T>):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		return new IteratorIterable(subject);
	}

	public static function join<T>(scattered:Iterable<Iterable<T>>):Iterable<T> {
		if (scattered == null) throw new ArgumentNullException("scattered");
		return new ConcatIterable(scattered);
	}

	public static function select<T, V>(subject:Iterable<T>, selector: T -> V):Iterable<V> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (selector == null) throw new ArgumentNullException("selector");
		return new SelectIterable(subject, selector);
	}
	
	public static function sum(subject:Iterable<Float>):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		var total = 0.0;
		for (number in subject)
			total += number;
		return total;
	}
	
	public static function sumGeneric<T>(subject:Iterable<T> , converter:T->Float):Float {
		if (subject == null) throw new ArgumentNullException("subject");
		if (converter == null) throw new ArgumentNullException("converter");
		return subject.select(converter).sum();
	}

	public static function reverse<T>(subject:Iterable<T>):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		return new ReverseIterable(subject);
	}
	
	public static function toArray<T>(subject:Iterable<T>):Array<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new Array<T>();
		for (item in subject) result.push(item);
		return result;
	}
	
	public static function toDoubleLinkedList<T>(subject:Iterable<T>):DoubleLinkedList<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new DoubleLinkedList<T>();
		for (item in subject) result.push(item);
		return result;
	}
	
	public static function toList<T>(subject:Iterable<T>):List<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		var result = new List<T>();
		for (item in subject) result.add(item);
		return result;
	}
	
	public static function toSingleLinkedList<T>(subject:Iterable<T>):SingleLinkedList<T> {
		return new SingleLinkedList(subject);
	}

	public static function until<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new UntilIterable(subject, predicate);
	}
	
	public static function where<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T> {
		if (subject == null) throw new ArgumentNullException("subject");
		if (predicate == null) throw new ArgumentNullException("predicate");
		return new WhereIterable(subject, predicate);	
	}
	
	public static function zip2<T1, T2>(subject1:Iterable<T1>, subject2:Iterable<T2>):Iterable<Tuple2<T1, T2>> {
		if (subject1 == null) throw new ArgumentNullException("subject1");
		if (subject2 == null) throw new ArgumentNullException("subject2");
		return new ZipSelect2Iterable(subject1, subject2, function(item1, item2) return Tuple.two(item1, item2));
	}
}
