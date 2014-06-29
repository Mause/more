/** Dragger.hx
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
package haxe.more.spatial.flat;
import haxe.more.data.flow.Enumerable;
import haxe.more.spatial.flat.Point;
using haxe.more.spatial.flat.Point;


typedef Draggable = {
	var x(default, default):Float;
	var y(default, default):Float;
}

class Dragger {
	var _draggables:Array<Draggable>;
	var _prevPos:PointDef;

	public var offset(default, null):Point;

	public function new(offset:Point = null) {
		this.offset = offset == null ? new Point() : offset;

		_draggables = new Array();
	}

	public function drag(newPos:PointDef):Void {
		if (_prevPos == null) {
			_prevPos = newPos;
			return;
		}
		var shift =
			newPos
			.sub(_prevPos)
			.add(offset);

		for (draggable in _draggables) {
			draggable.x += shift.x;
			draggable.y += shift.y;
		}

		_prevPos = newPos;
	}

	public function addDraggable(draggable:Draggable):Dragger {
		_draggables.push(draggable);
		return this;
	}

	public function removeDraggable(draggable:Draggable):Dragger {
		_draggables.remove(draggable);
		return this;
	}
}
