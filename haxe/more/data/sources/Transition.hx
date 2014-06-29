/** Transition.hx
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
package haxe.more.data.sources;
import haxe.more.exceptions.Exception;
typedef Blender<A, B, C> = A -> B -> Float -> C;
class Transition#if!H<A, B, C>#end {
	public var a:A;
	public var b:B;
	public var blender:Blender<A, B, C>;
	public function new(a:A, b:B, blender:Blender<A, B, C>) {
		this.a = a;
		this.b = b;
		this.blender = blender;
	}

	public function at(padding:Float):C {
		return blender(a, b, padding);
	}

	public function range(parts:Int = 256):Iterable<C> {
		return new TransitionIterable<A, B, C>(this, parts);
	}
}

private class TransitionIterable<A, B, C> {
	var _transition:Transition<A, B, C>;
	var _parts:Int;
	public function new(transition:Transition<A, B, C>, parts:Int = 256) {
		_transition = transition;
		_parts = parts;
	}

	public function iterator():Iterator<C>
		return new TransitionIterator<A, B, C>(_transition, _parts)
}
private class TransitionIterator<A, B, C> {
	var _transition:Transition<A, B, C>;
	var _step:Float;
	var _current:Float;
	public function new(transition:Transition<A, B, C>, parts:Int = 256) {
		_transition = transition;
		_step = 1 / parts;
		_current = 0;
	}
	public function hasNext() return _current <= 1

	public function next():C {
		if (hasNext()) {
			var value = _transition.at(_current);
			_current += _step;
			return value;
		}
		throw new Exception("No values left");
	}
}
