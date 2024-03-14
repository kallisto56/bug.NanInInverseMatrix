namespace System.Math;


using System;
using System.Diagnostics;


[CRepr]
struct Vector4
{
	const public Vector4 cZero = Vector4(0F, 0F, 0F, 0F);
	const public Vector4 cOne = Vector4(1F, 1F, 1F, 1F);

	public float[4] mValues;


	public this ()
	{
		this.mValues = float[4](0F, 0F, 0F, 0F);
	}
	

	public this (float x, float y, float z, float w)
	{
		this.mValues = float[4](x, y, z, w);
	}
	

	public this (float v)
	{
		this.mValues = float[4](v, v, v, v);
	}
	

	public this (Vector3 v, float w = 0F)
	{
		this.mValues = float[4](v.x, v.y, v.z, w);
	}
	

	public this (Vector4 v)
	{
		this.mValues = .(v.x, v.y, v.z, v.w);
	}

	public float x
	{
		[Inline]get { return this.mValues[0]; }
		[Inline]set mut { this.mValues[0] = value; }
	}

	public float y
	{
		[Inline]get { return this.mValues[1]; }
		[Inline]set mut { this.mValues[1] = value; }
	}

	public float z
	{
		[Inline]get { return this.mValues[2]; }
		[Inline]set mut { this.mValues[2] = value; }
	}

	public float w
	{
		[Inline]get { return this.mValues[3]; }
		[Inline]set mut { this.mValues[3] = value; }
	}

	

	public float left
	{
		[Inline]get { return this.mValues[0]; }
		[Inline]set mut { this.mValues[0] = value; }
	}

	public float top
	{
		[Inline]get { return this.mValues[1]; }
		[Inline]set mut { this.mValues[1] = value; }
	}

	public float width
	{
		[Inline]get { return this.mValues[2]; }
		[Inline]set mut { this.mValues[2] = value; }
	}

	public float height
	{
		[Inline]get { return this.mValues[3]; }
		[Inline]set mut { this.mValues[3] = value; }
	}

	public float length
	{
		get { return Math.Sqrt((x*x + y*y) + (z*z + w*w)); }
	}

	public float lengthSqr
	{
		get { return (x * x + y * y) + (z * z + w * w); }
	}

	public Vector4 normalized
	{
		get { return this / this.length; }
	}

	public Vector3 xyz
	{
		[Inline]get { return Vector3(this.mValues[0], this.mValues[1], this.mValues[2]); }
	}





	

	static public explicit operator Vector2(Vector4 v) => Vector2((float)v.x, (float)v.y);
	static public explicit operator Vector3(Vector4 v) => Vector3((float)v.x, (float)v.y, (float)v.z);
	static public bool operator==(Vector4 lhs, Vector4 rhs) => ((lhs.x == rhs.x && lhs.y == rhs.y) && (lhs.z == rhs.z && lhs.w == rhs.w));
	static public bool operator!=(Vector4 lhs, Vector4 rhs) => !((lhs.x == rhs.x && lhs.y == rhs.y) && (lhs.z == rhs.z && lhs.w == rhs.w));
	static public Vector4 operator+(Vector4 lhs, Vector4 rhs) => Vector4(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w);
	static public Vector4 operator+(Vector4 lhs, float rhs) => Vector4(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs, lhs.w + rhs);
	static public Vector4 operator+(float lhs, Vector4 rhs) => Vector4(lhs + rhs.x, lhs + rhs.y, lhs + rhs.z, lhs + rhs.w);
	static public Vector4 operator-(Vector4 lhs, Vector4 rhs) => Vector4(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w);
	static public Vector4 operator-(Vector4 lhs, float rhs) => Vector4(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs, lhs.w - rhs);
	static public Vector4 operator-(float lhs, Vector4 rhs) => Vector4(lhs - rhs.x, lhs - rhs.y, lhs - rhs.z, lhs - rhs.w);
	static public Vector4 operator*(Vector4 lhs, Vector4 rhs) => Vector4(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w);
	static public Vector4 operator*(Vector4 lhs, float rhs) => Vector4(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs);
	static public Vector4 operator*(float lhs, Vector4 rhs) => Vector4(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w);
	static public Vector4 operator/(Vector4 lhs, Vector4 rhs) => Vector4(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w);
	static public Vector4 operator/(Vector4 lhs, float rhs) => Vector4(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs);
	static public Vector4 operator/(float lhs, Vector4 rhs) => Vector4(lhs / rhs.x, lhs / rhs.y, lhs / rhs.z, lhs / rhs.w);
	static public Vector4 operator-(Vector4 v) => Vector4(-v.x, -v.y, -v.z, -v.w);
	static public Vector4 operator%(Vector4 lhs, Vector4 rhs) => Vector4(lhs.x % rhs.x, lhs.y % rhs.y, lhs.z % rhs.z, lhs.w % rhs.w);
	static public Vector4 operator%(Vector4 lhs, float rhs) => Vector4(lhs.x % rhs, lhs.y % rhs, lhs.z % rhs, lhs.w % rhs);
	static public Vector4 operator%(float lhs, Vector4 rhs) => Vector4(lhs % rhs.x, lhs % rhs.y, lhs % rhs.z, lhs % rhs.w);

	static public Vector4 LessThanEqual (Vector4 lhs, Vector4 rhs)
	{
		return Vector4(
			lhs.x <= rhs.x ? 1F : 0F,
			lhs.y <= rhs.y ? 1F : 0F,
			lhs.z <= rhs.z ? 1F : 0F,
			lhs.w <= rhs.w ? 1F : 0F
		);
	}

	override public void ToString (String stringBuffer)
	{
		stringBuffer.AppendF("Vector4({0}F, {1}F, {2}F, {3}F)", mValues[0], mValues[1], mValues[2], mValues[3]);
	}


	static public Vector4 Lerp (Vector4 min, Vector4 max, float alpha)
	{
		let oneMinusAlpha = 1.0F - alpha;

		return Vector4(
			min.x * oneMinusAlpha + max.x * alpha,
			min.y * oneMinusAlpha + max.y * alpha,
			min.z * oneMinusAlpha + max.z * alpha,
			min.w * oneMinusAlpha + max.w * alpha
		);
	}



}