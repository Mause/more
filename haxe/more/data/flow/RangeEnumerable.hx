/**
 * ...
 * @author
 */

package haxe.more.data.flow;

class RangeEnumerable#if!H<T>#end implements Enumerable<T> {
	var _subject:Enumerable<T>;
	var _skip:Int;
	var _take:Int;
	public function new(subject:Enumerable<T>, skip:Int = 0, take:Int = -1) {
		_subject = subject;
		_skip = skip;
		_take = take;
	}

	public function getEnumerator():Enumerator<T>
		return new RangeEnumerator(_subject.getEnumerator(), _skip, _take);
}
