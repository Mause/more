/**
 * ...
 * @author Dykam
 */

package js.more;
import js.Dom;
import js.Lib;

class Css {
	public static function setStyle(elements:Array<String>, styles:Array<{ style:String, value:String }>, action: String -> js.HtmlCollection<js.HtmlDom>):Void {
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