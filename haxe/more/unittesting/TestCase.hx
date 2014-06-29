/**
 * ...
 * @author Tyler MacLeod
 */

package haxe.more.unittesting;
import haxe.PosInfos;

using Std;
using Type;

class TestCase extends haxe.unit.TestCase
{
	function assertFailure(msg:String, ?c : PosInfos)
	{
		throw setAndGetFailTest(msg, c);
	}

	function assertClass<T, Y>(clazz:Class<T>, item:Y, ?c : PosInfos)
	{
		if (!item.is(clazz))
		{
			throw setAndGetFailTest("Invalid type, expecting " + clazz.getClassName() + " and recieved " + item.getClass().getClassName(), c);
		}
	}

	function assertNotNull<T>(item:T, ?c : PosInfos)
	{
		if (item == null)
		{
			throw setAndGetFailTest("Item was null", c);
		}
	}

	inline function setAndGetFailTest(error:String, c : PosInfos)
	{
		currentTest.success = false;
		currentTest.error = error;
		currentTest.posInfos = c;
		return currentTest;
	}
}
