/** Tuple2.hx
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
class Tuple2<T1, T2> {
	public var value1(default, null):T1;
	public var value2(default, null):T2;
	
	/**
	 * Creates a new tuple.
	 * @param	value1 The first value.
	 * @param	value2 The second value.
	 */
	public function new(value1:T1, value2:T2) {
		this.value1 = value1;
		this.value2 = value2;
	}	
}