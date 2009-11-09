/**
 * ...
 * @author Dykam
 */

package haxe.more.spatial;
import haxe.more.exceptions.Exception;
import haxe.more.spatial.flat.IVector;
import haxe.more.data.structures.SingleLinkedList;
import haxe.more.data.sources.EmptyIterable;
import haxe.more.spatial.flat.Vector;
import haxe.more.threading.Threading;

enum Quad {
	topLeft;
	topRight;
	bottomLeft;
	bottomRight;
}

class QuadTree<T:IVector> {
	var _initialized:Bool;
	var _preInitDepth:Int;
	
	var _points(default, null):Iterable<T>;
	
	public var x(default, null):Float;
	public var width(default, null):Float;
	public var dividerX(default, null):Float;
	public var y(default, null):Float;
	public var height(default, null):Float;
	public var dividerY(default, null):Float;
	
	var _topLeft:QuadTree<T>;
	public var topLeft(gTopLeft, null):QuadTree<T>;
	function gTopLeft() {
		initialize();
		return _topLeft;
	}
	var _topRight:QuadTree<T>;
	public var topRight(gTopRight, null):QuadTree<T>;
	function gTopRight() {
		initialize();
		return _topRight;
	}
	var _bottomLeft:QuadTree<T>;
	public var bottomLeft(gBottomLeft, null):QuadTree<T>;
	function gBottomLeft() {
		initialize();
		return _bottomLeft;
	}
	var _bottomRight:QuadTree<T>;
	public var bottomRight(gBottomRight, null):QuadTree<T>;
	function gBottomRight() {
		initialize();
		return _bottomRight;
	}
	
	public function new(points:Iterable<T>, x:Float, width:Float, y:Float, height:Float, preInitDepth:Int = 0) {
		_points = points;
		this.x = x;
		this.height = height;
		this.y = y;
		this.width = width;
		_initialized = false;
		
		dividerX = x + width / 2;
		dividerY = y + height / 2;
		
		if (preInitDepth > 0) {
			_preInitDepth = preInitDepth - 1;
			initializeQuads();
		} else {
			_preInitDepth = 0;
		}
	}
	
	public function iterator():Iterator<T>
		return _points.iterator()	
	
	public  function get(quad:Quad):QuadTree<T> {
		initialize();
		return switch(quad) {
			case topLeft: _topLeft;
			case topRight: _topRight;
			case bottomLeft: _bottomLeft;
			case bottomRight: _bottomRight;
		}
	}
	
	public function getQuadTreeAt(x:Float, y:Float, depth:Int = 0):QuadTree<T> {
		var quad = this;
		while (depth-- > 0) {
			quad = quad.get(quad.getQuadAt(x, y));
		}
		return quad;
	}
	
	public function getQuadAt(x:Float, y:Float):Quad {
		return 
			if (y <= dividerY) {
				if (x <= dividerX)
					Quad.topLeft;
				else
					Quad.topRight;
			} else {
				if (x <= dividerX)
					Quad.bottomLeft;
				else
					Quad.bottomRight;
			}

	}
	
	public function calculate(depth:Int = 0):ThreadRunnerDelegate { // The awesome state machine
		var state = 0;
		var self = this;
		var topLeft:ThreadRunnerDelegate = null;
		var topRight:ThreadRunnerDelegate = null;
		var bottomLeft:ThreadRunnerDelegate = null;
		var bottomRight:ThreadRunnerDelegate = null;
		
		depth--;
		
		return function(time) {
			if (depth < 1) return true;
			
			switch(state) {
			case 0:
				self.initialize();
				topLeft = self._topLeft.calculate(depth);
				topRight = self._topRight.calculate(depth);
				bottomLeft = self._bottomLeft.calculate(depth);
				bottomRight = self._bottomRight.calculate(depth);
				state++;
			case 1:
				if (topLeft(time))
					state++;
			case 2:
				if (topRight(time))
					state++;
			case 3:
				if (bottomLeft(time))
					state++;
			case 4:
				if (bottomRight(time))
					return true;
			}
			return false; // Hey, I am not done yet
		};
	}
	
	inline function initialize()
		if (!_initialized) initializeQuads()
	
	function initializeQuads() {
		_initialized = true;
		var topLeftIterable:Iterable<T>;
		var topRightIterable:Iterable<T>;
		var bottomLeftIterable:Iterable<T>;
		var bottomRightIterable:Iterable<T>;
		
		var iter = _points.iterator();
		if (iter.hasNext()) {
			createFilledSources(iter);
		} else {
			createEmptySources();
		}
	}
	
	function createFilledSources(points:Iterator<T>) {		
		var topLeftList = new SingleLinkedList<T>();
		var topRightList = new SingleLinkedList<T>();
		var bottomLeftList = new SingleLinkedList<T>();
		var bottomRightList = new SingleLinkedList<T>();
		
		pushItems(points, topLeftList, topRightList, bottomLeftList, bottomRightList);
		
		createAndAssignQuadTrees(topLeftList, topRightList, bottomLeftList, bottomRightList);
	}
	
	function pushItems(points:Iterator<T>, topLeft:SingleLinkedList<T>, topRight:SingleLinkedList<T>, bottomLeft:SingleLinkedList<T>, bottomRight:SingleLinkedList<T>)
	{
		for (item in points) {
			if (item.y <= dividerY) {
				if (item.x <= dividerX) {
					topLeft.push(item);
				} else {
					topRight.push(item);
				}
			} else {
				if (item.x <= dividerX) {
					bottomLeft.push(item);
				} else {
					bottomRight.push(item);
				}
			}
		}
	}
	
	inline function createEmptySources() {
		var iterable = new EmptyIterable();
		createAndAssignQuadTrees(iterable, iterable, iterable, iterable);
	}
	
	function createAndAssignQuadTrees(topLeftIterable:Iterable<T>, topRightIterable:Iterable<T>, bottomLeftIterable:Iterable<T>, bottomRightIterable:Iterable<T>) {
		var halfWidth = width / 2;
		var halfHeight = height / 2;
		_topLeft = new QuadTree<T>(topLeftIterable, x, halfWidth, y, halfHeight, _preInitDepth);
		_topRight = new QuadTree<T>(topRightIterable, dividerX, halfWidth, y, halfHeight, _preInitDepth);
		_bottomLeft = new QuadTree<T>(bottomLeftIterable, x, halfWidth, dividerY, halfHeight, _preInitDepth);
		_bottomRight = new QuadTree<T>(bottomRightIterable, dividerX, halfWidth, dividerY, halfHeight, _preInitDepth);
	}
}
