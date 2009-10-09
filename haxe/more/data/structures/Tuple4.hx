/** Tuple4.hx
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
class Tuple4<T1, T2, T3, T4> {
	public var value1(default, null):T1;
	public var value2(default, null):T2;
	public var value3(default, null):T3;
	public var value4(default, null):T4;
	
	/**
	 * Creates a new tuple.
	 * @param	value1 The first value.
	 * @param	value2 The second value.
	 * @param	value3 The third value.
	 * @param	value4 The fourth value.
	 */
	public function new(value1:T1, value2:T2, value3:T3, value4:T4) {
		this.value1 = value1;
		this.value2 = value2;
		this.value3 = value3;
		this.value4 = value4;
	}	
}