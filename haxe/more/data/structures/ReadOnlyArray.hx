/** ReadOnlyArray.hx
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
package haxe.more.data.structures;
import haxe.more.exceptions.ArgumentNullException;

class ReadOnlyArray#if!H<T>#end {
	var _array:Array<T>;
	/**
	 * Constructs a new Readonly Array.
	 * @param	array The array to wrap.
	 * @usage	Changes in [array] are reflected in this array.
	 */
	public function new(array:Array<T>) {
		if (array == null) throw new ArgumentNullException("array");
		_array = array;
	}
	
	/**
	 * The length of the Array
	 */
	public var length(gLength, null):Int;
	function gLength() return _array.length

	/**
	 * Retrieves that item at the given index
	 * 
	 * @param	index	the index of the element to retrieve.
	 * @return	The element
	 */
	public function getAt(index:Int):T return _array[index]
	
	/**
	 * Returns a new Array by appending [a] to [this].
	 * @param	a The array to append to [this].
	 * @return a new Array by appending [a] to [this].
	 */
	public function concat(a:Array<T>):Array<T>
		return _array.concat(a)

	/**
	 * Returns a representation of an array with [sep] for separating each element.
	 * @param	sep The seperator to use.
	 * @return a representation of an array with [sep] for separating each element.
	 */
	public function join(sep:String):String
		return _array.join(sep)
	
	/**
	 * Copies the range of the array starting at [pos] up to, but not including, [end].
	 * Both [pos] and [end] can be negative to count from the end: -1 is the last item in the array.
	 * @param	pos The start of the range to copy.
	 * @param	?end The end of the range to copy.
	 * @return	A slice of [this].
	 */
	public function slice(pos:Int, ?end:Int):Array<T>
		return _array.slice(pos, end)

	/**
	 * Returns a displayable representation of the Array content.
	 * @return a displayable representation of the Array content.
	 */
	public function toString():String
		return _array.toString()

	/**
	 * Returns a copy of the Array. The values are not copied, only the Array structure.
	 * @return a copy of the Array.
	 */
	public function copy():Array<T>
		return _array.copy()

	/**
	 * Returns an iterator of the Array values.
	 * @return an iterator of the Array values.
	 */
	public function iterator():Iterator<Null<T>>
		return _array.iterator()	
}