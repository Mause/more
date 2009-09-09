package haxe.more;

class AnonymousContainer {
	public function new(func:AnonymousSelf<T>) this.func = func
	public func(default, null):AnonymousSelf<T>;
}