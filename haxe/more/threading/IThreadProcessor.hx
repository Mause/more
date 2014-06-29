/** IThreadProcessor.hx
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
package haxe.more.threading;
import haxe.more.threading.Threading;

interface IThreadProcessor {
	public var count(default, null):Int;
	public function add(thread:ThreadRunnerDelegate, priority:Int = 128):IThreadProcessor;
	public function adjust(thread:ThreadRunnerDelegate, priority:Int):Bool;
	/**
	 * Removes a thread.
	 * @param	thread the thread to remove.
	 * @return Returns true if the thread was found and removed.
	 */
	public function remove(thread:ThreadRunnerDelegate):Bool;
	public function process(time:Int):Bool;
	public function contains(thread:ThreadRunnerDelegate):Int;
}
