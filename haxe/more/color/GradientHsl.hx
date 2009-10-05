/** GradientHsl.hx
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
import haxe.more.data.sources.Transition;
using haxe.more.color.Rgb32;

class GradientHsl<A:IFixedHsl, B:IFixedHsl> extends Transition<A, B, IFixedHsl> {
	public function new(a:A, b:B) {
		super(a, b, null);
	}
	
	public override function at(padding:Float):IFixedHsl {
		var inverse = 1 - padding;
		return new Hsl(a.h * inverse + b.h * padding, a.s * inverse + b.s * padding, a.l * inverse + b.l * padding, a.a * inverse + b.a * padding);
	}
}