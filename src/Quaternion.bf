namespace System.Math;


using System;
using System.Diagnostics;


[CRepr, Union]
struct Quaternion
{
	const public Quaternion Identity = Quaternion(0f, 0f, 0f, 1F);

    public float[4] mValues;


    public this (float x, float y, float z, float w)
    {
        mValues = .(x,y,z,w);
    }


	public this (float v)
	{
	    this.mValues = float[4](v, v, v, v);
	}
    
    
    public this (Quaternion q)
    {
        this.mValues = float[4](q.x, q.y, q.z, q.w);
    }

	public this (Matrix4x4 m)
	{
		this.mValues = float[4]();
		// Adapted from: http://www.euclideanspace.com/maths/geometry/rotations/conversions/matrixToQuaternion/index.htm
		this.w = Math.Sqrt(Math.Max(0, 1 + m[0,0] + m[1,1] + m[2,2])) / 2; 
		this.x = Math.Sqrt(Math.Max(0, 1 + m[0,0] - m[1,1] - m[2,2])) / 2; 
		this.y = Math.Sqrt(Math.Max(0, 1 - m[0,0] + m[1,1] - m[2,2])) / 2; 
		this.z = Math.Sqrt(Math.Max(0, 1 - m[0,0] - m[1,1] + m[2,2])) / 2; 
		this.x *= Math.Sign(this.x * (m[2,1] - m[1,2]));
		this.y *= Math.Sign(this.y * (m[0,2] - m[2,0]));
		this.z *= Math.Sign(this.z * (m[1,0] - m[0,1]));
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
    
    public float Length
	{
		get { return Math.Sqrt((x*x + y*y) + (z*z + w*w)); }
	}
    
    public float LengthSqrt
	{
		get { return ((x*x + y*y) + (z*z + w*w)); }
	}
    
    public Quaternion Normalized
	{
		get { return this / Length; }
	}
    
    public double Angle
	{
		[Inline] get { return Math.Acos(w) * 2.0F; }
	}
    
    public Vector3 Axis
    {
        [Inline] get
        {
            let s1 = 1 - w * w;
            if (s1 < 0) return Vector3.Forward;
            let s2 = 1 / Math.Sqrt(s1);
            return  Vector3((float)(x * s2), (float)(y * s2), (float)(z * s2));
        }
    }
    
    public float Yaw
	{
		[Inline] get { return Math.Asin(-2.0F * (x * z - w * y)); }
	}

    public float Pitch
	{
		[Inline] get { return Math.Atan2(2.0F * (y * z + w * x), (w * w - x * x - y * y + z * z)); }
	}

    public float Roll
	{
		[Inline] get { return Math.Atan2(2.0F * (x * y + w * z), (w * w + x * x - y * y - z * z)); }
	}

    public Vector3 EulerAngles
	{
		[Inline] get { return Vector3(this.Pitch, this.Yaw, this.Roll); }
	}

    public Quaternion Conjugate
	{
		[Inline] get { return Quaternion(-x, -y, -z, w); }
	}

    public Quaternion Inverse
	{
		[Inline] get { return this.Conjugate / this.LengthSqrt; }
	}

    public static bool operator==(Quaternion lhs, Quaternion rhs)
	{
		return (
			lhs.x == rhs.x &&
			lhs.y == rhs.y &&
			lhs.z == rhs.z &&
			lhs.w == rhs.w
		);
	}
    
    static public bool operator != (Quaternion lhs, Quaternion rhs)
	{
		return (
			lhs.x != rhs.x ||
			lhs.y != rhs.y ||
			lhs.z != rhs.z ||
			lhs.w != rhs.w
		);
	}
    
    static public Quaternion operator * (Quaternion lhs, Quaternion rhs)
	{
		return Quaternion(
			lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y,
			lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z,
			lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x,
			lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z
		);
	}
    
    static public Vector3 operator * (Quaternion q, Vector3 v)
    {
		float qx = q.x * 2F;
		float qy = q.y * 2F;
		float qz = q.z * 2F;

		float xx = q.x * qx;
		float yy = q.y * qy;
		float zz = q.z * qz;

		float xy = q.x * qy;
		float xz = q.x * qz;
		float yz = q.y * qz;

		float wx = q.w * qx;
		float wy = q.w * qy;
		float wz = q.w * qz;

		return Vector3(
			(1F - (yy + zz)) * v.x + (xy - wz) * v.y + (xz + wy) * v.z,
			(xy + wz) * v.x + (1F - (xx + zz)) * v.y + (yz - wx) * v.z,
			(xz - wy) * v.x + (yz + wx) * v.y + (1F - (xx + yy)) * v.z
		);
    }
    
    static public Vector3 operator * (Vector3 v, Quaternion q)
	{
		return q.Inverse * v;
	}
    
    public Quaternion Rotated(float angle, Vector3 v)
	{
		return this * Quaternion.FromAxisAngle(angle, v);
	}

    static public float Dot (Quaternion lhs, Quaternion rhs)
	{
		return (lhs.x * rhs.x + lhs.y * rhs.y) + (lhs.z * rhs.z + lhs.w * rhs.w);
	}

    static public Quaternion FromAxisAngle (float angle, Vector3 v)
    {
        let s = Math.Sin((double)angle * 0.5);
        let c = Math.Cos((double)angle * 0.5);
        return  Quaternion((float)((double)v.x * s), (float)((double)v.y * s), (float)((double)v.z * s), (float)c);
    }

	static public Quaternion AngleAxis (float radians, Vector3 axis)
	{
		if (axis.SqrtMagnitude == 0.0f)
		    return .Identity;

		var radians, axis;

		radians *= 0.5F;
		axis = axis.Normalized * Math.Sin(radians);

		return Quaternion(axis.x, axis.y, axis.z, Math.Cos(radians)).Normalized;
	}


	static public Quaternion FromRotation (Vector3 src, Vector3 dst)
	{
		Vector3 axis = Vector3.Cross(src, dst);
		float angle = Vector3.Angle(src, dst);
		return Quaternion.AngleAxis(angle, axis.Normalized);
	}
    
    static public Quaternion Cross (Quaternion q1, Quaternion q2)
	{
	    return Quaternion(q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y, q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z, q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x, q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z);
	}


	static public Quaternion Lerp (Quaternion min, Quaternion max, Quaternion a)
	{
	    return Quaternion(min.x * (1-a.x) + max.x * a.x, min.y * (1-a.y) + max.y * a.y, min.z * (1-a.z) + max.z * a.z, min.w * (1-a.w) + max.w * a.w);
	}


	static public Quaternion Lerp (Quaternion min, Quaternion max, float a)
	{
	    return Quaternion(min.x * (1-a) + max.x * a, min.y * (1-a) + max.y * a, min.z * (1-a) + max.z * a, min.w * (1-a) + max.w * a);
	}


	static public Quaternion Lerp (Quaternion min, float max, Quaternion a)
	{
	    return Quaternion(min.x * (1-a.x) + max * a.x, min.y * (1-a.y) + max * a.y, min.z * (1-a.z) + max * a.z, min.w * (1-a.w) + max * a.w);
	}


	static public Quaternion Lerp (Quaternion min, float max, float a)
	{
	    return Quaternion(min.x * (1-a) + max * a, min.y * (1-a) + max * a, min.z * (1-a) + max * a, min.w * (1-a) + max * a);
	}


	static public Quaternion Lerp (float min, Quaternion max, Quaternion a)
	{
	    return Quaternion(min * (1-a.x) + max.x * a.x, min * (1-a.y) + max.y * a.y, min * (1-a.z) + max.z * a.z, min * (1-a.w) + max.w * a.w);
	}


	static public Quaternion Lerp (float min, Quaternion max, float a)
	{
	    return Quaternion(min * (1-a) + max.x * a, min * (1-a) + max.y * a, min * (1-a) + max.z * a, min * (1-a) + max.w * a);
	}


	static public Quaternion Lerp (float min, float max, Quaternion a)
	{
	    return Quaternion(min * (1-a.x) + max * a.x, min * (1-a.y) + max * a.y, min * (1-a.z) + max * a.z, min * (1-a.w) + max * a.w);
	}


	static public Quaternion Lerp (float min, float max, float a)
	{
	    return Quaternion(min * (1-a) + max * a);
	}


    static public Quaternion operator - (Quaternion v)
	{
	    return Quaternion(-v.x, -v.y, -v.z, -v.w);
	}

	static public Quaternion operator + (Quaternion lhs, Quaternion rhs)
	{
	    return Quaternion(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w);
	}

	static public Quaternion operator + (Quaternion lhs, float rhs)
	{
	    return Quaternion(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs, lhs.w + rhs);
	}

	static public Quaternion operator + (float lhs, Quaternion rhs)
	{
	    return Quaternion(lhs + rhs.x, lhs + rhs.y, lhs + rhs.z, lhs + rhs.w);
	}

	static public Quaternion operator - (Quaternion lhs, Quaternion rhs)
	{
	    return Quaternion(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w);
	}

	static public Quaternion operator - (Quaternion lhs, float rhs)
	{
	    return Quaternion(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs, lhs.w - rhs);
	}

	static public Quaternion operator - (float lhs, Quaternion rhs)
	{
	    return Quaternion(lhs - rhs.x, lhs - rhs.y, lhs - rhs.z, lhs - rhs.w);
	}

	static public Quaternion operator * (Quaternion lhs, float rhs)
	{
	    return Quaternion(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs);
	}

	static public Quaternion operator * (float lhs, Quaternion rhs)
	{
	    return Quaternion(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w);
	}

	static public Quaternion operator / (Quaternion lhs, float rhs)
	{
	    return Quaternion(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs);
	}


	override public void ToString (String buffer)
	{
		buffer.AppendF("Quaternion({}, {}, {}, {})", x, y, z, w);
	}

}