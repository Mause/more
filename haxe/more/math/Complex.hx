package haxe.more.math;
class Complex {
	public var re:Float;
	public var im:Float;

	public static var zero(get_zero, null):Complex;
	static function get_zero() return new Complex(0, 0);

	public static var one(get_one, null):Complex;
	static function get_one() return new Complex(1, 0);

	public static var i(get_i, null):Complex;
	static function get_i() return new Complex(0, 1);

	public function new(real:Float, imaginary:Float = 0) {
		this.re = real;
		this.im = imaginary;
	}

	public var arg(get_arg, null):Float;
	inline function get_arg() return Math.atan2(im, re);

	public var conj(get_conj, null):Complex;
	inline function get_conj() return new Complex(re, -im);

	public var mod(get_mod, null):Float;
	inline function get_mod() return Math.sqrt(squareMod);

	public var neg(get_neg, null):Complex;
	inline function get_neg() return new Complex(-re, -im);

	public var squareMod(get_squareMod, null):Float;
	inline function get_squareMod() return re * re + im * im;

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
