/**
 * ...
 * @author Mark
 */

package haxe.more.data.structures;
import haxe.more.exceptions.Exception;

class EmptyStructureException extends Exception {
	public function new() {
		super();
		regenerateStackTrace();
	}	
}