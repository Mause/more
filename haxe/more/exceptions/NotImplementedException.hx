/** NotImplementedException.hx
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
import haxe.PosInfos;
import haxe.Stack;

class NotImplementedException extends Exception {
	public var methodName(default, null):String;
	/**
	 * Constructs a new NotImplementedException.
	 * @param	?methodName The name of the method not being fully implemented.
	 * @param	?message The message associated with and describing this exception.
	 * @param	?innerException The exception causing this exception.
	 * @param	?posInfos The info about the place this exception is thrown.
	 */
	public function new(?methodName:String, ?message:String, ?innerException:Exception, ?posInfos:PosInfos) {
		super(message == null ? "Method \"" + (methodName == null ? posInfos.methodName : methodName) + "\" is not implemented" : message, innerException, posInfos);
		this.methodName = methodName == null ? posInfos.methodName : methodName;
	}
}
