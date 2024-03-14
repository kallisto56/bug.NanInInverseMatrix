namespace System.Math;


using System;
using System.Diagnostics;


[CRepr, Ordered, Packed, Union]
struct Vector2
{
	readonly static public Vector2 Zero = Vector2(0.0F, 0.0F);
	readonly static public Vector2 one = Vector2(1.0F, 1.0F);

	public float[2] values;


	public float left
	{
		[Inline] get { return this.values[0]; }
		[Inline] set mut { this.values[0] = value; }
	}

	public float x
	{
		[Inline] get { return this.values[0]; }
		[Inline] set mut { this.values[0] = value; }
	}

	public float width
	{
		[Inline] get { return this.values[0]; }
		[Inline] set mut { this.values[0] = value; }
	}


	public float top
	{
		[Inline] get { return this.values[1]; }
		[Inline] set mut { this.values[1] = value; }
	}

	public float y
	{
		[Inline] get { return this.values[1]; }
		[Inline] set mut { this.values[1] = value; }
	}

	public float height
	{
		[Inline] get { return this.values[1]; }
		[Inline] set mut { this.values[1] = value; }
	}


	public this (float value)
	{
		this.values = float[2] (value, value);
	}


	public this (float x, float y)
	{
		this.values = float[2] (x, y);
	}


	public this (Vector2 v)
	{
		this.values = float[2] (v.values[0], v.values[1]);
	}


	static public Vector2 operator + (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			lhs.x + rhs.x,
			lhs.y + rhs.y
		);
	}


	static public Vector2 operator - (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			lhs.x - rhs.x,
			lhs.y - rhs.y
		);
	}


	static public Vector2 operator * (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			lhs.x * rhs.x,
			lhs.y * rhs.y
		);
	}


	[Commutable]
	static public Vector2 operator * (Vector2 lhs, float rhs)
	{
		return Vector2(
			lhs.x * rhs,
			lhs.y * rhs
		);
	}


	static public Vector2 operator / (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			lhs.x / rhs.x,
			lhs.y / rhs.y
		);
	}


	[Commutable]
	static public Vector2 operator / (Vector2 lhs, float rhs)
	{
		return Vector2(
			lhs.x / rhs,
			lhs.y / rhs
		);
	}


	static public Vector2 operator - (Vector2 v)
	{
		return Vector2(-v.x, -v.y);
	}


	public float magnitude
	{
		[Inline] get { return Math.Sqrt(this.x * this.x + this.y * this.y); }
	}


	public float magnitudeSqrt
	{
		[Inline] get { return (this.x * this.x + this.y * this.y); }
	}


	public Vector2 normalized
	{
		[Inline] get { return this / this.magnitude; }
	}


	static public float Distance (Vector2 lhs, Vector2 rhs)
	{
		return (lhs - rhs).magnitude;
	}


	static public Vector2 Lerp (Vector2 min, Vector2 max, float t)
	{
		return Vector2(
			min.x * (1 - t) + max.x * t,
			min.y * (1 - t) + max.y * t
		);
	}


	static public Vector2 Clamp (Vector2 value, Vector2 min, Vector2 max)
	{
		return Vector2(
			Math.Clamp(value.x, min.x, max.x),
			Math.Clamp(value.y, min.y, max.y)
		);
	}


	static public Vector2 Min (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			Math.Min(lhs.x, rhs.x),
			Math.Min(lhs.y, rhs.y)
		);
	}


	static public Vector2 Max (Vector2 lhs, Vector2 rhs)
	{
		return Vector2(
			Math.Max(lhs.x, rhs.x),
			Math.Max(lhs.y, rhs.y)
		);
	}


	override public void ToString (String string)
	{
		string.AppendF("Vector2({}F, {}F)", x, y);
	}


    static public float Dot (Vector2 lhs, Vector2 rhs)
	{
		return (lhs.x * rhs.x) + (lhs.y * rhs.y);
	}


	static public Vector2 PerpendicularClockwise (Vector2 input)
	{
		return Vector2(input.y, -input.x);
	}


	static public Vector2 PerpendicularCounterClockwise (Vector2 input)
	{
		return Vector2(-input.y, input.x);
	}


}