/**
 * ...
 * @author Mark
 */

package haxe.more.positioning;

class Alignment {
	public var horizontal:HorizontalAlignment;
	public var vertical:VerticalAlignment;
	public function new(horizontal:HorizontalAlignment, vertical:VerticalAlignment):Void {
		this.horizontal = horizontal;
		this.vertical = vertical;
	}
}