/** IterableManipulation.hx
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
import haxe.more.data.flow.EnumerableIterable;
import haxe.more.data.flow.Enumerator;
import haxe.more.data.flow.EnumeratorIterator;
import haxe.more.data.structures.DoubleLinkedList;
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.data.structures.Tuple;
using haxe.more.data.IterableManipulation;
using haxe.more.data.Manipulation;
using haxe.more.Default;

/**
 * This class is only for backwards compatability with Iterable. The interresting stuff is in Manipulatuin.hx.
 * Also, below is a mix of dispatching queries to the enumerable version, and native iterable algorithm.
 */
class IterableManipulation {
	public static function after<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T>
		return subject.asEnumerable().after(predicate).asIterable()
	
	public static function all<T>(subject:Iterable<T>, predicate: T -> Bool):Bool
		return subject.asEnumerable().all(predicate)
	
	public static function any<T>(subject:Iterable<T>, predicate: T -> Bool):Bool
		return subject.asEnumerable().any(predicate)
	
	public static function average(subject:Iterable<Float>):Float
		return subject.asEnumerable().average()
	
	public static function averageInt(subject:Iterable<Int>):Float
		return subject.asEnumerable().averageInt()
	
	public static function as<T, V>(subject:Iterable<T>, type:Class<V>):Iterable<V>
		return subject.asEnumerable().as(type).asIterable()
	
	public static function asIterable<T>(enumerable:Enumerable<T>):Iterable<T>
		return enumerable == null ? null : new EnumerableIterable(enumerable)
		
	public static function asIterator<T>(enumerator:Enumerator<T>):Iterator<T>
		return enumerator == null ? null : new EnumeratorIterator(enumerator)	

	public static function at<T>(subject:Iterable<T>, index:Int):T
		return subject.asEnumerable().at(index)
	
	public static function castTo<T, V>(subject:Iterable<T>, type:Class<V>):Iterable<V>
		return subject.asEnumerable().castTo(type).asIterable()
	
	public static function concat<T>(subject:Iterable<T>, postfix1:Iterable<T>, ?postfix2:Iterable<T>, ?postfix3:Iterable<T>, ?postfix4:Iterable<T>):Iterable<T> {
		return
			Manipulation
			.concat(
				subject.asEnumerable(),
				postfix1.asEnumerable(),
				postfix2.asEnumerable(),
				postfix3.asEnumerable(),
				postfix4.asEnumerable()
			)
			.asIterable();
	}
	
	public static function delta(subject:Iterable<Float>):Iterable<Float>
		return subject.asEnumerable().delta().asIterable()
	
	public static function deltaInt(subject:Iterable<Int>):Iterable<Int>
		return subject.asEnumerable().deltaInt().asIterable()

	public static function first<T>(subject:Iterable<T>, ?predicate: T -> Bool):T
		return subject.asEnumerable().first(predicate)

	public static function firstOrNull<T>(subject:Iterable<T>, ?predicate: T -> Bool):T
		return subject.asEnumerable().firstOrNull(predicate)
	
	public static function firstOrDefault<T>(subject:Iterable<T>, defaultValue:T, ?predicate: T -> Bool):T
		return subject.asEnumerable().firstOrDefault(defaultValue, predicate)
	
	public static function fold<T, C>(subject:Iterable<T>, aggregator: T -> C -> C, ?seed:C):C
		return subject.asEnumerable().fold(aggregator, seed)
	
	public static function historyDuo<T, V>(subject:Iterable<T>, selector: T -> T -> V):Iterable<V>
		return subject.asEnumerable().historyDuo(selector).asIterable()
	
	public static function historyTrio<T, V>(subject:Iterable<T>, selector: T -> T -> T -> V):Iterable<V>
		return subject.asEnumerable().historyTrio(selector).asIterable()
	
	public static function historyQuattro<T, V>(subject:Iterable<T>, selector: T -> T -> T -> T -> V):Iterable<V>
		return subject.asEnumerable().historyQuattro(selector).asIterable()

	public static function join<T>(scattered:Iterable<Iterable<T>>):Iterable<T> {
		return
			scattered
			.asEnumerable()
			.select(function(iterable) return iterable.asEnumerable())
			.join().asIterable();
	}

	public static function select<T, V>(subject:Iterable<T>, selector: T -> V):Iterable<V>
		return subject.asEnumerable().select(selector).asIterable()
	
	public static function sum(subject:Iterable<Float>):Float
		return subject.asEnumerable().sum()
	
	public static function sumGeneric<T>(subject:Iterable<T> , converter:T->Float):Float
		return subject.asEnumerable().sumGeneric(converter)

	public static function reverse<T>(subject:Iterable<T>):Iterable<T>
		return subject.asEnumerable().reverse().asIterable()
	
	public static function toArray<T>(subject:Iterable<T>):Array<T>
		return subject.asEnumerable().toArray()
	
	public static function toDoubleLinkedList<T>(subject:Iterable<T>):DoubleLinkedList<T>
		return subject.asEnumerable().toDoubleLinkedList()
	
	public static function toList<T>(subject:Iterable<T>):List<T>
		return subject.asEnumerable().toList()
	
	public static function toSingleLinkedList<T>(subject:Iterable<T>):SingleLinkedList<T>
		return subject.asEnumerable().toSingleLinkedList()

	public static function until<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T>
		return subject.asEnumerable().until(predicate).asIterable()
	
	public static function where<T>(subject:Iterable<T>, predicate: T -> Bool):Iterable<T>
		return subject.asEnumerable().where(predicate).asIterable()
	
	public static function zip2<T1, T2>(subject1:Iterable<T1>, subject2:Iterable<T2>):Iterable<Tuple2<T1, T2>> {
		return
			Manipulation
			.zip2(
				subject1.asEnumerable(),
				subject2.asEnumerable()
			)
			.asIterable();
	}
}
