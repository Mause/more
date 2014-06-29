/** Css.hx
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
package js.more;
import js.Dom;
import js.Lib;
import haxe.more.exceptions.ArgumentNullException;

class Css {
	public static function setStyle(elements:Array<String>, styles:Array<{ style:String, value:String }>, action: String -> js.HtmlCollection<js.HtmlDom>):Void {
		if (elements == null) throw new ArgumentNullException("elements");
		if (styles == null) throw new ArgumentNullException("styles");
		if (styles.style == null) throw new ArgumentNullException("styles.style");
		if (styles.value == null) throw new ArgumentNullException("styles.value");
		if (action == null) throw new ArgumentNullException("action");
		for (e in elements) {
			var elements2:js.HtmlCollection<js.HtmlDom> = action(e);
			for (i in 0...elements2.length) {
				var element:js.HtmlDom = elements2[i];
				for (s in styles) {
					untyped __js__("element.style[ s.style ] = s.value");
				}
			}
		}
	}
}
