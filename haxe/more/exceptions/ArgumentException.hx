/** ArgumentException.hx
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
import haxe.more.Default;
import haxe.Stack;

class ArgumentException extends Exception {
	public var paramName(default, null):String;
	public function new(?paramName:String, ?message:String, ?innerException:Exception) {
		super(message == null ? "Value does not fall within the expected range." : message, innerException);
		regenerateStackTrace();
		this.paramName = paramName == null ? "" : paramName;
	}
	
	/**
	 * Returns the string representation of the stackTrace.
	 * @return the string representation of the stackTrace.
	 */
	public override function toString():String return message + Default.newLine + paramName + Stack.toString(rawStackTrace)
}