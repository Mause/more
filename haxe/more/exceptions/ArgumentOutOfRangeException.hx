/** ArgumentOutOfRangeException.hx
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

class ArgumentOutOfRangeException extends ArgumentException {
	/**
	 * The value being out of range.
	 */
	public var actualValue(default, null):Dynamic;
	
	/**
	 * The expected range.
	 */
	public var expectedRange(default, null):String;
	
	/**
	 * Constructs a new ArgumentException.
	 * @param	?paramName The name of the parameter having an incorrect value.
	 * @param	?message The message associated with and describing this exception.
	 * @param	?innerException The exception causing this exception.
	 * @param	?posInfos The info about the place this exception is thrown.
	 */
	public function new(?paramName:String, ?actualValue:Dynamic, ?expectedRange:String , ?innerException:Exception, ?posInfos:PosInfos) {
		super(paramName, "Value" + (paramName == null ? "" : " of " + paramName) + " does not fall within " + (expectedRange == null ? "the expected range" : expectedRange) + ".", innerException, posInfos);
		this.actualValue = actualValue;
	}	
}
