/** ArgumentNullException.hx
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

class ArgumentNullException extends ArgumentException {
	/**
	 * Constructs a new ArgumentNullException.
	 * @param	?paramName The name of the parameter being null.
	 * @param	?innerException The exception causing this exception.
	 */
	public function new(?paramName:String, ?innerException:Exception) {
		super(paramName, "Argument  " + paramName + " cannot be null.", innerException);
	}
}