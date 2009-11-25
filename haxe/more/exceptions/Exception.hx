﻿/** Exception.hx
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
package haxe.more.exceptions;
import haxe.Stack;
import haxe.more.data.structures.ReadOnlyArray;

/**
 * General base class for Exceptions. Automatically generates stackTraces.
 */
class Exception {
	/**
	 * The exception causing this exception.
	 */
	public var innerException(default, null):Exception;
	/**
	 * The message associated with and describing this exception.
	 */
	public var message(default, null):String;
	/**
	 * The trace to the place where this exception was generated and thrown.
	 */
	public var stackTrace(default, null):ReadOnlyArray<StackItem>;
	var rawStackTrace:Array<StackItem>;
	
	/**
	 * Constructs a new Exception and the corresponding stacktrace.
	 * @param	?message The message associated with and describing this exception.
	 * @param	?innerException The exception causing this exception.
	 */
	public function new(?message:String, ?innerException:Exception) {
		this.message = message == null ? "" : message;
		this.innerException = innerException;
		generateStackTrace();
	}
	
	/**
	 * Generates the stacktrace. Is called in the constructor of Exception.
	 * Calling this from somewhere else will result in a corrupted stacktrace.
	 */
	function generateStackTrace() {
		rawStackTrace = Stack.callStack();
		stackTrace = new ReadOnlyArray(rawStackTrace);
		rawStackTrace.shift(); // Shift off this function
		rawStackTrace.shift(); // And Exceptions constructor
		
		var c:Class<Dynamic> = Type.getClass(this);
		while (c != Exception) { // Shift off any Exception construction traces
			rawStackTrace.shift();
			c = Type.getSuperClass(c);
		}
	}
	
	/**
	 * The base exception.
	 */
	public inline var baseException(gBaseException, null):Exception;
	inline function gBaseException() {
		var inner = innerException;
		while (inner.innerException != null)
			inner = inner.innerException;
		return inner;
	}
	
	/**
	 * Returns the string representation of the stackTrace.
	 * @return the string representation of the stackTrace.
	 */
	public function toString():String return message + Stack.toString(rawStackTrace)
	
	/**
	 * Returns an iterator to iterate through the stackTrace.
	 * @return an iterator to iterate through the stackTrace.
	 */
	public function iterator():Iterator<StackItem> return stackTrace.iterator()
}