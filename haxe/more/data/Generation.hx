/** Generation.hx
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
import haxe.more.data.flow.InfiniteEnumerable;
import haxe.more.exceptions.ArgumentOutOfRangeException;
using haxe.more.data.Manipulation;

class Generation {
	public static function repeat<T>(element:T, count:Int = -1):Enumerable<T> {
		if (count < -1)
			throw new ArgumentOutOfRangeException("count", count, "-1 or more");
		return (count == -1) ? new InfiniteEnumerable(element) : new InfiniteEnumerable(element).until(function(element) return count-- <= 0);
	}
}