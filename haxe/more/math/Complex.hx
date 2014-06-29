package haxe.more.math;
class Complex {
	public var re:Float;
	public var im:Float;

	public static var zero(gZero, null):Complex;
	static function gZero() return new Complex(0, 0)

	public static var one(gOne, null):Complex;
	static function gOne() return new Complex(1, 0)

	public static var i(gI, null):Complex;
	static function gI() return new Complex(0, 1)

	public function new(real:Float, imaginary:Float = 0) {
		this.re = real;
		this.im = imaginary;
	}

	public inline var arg(gArg, null):Float;
	inline function gArg() return Math.atan2(im, re)

	public inline var conj(gConj, null):Complex;
	inline function gConj() return new Complex(re, -im)

	public inline var mod(gMod, null):Float;
	inline function gMod() return Math.sqrt(squareMod)

	public inline var neg(gNeg, null):Complex;
	inline function gNeg() return new Complex(-re, -im)

	public inline var squareMod(gSquareMod, null):Float;
	inline function gSquareMod() return re * re + im * im

	public function add(c:Complex):Complex {
		return new Complex(re + c.re, im + c.im);
	}

	public function sub(c:Complex):Complex {
		return new Complex(re - c.re, im - c.im);
	}

	public function mul(c:Complex):Complex {
		// (x + yi)(u + vi) = (xu – yv) + (xv + yu)i.
		return new Complex(re * c.re - im * c.im, re * c.im + im * c.re);
	}

	public function div(c:Complex):Complex {
		var invModSquare = 1 / c.squareMod;
		return new Complex(
			(re * c.re + im * c.im) * invModSquare,
			(im * c.re - re * c.im) * invModSquare
		);
	}

	public function equals(c:Complex):Bool {
		return re == c.re && im == c.im;
	}

	public function equalTo(c:Complex, precision:Float):Bool {
		return re - c.re < precision && im - c.im < precision;
	}

	public function toString():String {
		return "(" + re + " + " + im + "i)";
	}

	public static inline function addFloat(c:Complex, re:Float):Complex {
		return new Complex(c.re + re, c.im + 0);
	}

	public static inline function subFloat(c:Complex, re:Float):Complex {
		return new Complex(c.re - re, c.im - 0);
	}

	public static inline function mulFloat(c:Complex, f:Float):Complex {
		return new Complex(c.re * f, c.im * f);
	}

	public static inline function divFloat(c:Complex, f:Float):Complex {
		var invF = 1 / f;
		return new Complex(
			c.re * invF,
			c.im * invF
		);
	}
}
