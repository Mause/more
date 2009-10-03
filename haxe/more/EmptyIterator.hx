/**
 * ...
 * @author Dykam
 */

package haxe.more;

class EmptyIterator < T > {
	public function new();
	public function hasNext() return false
	public function next():T return null
}