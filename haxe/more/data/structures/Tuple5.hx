﻿/** Tuple5.hx
 *
 * Copyright 2009 Mark de Bruijn (kramieb@gmail.com | Dykam.nl)
 * 
 * Licensed under the apache License, Version 2.0 (the "License");
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

/**
 * An tuple providing five data slots.
 * Used for anonymous data containers with anonymous data slots.
 */
class Tuple5<T1, T2, T3, T4, T5> {
	public var first(default, null):T1;
	public var second(default, null):T2;
	public var third(default, null):T3;
	public var fourth(default, null):T4;
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
		this.first = first;
		this.second = second;
		this.third = third;
		this.fourth = fourth;
		this.fifth = fifth;
	}	
}