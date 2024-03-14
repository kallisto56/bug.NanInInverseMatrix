namespace System.Math;


using System;
using System.Diagnostics;


[CRepr, Union]
struct Vector3
{
	const public Vector3 Zero = Vector3(+0F, +0F, +0F);
	const public Vector3 One = Vector3(+1F, +1F, +1F);
	const public Vector3 Right = Vector3(+1F, +0F, +0F);
	const public Vector3 Left = -Vector3.Right;
	const public Vector3 Up = Vector3(+0F, +1F, +0F);
	const public Vector3 Down = -Vector3.Up;
	const public Vector3 Forward = Vector3(+0F, +0F, +1F);
	const public Vector3 Back = -Vector3.Forward;

	public float[3] mValues;


	public this ()
	{
	    this.mValues = float[3](0F, 0F, 0F);
	}


    public this (float x, float y, float z)
    {
        this.mValues = float[3](x,y,z);
    }
    

    public this (float v)
    {
        this.mValues = float[3](v, v, v);
    }
    
    public float x
    {
        [Inline] get { return this.mValues[0]; }
        [Inline] set mut { this.mValues[0] = value; }
    }
    
    public float y
    {
        [Inline] get { return this.mValues[1]; }
        [Inline] set mut { this.mValues[1] = value; }
    }
    
    public float z
    {
        [Inline] get { return this.mValues[2]; }
        [Inline] set mut { this.mValues[2] = value; }
    }
    
    [Inline] public Vector2 xy => Vector2(this.x, this.y);
	[Inline] public Vector2 xz => Vector2(this.x, this.z);
	[Inline] public Vector2 yz => Vector2(this.y, this.z);
    [Inline] public Vector3 xyz => Vector3(this.x, this.y, this.z);
    
    public float Magnitude
	{
		[Inline] get
		{
			return Math.Sqrt(((x*x + y*y) + z*z));
		}
	}
    
    public float SqrtMagnitude
	{
		[Inline] get { return ((x*x + y*y) + z*z); }
	}	
    
    public Vector3 Normalized
	{
		get
		{
			float magnitude = this.Magnitude;
			if (magnitude == 0.0F)
				return .Zero;

			return Vector3(
				float(double(this.x) / double(magnitude)),
				float(double(this.y) / double(magnitude)),
				float(double(this.z) / double(magnitude))
			);
		}
	};


    override public void ToString (String buffer)
	{
		buffer.AppendF("Vector3({0}F, {1}F, {2}F)", x, y, z);
	}


    static public float Dot (Vector3 lhs, Vector3 rhs)
	{
		return (lhs.x * rhs.x) + (lhs.y * rhs.y) + (lhs.z * rhs.z);
	}

	[Inline]
    static public float Distance (Vector3 lhs, Vector3 rhs)
	{
		return (lhs - rhs).Magnitude;
	}

	[Inline]
    static public float DistanceSqrt (Vector3 lhs, Vector3 rhs)
	{
		return (lhs - rhs).SqrtMagnitude;
	}

	[Inline]
    static public Vector3 Cross (Vector3 l, Vector3 r)
	{
		return Vector3(
			l.y * r.z - l.z * r.y,
			l.z * r.x - l.x * r.z,
			l.x * r.y - l.y * r.x
		);
	}

    static public Vector3 Clamp (Vector3 v, Vector3 min, Vector3 max)
	{
		return Vector3(
			Math.Min(Math.Max(v.x, min.x), max.x),
			Math.Min(Math.Max(v.y, min.y), max.y),
			Math.Min(Math.Max(v.z, min.z), max.z)
		);
	}

    static public Vector3 Lerp (Vector3 min, Vector3 max, float a)
	{
		return Vector3(
			min.x * (1-a) + max.x * a,
			min.y * (1-a) + max.y * a,
			min.z * (1-a) + max.z * a
		);
	}

	public bool IsNaN ()
	{
		return this.x.IsNaN || this.y.IsNaN || this.z.IsNaN;
	}


	static public Vector3 ClampMagnitude (Vector3 v, float maximumLength)
	{
		// TODO: This is taken from Unity C# Reference source code (UnityCsReference-2019.3.10f1\Runtime\Export\Math\Vector3.cs)
		float inputSqrtMagnitude = v.SqrtMagnitude;
		if (inputSqrtMagnitude > maximumLength * maximumLength)
			return (v / Math.Sqrt(inputSqrtMagnitude)) * maximumLength;

		return v;
	}


	static public float Angle (Vector3 lhs, Vector3 rhs)
	{
		float denominator = Math.Sqrt(lhs.SqrtMagnitude * rhs.SqrtMagnitude);
		if (denominator < Math.epsilonNormalSqrt)
		    return 0.0F;

		float dotProduct = Math.Clamp(Vector3.Dot(lhs, rhs) / denominator, -1.0F, 1.0F);
		//return Math.Acos(dotProduct) * Math.Rad2Deg;
		return Math.ToDegrees(Math.Acos(dotProduct));
	}


	static public Vector3 Angle (Vector3 axis, float angleInDegree)
	{
		return axis * angleInDegree;
	}


	static public Vector3 Slerp (Vector3 start, Vector3 end, float percentage)
	{
		float dot = Math.Clamp(Vector3.Dot(start, end), -1.0F, +1.0F);
		float theta = Math.Acos(dot) * percentage;
		Vector3 v = (end - start * dot).Normalized;

		return start * Math.Cos(theta) + v * Math.Sin(theta);
	}


    static public Vector3 operator + (Vector3 lhs, Vector3 rhs)
	{
		return Vector3(
			lhs.x + rhs.x,
			lhs.y + rhs.y,
			lhs.z + rhs.z
		);
	}


	static public Vector3 operator + (Vector3 lhs, float rhs)
	{
	    return Vector3(
	        lhs.x + rhs,
	        lhs.y + rhs,
	        lhs.z + rhs
	    );
	}


	static public Vector3 operator + (float lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs + rhs.x,
	        lhs + rhs.y,
	        lhs + rhs.z
	    );
	}


	static public Vector3 operator - (Vector3 lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs.x - rhs.x,
	        lhs.y - rhs.y,
	        lhs.z - rhs.z
	    );
	}


	static public Vector3 operator - (Vector3 lhs, float rhs)
	{
	    return Vector3(
	        lhs.x - rhs,
	        lhs.y - rhs,
	        lhs.z - rhs
	    );
	}


	static public Vector3 operator - (float lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs - rhs.x,
	        lhs - rhs.y,
	        lhs - rhs.z
	    );
	}


	static public Vector3 operator * (Vector3 lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs.x * rhs.x,
	        lhs.y * rhs.y,
	        lhs.z * rhs.z
	    );
	}


	static public Vector3 operator *(Vector3 lhs, float rhs)
	{
	    return Vector3(
	        lhs.x * rhs,
	        lhs.y * rhs,
	        lhs.z * rhs
	    );
	}


	static public Vector3 operator * (float lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs * rhs.x,
	        lhs * rhs.y,
	        lhs * rhs.z
	    );
	}


	static public Vector3 operator / (Vector3 lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs.x / rhs.x,
	        lhs.y / rhs.y,
	        lhs.z / rhs.z
	    );
	}


	static public Vector3 operator / (Vector3 lhs, float rhs)
	{
	    return Vector3(
	        lhs.x / rhs,
	        lhs.y / rhs,
	        lhs.z / rhs
	    );
	}


	static public Vector3 operator / (float lhs, Vector3 rhs)
	{
	    return Vector3(
	        lhs / rhs.x,
	        lhs / rhs.y,
	        lhs / rhs.z
	    );
	}


	static public Vector3 operator - (Vector3 v)
	{
	    return Vector3(
	        -v.x,
	        -v.y,
	        -v.z
	    );
	}



	static public bool operator == (Vector3 lhs, Vector3 rhs)
	{
	    return (
			lhs.x == rhs.x &&
			lhs.y == rhs.y &&
			lhs.z == rhs.z
	    );
	}


	static public bool operator != (Vector3 lhs, Vector3 rhs)
	{
	    return (
			lhs.x != rhs.x ||
			lhs.y != rhs.y ||
			lhs.z != rhs.z
		);
	}


	static public Vector3 Abs (Vector3 v)
	{
		return Vector3(
			Math.Abs(v.x),
			Math.Abs(v.y),
			Math.Abs(v.z)
		);
	}


	static public Vector3 Project (Vector3 vector, Vector3 normal)
	{
	    float sqrtMagnitude = Vector3.Dot(normal, normal);
	    if (sqrtMagnitude < Math.[Friend]sMachineEpsilonFloat)
	        return .Zero;

	   	float dot = Vector3.Dot(vector, normal);
		return Vector3(
			normal.x * dot / sqrtMagnitude,
		    normal.y * dot / sqrtMagnitude,
		    normal.z * dot / sqrtMagnitude
		);
	}

    
}