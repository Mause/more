/** Exception.hx
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

class Exception {
	public var innerException(default, null):Exception;
	public var message(default, null):String;
	public var source(default, null):String;
	public var stackTrace(default, null):ReadOnlyArray<StackItem>;
	
	/**
	 * Constructs a new Exception. Also generates the stackTrace.
	 * @param	?message The message containing info about the exception.
	 * @param	?innerException The exception causing this exception.
	 */
	public function new(?message:String, ?innerException:Exception) {
		this.message = message == null ? "" : message;
		this.innerException = innerException;
		var callStack = Stack.callStack();
		stackTrace = new ReadOnlyArray(callStack); // To be determined, possible use of exceptionStack;
		callStack.shift();
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
	 * Returns an iterator to iterate through the stackTrace.
	 * @return an iterator to iterate through the stackTrace.
	 */
	public function iterator():Iterator<StackItem> return stackTrace.iterator()
}