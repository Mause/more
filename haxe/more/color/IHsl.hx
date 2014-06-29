/** IHsl.hx
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
package haxe.more.color;

interface IHsl extends IFixedHsl {
	/**
	 * The alpha component of this color.
	 */
	public var a(get_a, set_a):Float;

	/**
	 * The hue component of this color.
	 */
	public var h(get_h, set_h):Float;

	/**
	 * The saturation component of this color.
	 */
	public var s(get_s, set_s):Float;

	/**
	 * The lightness component of this color.
	 */
	public var l(get_l, set_l):Float;
}
