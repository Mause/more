/** GradientRgb.hx
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
using haxe.more.color.Rgb;

class GradientRgb<A:IFixedRgb, B:IFixedRgb> extends Transition<A, B, IFixedRgb> {
	public function new(a:A, b:B) {
		super(a, b, null);
	}
	
	public override function at(padding:Float):IFixedRgb {
		return a.clone().avarage(b, padding);
	}
}