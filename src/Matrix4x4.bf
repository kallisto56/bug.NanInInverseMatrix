namespace System.Math;


using System;
using System.Diagnostics;


[CRepr]
struct Matrix4x4
{
	const public Matrix4x4 cIdentity = Matrix4x4(
		1F, 0F, 0F, 0F,
		0F, 1F, 0F, 0F,
		0F, 0F, 1F, 0F,
		0F, 0F, 0F, 1F
	);

    public float[16] mValues;

    
	public this (
		float m00, float m01, float m02, float m03,
		float m10, float m11, float m12, float m13,
		float m20, float m21, float m22, float m23,
		float m30, float m31, float m32, float m33
	)
	{
		this.mValues = float[16] (
			m00, m01, m02, m03,
			m10, m11, m12, m13,
			m20, m21, m22, m23,
			m30, m31, m32, m33
		);
	}
    
    
    public this (Matrix4x4 m)
    {
        this.mValues = float[16](
			m.m00, m.m01, m.m02, m.m03,
			m.m10, m.m11, m.m12, m.m13,
			m.m20, m.m21, m.m22, m.m23,
			m.m30, m.m31, m.m32, m.m33
		);
    }


	public this (Quaternion q)
	{
		//  => q.ToMat4;
		// Conversion from:
		// - Quaternion to Matrix3x2
		// - Matrix3x2 to Matrix4x4
		float m00 = 1F - 2F * (q.y*q.y + q.z*q.z);
		float m01 = 2F * (q.x*q.y + q.w*q.z);
		float m02 = 2F * (q.x*q.z - q.w*q.y);
		float m10 = 2F * (q.x*q.y - q.w*q.z);
		float m11 = 1F - 2F * (q.x*q.x + q.z*q.z);
		float m12 = 2F * (q.y*q.z + q.w*q.x);
		float m20 = 2F * (q.x*q.z + q.w*q.y);
		float m21 = 2F * (q.y*q.z - q.w*q.x);
		float m22 = 1F - 2F * (q.x*q.x + q.y*q.y);

		this.mValues = float[16] (
			m00, m01, m02, 0F,
			m10, m11, m12, 0F,
			m20, m21, m22, 0F,
			0F, 0F, 0F, 1F
		);
	}
	
	public float m00 { [Inline] get { return this.mValues[00]; } [Inline] set mut { this.mValues[00] = value; } }
	public float m01 { [Inline] get { return this.mValues[01]; } [Inline] set mut { this.mValues[01] = value; } }
	public float m02 { [Inline] get { return this.mValues[02]; } [Inline] set mut { this.mValues[02] = value; } }
	public float m03 { [Inline] get { return this.mValues[03]; } [Inline] set mut { this.mValues[03] = value; } }

	public float m10 { [Inline] get { return this.mValues[04]; } [Inline] set mut { this.mValues[04] = value; } }
	public float m11 { [Inline] get { return this.mValues[05]; } [Inline] set mut { this.mValues[05] = value; } }
	public float m12 { [Inline] get { return this.mValues[06]; } [Inline] set mut { this.mValues[06] = value; } }
	public float m13 { [Inline] get { return this.mValues[07]; } [Inline] set mut { this.mValues[07] = value; } }

	public float m20 { [Inline] get { return this.mValues[08]; } [Inline] set mut { this.mValues[08] = value; } }
	public float m21 { [Inline] get { return this.mValues[09]; } [Inline] set mut { this.mValues[09] = value; } }
	public float m22 { [Inline] get { return this.mValues[10]; } [Inline] set mut { this.mValues[10] = value; } }
	public float m23 { [Inline] get { return this.mValues[11]; } [Inline] set mut { this.mValues[11] = value; } }

	public float m30 { [Inline] get { return this.mValues[12]; } [Inline] set mut { this.mValues[12] = value; } }
	public float m31 { [Inline] get { return this.mValues[13]; } [Inline] set mut { this.mValues[13] = value; } }
	public float m32 { [Inline] get { return this.mValues[14]; } [Inline] set mut { this.mValues[14] = value; } }
	public float m33 { [Inline] get { return this.mValues[15]; } [Inline] set mut { this.mValues[15] = value; } }
    
    public Vector4 Column0
    {
        [Inline]get
        {
            return  Vector4(m00, m01, m02, m03);
        }
        [Inline]set mut
        {
            m00 = value.x;
            m01 = value.y;
            m02 = value.z;
            m03 = value.w;
        }
    }
    
    public Vector4 Column1
    {
        [Inline]get
        {
            return  Vector4(m10, m11, m12, m13);
        }
        [Inline]set mut
        {
            m10 = value.x;
            m11 = value.y;
            m12 = value.z;
            m13 = value.w;
        }
    }
    
    public Vector4 Column2
    {
        [Inline]get
        {
            return  Vector4(m20, m21, m22, m23);
        }
        [Inline]set mut
        {
            m20 = value.x;
            m21 = value.y;
            m22 = value.z;
            m23 = value.w;
        }
    }
    
    public Vector4 Column3
    {
        [Inline]get
        {
            return  Vector4(m30, m31, m32, m33);
        }
        [Inline]set mut
        {
            m30 = value.x;
            m31 = value.y;
            m32 = value.z;
            m33 = value.w;
        }
    }
    
    public Vector4 Row0
    {
        [Inline]get
        {
            return  Vector4(m00, m10, m20, m30);
        }
        [Inline]set mut
        {
            m00 = value.x;
            m10 = value.y;
            m20 = value.z;
            m30 = value.w;
        }
    }
    
    public Vector4 Row1
    {
        [Inline]get
        {
            return  Vector4(m01, m11, m21, m31);
        }
        [Inline]set mut
        {
            m01 = value.x;
            m11 = value.y;
            m21 = value.z;
            m31 = value.w;
        }
    }
    
    public Vector4 Row2
    {
        [Inline]get
        {
            return  Vector4(m02, m12, m22, m32);
        }
        [Inline]set mut
        {
            m02 = value.x;
            m12 = value.y;
            m22 = value.z;
            m32 = value.w;
        }
    }
    
    public Vector4 Row3
    {
        [Inline]get
        {
            return  Vector4(m03, m13, m23, m33);
        }
        [Inline]set mut
        {
            m03 = value.x;
            m13 = value.y;
            m23 = value.z;
            m33 = value.w;
        }
    }

    public float this[int fieldIndex]
    {
        [Inline]get
        {
           Debug.Assert(fieldIndex >= 0 && fieldIndex < 16, "fieldIndex was out of range");
           unchecked { return mValues[fieldIndex]; }
        }
        [Inline]set mut
        {
           Debug.Assert(fieldIndex >= 0 && fieldIndex < 16, "fieldIndex was out of range");
           unchecked { mValues[fieldIndex] = value; }
        }
    }
    
    public float this[int col, int row]
    {
        [Inline]get
        {
            Debug.Assert(col >= 0 && col < 4, "col was out of range");
            Debug.Assert(row >= 0 && row < 4, "row was out of range");
            unchecked { return mValues[col * 4 + row]; }
        }
        [Inline]set mut
        {
            Debug.Assert(col >= 0 && col < 4, "col was out of range");
            Debug.Assert(row >= 0 && row < 4, "row was out of range");
            unchecked { mValues[col * 4 + row] = value; }
        }
    }
    
    public Matrix4x4 Transposed
	{
		[Inline] get
		{
			return Matrix4x4(
				m00, m10, m20, m30,
				m01, m11, m21, m31,
				m02, m12, m22, m32,
				m03, m13, m23, m33
			);
		}
	}
    
	public float Determinant
	{
		get
		{
			return
				m00 * (m11 * (m22 * m33 - m32 * m23) - m21 * (m12 * m33 - m32 * m13) + m31 * (m12 * m23 - m22 * m13)) -
				m10 * (m01 * (m22 * m33 - m32 * m23) - m21 * (m02 * m33 - m32 * m03) + m31 * (m02 * m23 - m22 * m03)) +
				m20 * (m01 * (m12 * m33 - m32 * m13) - m11 * (m02 * m33 - m32 * m03) + m31 * (m02 * m13 - m12 * m03)) -
				m30 * (m01 * (m12 * m23 - m22 * m13) - m11 * (m02 * m23 - m22 * m03) + m21 * (m02 * m13 - m12 * m03))
				;
		}
	}

	public Matrix4x4 Adjugate
	{
		get
		{
			return Matrix4x4(
				+m11 * (m22 * m33 - m32 * m23) - m21 * (m12 * m33 - m32 * m13) + m31 * (m12 * m23 - m22 * m13),
				-m01 * (m22 * m33 - m32 * m23) + m21 * (m02 * m33 - m32 * m03) - m31 * (m02 * m23 - m22 * m03),
				+m01 * (m12 * m33 - m32 * m13) - m11 * (m02 * m33 - m32 * m03) + m31 * (m02 * m13 - m12 * m03),
				-m01 * (m12 * m23 - m22 * m13) + m11 * (m02 * m23 - m22 * m03) - m21 * (m02 * m13 - m12 * m03),
				-m10 * (m22 * m33 - m32 * m23) + m20 * (m12 * m33 - m32 * m13) - m30 * (m12 * m23 - m22 * m13),
				+m00 * (m22 * m33 - m32 * m23) - m20 * (m02 * m33 - m32 * m03) + m30 * (m02 * m23 - m22 * m03),
				-m00 * (m12 * m33 - m32 * m13) + m10 * (m02 * m33 - m32 * m03) - m30 * (m02 * m13 - m12 * m03),
				+m00 * (m12 * m23 - m22 * m13) - m10 * (m02 * m23 - m22 * m03) + m20 * (m02 * m13 - m12 * m03),
				+m10 * (m21 * m33 - m31 * m23) - m20 * (m11 * m33 - m31 * m13) + m30 * (m11 * m23 - m21 * m13),
				-m00 * (m21 * m33 - m31 * m23) + m20 * (m01 * m33 - m31 * m03) - m30 * (m01 * m23 - m21 * m03),
				+m00 * (m11 * m33 - m31 * m13) - m10 * (m01 * m33 - m31 * m03) + m30 * (m01 * m13 - m11 * m03),
				-m00 * (m11 * m23 - m21 * m13) + m10 * (m01 * m23 - m21 * m03) - m20 * (m01 * m13 - m11 * m03),
				-m10 * (m21 * m32 - m31 * m22) + m20 * (m11 * m32 - m31 * m12) - m30 * (m11 * m22 - m21 * m12),
				+m00 * (m21 * m32 - m31 * m22) - m20 * (m01 * m32 - m31 * m02) + m30 * (m01 * m22 - m21 * m02),
				-m00 * (m11 * m32 - m31 * m12) + m10 * (m01 * m32 - m31 * m02) - m30 * (m01 * m12 - m11 * m02),
				+m00 * (m11 * m22 - m21 * m12) - m10 * (m01 * m22 - m21 * m02) + m20 * (m01 * m12 - m11 * m02)
			);
		}
	}

	public Matrix4x4 Inverse
	{
		[Inline] get
		{
			var adjugate = this.Adjugate;
			var determinant = double(this.Determinant);
			var result = adjugate / determinant;
			return result;
		}
	}
    
    public static Matrix4x4 Frustum(float left, float right, float bottom, float top, float nearVal, float farVal)
    {
        var m = cIdentity;
        m.m00 = (2 * nearVal) / (right - left);
        m.m11 = (2 * nearVal) / (top - bottom);
        m.m20 = (right + left) / (right - left);
        m.m21 = (top + bottom) / (top - bottom);
        m.m22 = -(farVal + nearVal) / (farVal - nearVal);
        m.m23 = -1;
        m.m32 = -(2 * farVal * nearVal) / (farVal - nearVal);
        return m;
    }
    
    public static Matrix4x4 InfinitePerspective(float fovy, float aspect, float zNear)
    {
        var range = Math.Tan((double)fovy / 2.0) * (double)zNear;
        var l = -range * (double)aspect;
        var r = range * (double)aspect;
        var b = -range;
        var t = range;
        var m = cIdentity;
        m.m00 = (float)( ((2.0)*(double)zNear)/(r - l) );
        m.m11 = (float)( ((2.0)*(double)zNear)/(t - b) );
        m.m22 = (float)( - (1.0) );
        m.m23 = (float)( - (1.0) );
        m.m32 = (float)( - (2.0)*(double)zNear );
        return m;
    }
    
    public static Vector3 Project(Vector3 obj, Matrix4x4 model, Matrix4x4 proj, Vector4 viewport)
    {
        var tmp = proj * (model *  Vector4(obj, 1));
        tmp /= tmp.w;
        tmp = tmp * 0.5f + 0.5f;
        tmp.x = tmp.x * viewport.z + viewport.x;
        tmp.y = tmp.y * viewport.w + viewport.y;
        return tmp.xyz;
    }
    
    public static Vector3 UnProject(Vector3 win, Matrix4x4 model, Matrix4x4 proj, Vector4 viewport)
    {
        var tmp =  Vector4(win, 1);
        tmp.x = (tmp.x - viewport.x) / viewport.z;
        tmp.y = (tmp.y - viewport.y) / viewport.w;
        tmp = tmp * 2 - 1;
    
        var unp = proj.Inverse * tmp;
        unp /= unp.w;
        var obj = model.Inverse * unp;
        return (Vector3)obj / obj.w;
    }
    
    public static Vector3 UnProjectFaster(Vector3 win, Matrix4x4 model, Matrix4x4 proj, Vector4 viewport)
    {
        var tmp =  Vector4(win, 1);
        tmp.x = (tmp.x - viewport.x) / viewport.z;
        tmp.y = (tmp.y - viewport.y) / viewport.w;
        tmp = tmp * 2 - 1;
    
        var obj = (proj * model).Inverse * tmp;
        return (Vector3)obj / obj.w;
    }
    
    public static Matrix4x4 Rotate(float angle, Vector3 v)
    {
        var c = (float)Math.Cos((double)angle);
        var s = (float)Math.Sin((double)angle);
    
        var axis = v.Normalized;
        var temp = (1 - c) * axis;
    
        var m = cIdentity;
        m.m00 = c + temp.x * axis.x;
        m.m01 = 0 + temp.x * axis.y + s * axis.z;
        m.m02 = 0 + temp.x * axis.z - s * axis.y;
    
        m.m10 = 0 + temp.y * axis.x - s * axis.z;
        m.m11 = c + temp.y * axis.y;
        m.m12 = 0 + temp.y * axis.z + s * axis.x;
    
        m.m20 = 0 + temp.z * axis.x + s * axis.y;
        m.m21 = 0 + temp.z * axis.y - s * axis.x;
        m.m22 = c + temp.z * axis.z;
        return m;
    }
    
    public static Matrix4x4 RotateX(float angle)
    {
        return Rotate(angle, Vector3.Right);
    }
    
    public static Matrix4x4 RotateY(float angle)
    {
        return Rotate(angle, Vector3.Up);
    }
    
    public static Matrix4x4 RotateZ(float angle)
    {
        return Rotate(angle, Vector3.Forward);
    }
    
    [Inline]
    static public Matrix4x4 Scale (float x, float y, float z)
    {
		return Matrix4x4(
			x, 0, 0, 0,
			0, y, 0, 0,
			0, 0, z, 0,
			0, 0, 0, 1
		);
    }
    
	[Inline]
    static public Matrix4x4 Scale (Vector3 v)
	{
		return Matrix4x4.Scale(v.x, v.y, v.z);
	}
    
    [Inline]
    static public Matrix4x4 Scale (float s)
	{
		return Matrix4x4.Scale(s, s, s);
	}


    [Inline]
    static public Matrix4x4 Translate (float x, float y, float z)
    {
		return Matrix4x4(
			1, 0, 0, 0,
			0, 1, 0, 0,
			0, 0, 1, 0,
			x, y, z, 1
		);
    }


	static public Matrix4x4 CreateTranslation (Vector3 v)
	{
		return Matrix4x4(
			+1F, +0F, +0F, +0F,
			+0F, +1F, +0F, +0F,
			+0F, +0F, +1F, +0F,
			v.x, v.y, v.z, +1F
		);
	}


	[Inline]
	static public Matrix4x4 CreateRotation (Quaternion quaternion)
	{
		return Matrix4x4(quaternion);
	}


	static public Matrix4x4 CreateScale (Vector3 v)
	{
		return Matrix4x4(
			v.x, 0, 0, 0,
			0, v.y, 0, 0,
			0, 0, v.z, 0,
			0, 0, 0, 1
		);
	}


	static public Matrix4x4 CreateLookAt (Vector3 origin, Vector3 destination, Vector3 upwards)
	{
		Vector3 w = (destination - origin).Normalized;
		Vector3 u = Vector3.Cross(w, -upwards).Normalized;
		Vector3 v = Vector3.Cross(w, u);

		float m00 = u.x;
		float m10 = u.y;
		float m20 = u.z;

		float m01 = v.x;
		float m11 = v.y;
		float m21 = v.z;

		float m02 = w.x;
		float m12 = w.y;
		float m22 = w.z;

		float m30 = -Vector3.Dot(u, origin);
		float m31 = -Vector3.Dot(v, origin);
		float m32 = -Vector3.Dot(w, origin);

		return Matrix4x4(
			m00, m01, m02, 0.0F,
			m10, m11, m12, 0.0F,
			m20, m21, m22, 0.0F,
			m30, m31, m32, 1.0F
		);
	}


	static public Matrix4x4 CreateTRS (Vector3 position, Quaternion quaternion, Vector3 scale)
	{
		Matrix4x4 T = [Inline]CreateTranslation(position);
		Matrix4x4 R = [Inline]CreateRotation(quaternion);
		Matrix4x4 S = [Inline]CreateScale(scale);

		return T * R * S;
		//return S * R * T;
	}



	static public Matrix4x4 CreateOrthographic (float width, float height, float near, float far)
	{
		float m00 = 2.0F / width;
		float m11 = 2.0F / height;
		float m22 = 1.0F / (near - far);
		float m33 = near / (near - far);

		return Matrix4x4(
			m00, 0.0F, 0.0F, 0.0F,
			0.0F, m11, 0.0F, 0.0F,
			0.0F, 0.0F, m22, 0.0F,
			-1.0F, -1.0F, m33, 1.0F
		);
	}


	static public Matrix4x4 CreateOrthographic (float left, float right, float top, float bottom, float near , float far)
	{
		float m00 = 2.0F / (right - left);
		float m11 = 2.0F / (bottom - top);
		float m22 = 1.0F / (far - near);
		float m23 = near;
		float m30 = -(right + left) / (right - left);
		float m31 = -(bottom + top) / (bottom - top);
		float m32 = -near / (far - near);

		return Matrix4x4(
			m00, 0, 0, 0,
			0, m11, 0, 0,
			0, 0, m22, m23,
			m30, m31, m32, 0
		);
	}


	static public Matrix4x4 CreatePerspective (float fovy, float aspect, float near, float far)
	{
		float tanHalfFovy = Math.Tan(fovy / 2.0F);
		float m00 = 1.0F / (aspect * tanHalfFovy);
		float m11 = 1.0F / (tanHalfFovy);
		float m22 = far / (far - near);
		float m23 = 1.0F;
		float m32 = -(far * near) / (far - near);

		return Matrix4x4(
			m00, 00F, 00F, 00F,
			00F, m11, 00F, 00F,
			00F, 00F, m22, m23,
			00F, 00F, m32, 00F
		);
	}

	override public void ToString (String buffer)
	{
		buffer.AppendF(scope $"""
			Matrix4x4(
				{m00}, {m01}, {m02}, {m03},
				{m10}, {m11}, {m12}, {m13},
				{m20}, {m21}, {m22}, {m23},
				{m30}, {m31}, {m32}, {m33}	
			);
		""");
	}


    static public bool operator == (Matrix4x4 lhs, Matrix4x4 rhs)
	{
		return (
			lhs.m00 == rhs.m00 && lhs.m01 == rhs.m01 && lhs.m02 == rhs.m02 && lhs.m03 == rhs.m03 &&
			lhs.m10 == rhs.m10 && lhs.m11 == rhs.m11 && lhs.m12 == rhs.m12 && lhs.m13 == rhs.m13 &&
			lhs.m20 == rhs.m20 && lhs.m21 == rhs.m21 && lhs.m22 == rhs.m22 && lhs.m23 == rhs.m23 &&
			lhs.m30 == rhs.m30 && lhs.m31 == rhs.m31 && lhs.m32 == rhs.m32 && lhs.m33 == rhs.m33
		);
	}


    static public bool operator != (Matrix4x4 lhs, Matrix4x4 rhs)
	{
		return (
			lhs.m00 != rhs.m00 || lhs.m01 != rhs.m01 || lhs.m02 != rhs.m02 || lhs.m03 != rhs.m03 ||
			lhs.m10 != rhs.m10 || lhs.m11 != rhs.m11 || lhs.m12 != rhs.m12 || lhs.m13 != rhs.m13 ||
			lhs.m20 != rhs.m20 || lhs.m21 != rhs.m21 || lhs.m22 != rhs.m22 || lhs.m23 != rhs.m23 ||
			lhs.m30 != rhs.m30 || lhs.m31 != rhs.m31 || lhs.m32 != rhs.m32 || lhs.m33 != rhs.m33
		);
	}


	static public Matrix4x4 operator / (Matrix4x4 lhs, float rhs)
	{
		return Matrix4x4(
			lhs.m00 / rhs, lhs.m01 / rhs, lhs.m02 / rhs, lhs.m03 / rhs,
			lhs.m10 / rhs, lhs.m11 / rhs, lhs.m12 / rhs, lhs.m13 / rhs,
			lhs.m20 / rhs, lhs.m21 / rhs, lhs.m22 / rhs, lhs.m23 / rhs,
			lhs.m30 / rhs, lhs.m31 / rhs, lhs.m32 / rhs, lhs.m33 / rhs
		);
	}


	static public Matrix4x4 operator / (Matrix4x4 lhs, double rhs)
	{
		return Matrix4x4(
			(.)((.)lhs.m00 / rhs), (.)((.)lhs.m01 / rhs), (.)((.)lhs.m02 / rhs), (.)((.)lhs.m03 / rhs),
			(.)((.)lhs.m10 / rhs), (.)((.)lhs.m11 / rhs), (.)((.)lhs.m12 / rhs), (.)((.)lhs.m13 / rhs),
			(.)((.)lhs.m20 / rhs), (.)((.)lhs.m21 / rhs), (.)((.)lhs.m22 / rhs), (.)((.)lhs.m23 / rhs),
			(.)((.)lhs.m30 / rhs), (.)((.)lhs.m31 / rhs), (.)((.)lhs.m32 / rhs), (.)((.)lhs.m33 / rhs)
		);
	}


	static public Matrix4x4 operator * (Matrix4x4 lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
		    m00: ((lhs.m00 * rhs.m00 + lhs.m10 * rhs.m01) + (lhs.m20 * rhs.m02 + lhs.m30 * rhs.m03)),
		    m01: ((lhs.m01 * rhs.m00 + lhs.m11 * rhs.m01) + (lhs.m21 * rhs.m02 + lhs.m31 * rhs.m03)),
		    m02: ((lhs.m02 * rhs.m00 + lhs.m12 * rhs.m01) + (lhs.m22 * rhs.m02 + lhs.m32 * rhs.m03)),
		    m03: ((lhs.m03 * rhs.m00 + lhs.m13 * rhs.m01) + (lhs.m23 * rhs.m02 + lhs.m33 * rhs.m03)),

		    m10: ((lhs.m00 * rhs.m10 + lhs.m10 * rhs.m11) + (lhs.m20 * rhs.m12 + lhs.m30 * rhs.m13)),
		    m11: ((lhs.m01 * rhs.m10 + lhs.m11 * rhs.m11) + (lhs.m21 * rhs.m12 + lhs.m31 * rhs.m13)),
		    m12: ((lhs.m02 * rhs.m10 + lhs.m12 * rhs.m11) + (lhs.m22 * rhs.m12 + lhs.m32 * rhs.m13)),
		    m13: ((lhs.m03 * rhs.m10 + lhs.m13 * rhs.m11) + (lhs.m23 * rhs.m12 + lhs.m33 * rhs.m13)),

		    m20: ((lhs.m00 * rhs.m20 + lhs.m10 * rhs.m21) + (lhs.m20 * rhs.m22 + lhs.m30 * rhs.m23)),
		    m21: ((lhs.m01 * rhs.m20 + lhs.m11 * rhs.m21) + (lhs.m21 * rhs.m22 + lhs.m31 * rhs.m23)),
		    m22: ((lhs.m02 * rhs.m20 + lhs.m12 * rhs.m21) + (lhs.m22 * rhs.m22 + lhs.m32 * rhs.m23)),
		    m23: ((lhs.m03 * rhs.m20 + lhs.m13 * rhs.m21) + (lhs.m23 * rhs.m22 + lhs.m33 * rhs.m23)),

		    m30: ((lhs.m00 * rhs.m30 + lhs.m10 * rhs.m31) + (lhs.m20 * rhs.m32 + lhs.m30 * rhs.m33)),
		    m31: ((lhs.m01 * rhs.m30 + lhs.m11 * rhs.m31) + (lhs.m21 * rhs.m32 + lhs.m31 * rhs.m33)),
		    m32: ((lhs.m02 * rhs.m30 + lhs.m12 * rhs.m31) + (lhs.m22 * rhs.m32 + lhs.m32 * rhs.m33)),
		    m33: ((lhs.m03 * rhs.m30 + lhs.m13 * rhs.m31) + (lhs.m23 * rhs.m32 + lhs.m33 * rhs.m33))
		);
	}


	static public Vector2 operator * (Matrix4x4 m, Vector2 v)
	{
	    return Vector2(
			((m.m00 * v.x + m.m10 * v.y) + m.m30),
			((m.m01 * v.x + m.m11 * v.y) + m.m31)
		);
	}


	static public Vector3 operator * (Matrix4x4 m, Vector3 v)
	{
	    return Vector3(
			((m.m00 * v.x + m.m10 * v.y) + (m.m20 * v.z + m.m30)),
			((m.m01 * v.x + m.m11 * v.y) + (m.m21 * v.z + m.m31)),
			((m.m02 * v.x + m.m12 * v.y) + (m.m22 * v.z + m.m32))
		);
	}


	static public Vector4 operator * (Matrix4x4 m, Vector4 v)
	{
	    return Vector4(
			((m.m00 * v.x) + (m.m10 * v.y) + (m.m20 * v.z) + (m.m30 * v.w)),
			((m.m01 * v.x) + (m.m11 * v.y) + (m.m21 * v.z) + (m.m31 * v.w)),
			((m.m02 * v.x) + (m.m12 * v.y) + (m.m22 * v.z) + (m.m32 * v.w)),
			((m.m03 * v.x) + (m.m13 * v.y) + (m.m23 * v.z) + (m.m33 * v.w))
		);

		/*return Vector4(
			((m.m00 * v.x + m.m10 * v.y) + (m.m20 * v.z + m.m30 * v.w)),
			((m.m01 * v.x + m.m11 * v.y) + (m.m21 * v.z + m.m31 * v.w)),
			((m.m02 * v.x + m.m12 * v.y) + (m.m22 * v.z + m.m32 * v.w)),
			((m.m03 * v.x + m.m13 * v.y) + (m.m23 * v.z + m.m33 * v.w))
		);*/
		/*float w = v.w;
		Vector4 vout = default;
		vout.x = v.x * m.mValues[0 + 0] + v.y * m.mValues[4 + 0] + v.z * m.mValues[8 + 0] + w * m.mValues[12 + 0];
		vout.y = v.x * m.mValues[0 + 1] + v.y * m.mValues[4 + 1] + v.z * m.mValues[8 + 1] + w * m.mValues[12 + 1];
		vout.z = v.x * m.mValues[0 + 2] + v.y * m.mValues[4 + 2] + v.z * m.mValues[8 + 2] + w * m.mValues[12 + 2];
		vout.w = w;
		return vout;*/

		/*return Vector4(
			((m.m00 * v.x + m.m10 * v.y) + (m.m20 * v.z + m.m30 * v.w)),
			((m.m01 * v.x + m.m11 * v.y) + (m.m21 * v.z + m.m31 * v.w)),
			((m.m02 * v.x + m.m12 * v.y) + (m.m22 * v.z + m.m32 * v.w)),
			((m.m03 * v.x + m.m13 * v.y) + (m.m23 * v.z + m.m33 * v.w))
		);*/
	}


	static public Matrix4x4 operator / (Matrix4x4 A, Matrix4x4 B)
	{
	    return A * B.Inverse;
	}



	static public Matrix4x4 operator + (Matrix4x4 lhs, Matrix4x4 rhs)
	{
		return Matrix4x4(
		    m00: (lhs.m00 + rhs.m00),
		    m01: (lhs.m01 + rhs.m01),
		    m02: (lhs.m02 + rhs.m02),
		    m03: (lhs.m03 + rhs.m03),

		    m10: (lhs.m10 + rhs.m10),
		    m11: (lhs.m11 + rhs.m11),
		    m12: (lhs.m12 + rhs.m12),
		    m13: (lhs.m13 + rhs.m13),

		    m20: (lhs.m20 + rhs.m20),
		    m21: (lhs.m21 + rhs.m21),
		    m22: (lhs.m22 + rhs.m22),
		    m23: (lhs.m23 + rhs.m23),

		    m30: (lhs.m30 + rhs.m30),
		    m31: (lhs.m31 + rhs.m31),
		    m32: (lhs.m32 + rhs.m32),
		    m33: (lhs.m33 + rhs.m33)
		);
	}


	static public Matrix4x4 operator + (Matrix4x4 lhs, float rhs)
	{
		return Matrix4x4(
		    m00: (lhs.m00 + rhs),
		    m01: (lhs.m01 + rhs),
		    m02: (lhs.m02 + rhs),
		    m03: (lhs.m03 + rhs),

		    m10: (lhs.m10 + rhs),
		    m11: (lhs.m11 + rhs),
		    m12: (lhs.m12 + rhs),
		    m13: (lhs.m13 + rhs),

		    m20: (lhs.m20 + rhs),
		    m21: (lhs.m21 + rhs),
		    m22: (lhs.m22 + rhs),
		    m23: (lhs.m23 + rhs),

		    m30: (lhs.m30 + rhs),
		    m31: (lhs.m31 + rhs),
		    m32: (lhs.m32 + rhs),
		    m33: (lhs.m33 + rhs)
		);
	}


	static public Matrix4x4 operator + (float lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
	        m00: (lhs + rhs.m00),
	        m01: (lhs + rhs.m01),
	        m02: (lhs + rhs.m02),
	        m03: (lhs + rhs.m03),

	        m10: (lhs + rhs.m10),
	        m11: (lhs + rhs.m11),
	        m12: (lhs + rhs.m12),
	        m13: (lhs + rhs.m13),

	        m20: (lhs + rhs.m20),
	        m21: (lhs + rhs.m21),
	        m22: (lhs + rhs.m22),
	        m23: (lhs + rhs.m23),

	        m30: (lhs + rhs.m30),
	        m31: (lhs + rhs.m31),
	        m32: (lhs + rhs.m32),
	        m33: (lhs + rhs.m33)
	    );
	}


	static public Matrix4x4 operator - (Matrix4x4 lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
	        m00: (lhs.m00 - rhs.m00),
	        m01: (lhs.m01 - rhs.m01),
	        m02: (lhs.m02 - rhs.m02),
	        m03: (lhs.m03 - rhs.m03),

	        m10: (lhs.m10 - rhs.m10),
	        m11: (lhs.m11 - rhs.m11),
	        m12: (lhs.m12 - rhs.m12),
	        m13: (lhs.m13 - rhs.m13),

	        m20: (lhs.m20 - rhs.m20),
	        m21: (lhs.m21 - rhs.m21),
	        m22: (lhs.m22 - rhs.m22),
	        m23: (lhs.m23 - rhs.m23),

	        m30: (lhs.m30 - rhs.m30),
	        m31: (lhs.m31 - rhs.m31),
	        m32: (lhs.m32 - rhs.m32),
	        m33: (lhs.m33 - rhs.m33)
	    );
	}


	static public Matrix4x4 operator - (Matrix4x4 lhs, float rhs)
	{
	    return Matrix4x4(
	        m00: (lhs.m00 - rhs),
	        m01: (lhs.m01 - rhs),
	        m02: (lhs.m02 - rhs),
	        m03: (lhs.m03 - rhs),

	        m10: (lhs.m10 - rhs),
	        m11: (lhs.m11 - rhs),
	        m12: (lhs.m12 - rhs),
	        m13: (lhs.m13 - rhs),

	        m20: (lhs.m20 - rhs),
	        m21: (lhs.m21 - rhs),
	        m22: (lhs.m22 - rhs),
	        m23: (lhs.m23 - rhs),

	        m30: (lhs.m30 - rhs),
	        m31: (lhs.m31 - rhs),
	        m32: (lhs.m32 - rhs),
	        m33: (lhs.m33 - rhs)
	    );
	}


	static public Matrix4x4 operator - (float lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
	        m00: (lhs - rhs.m00),
	        m01: (lhs - rhs.m01),
	        m02: (lhs - rhs.m02),
	        m03: (lhs - rhs.m03),

	        m10: (lhs - rhs.m10),
	        m11: (lhs - rhs.m11),
	        m12: (lhs - rhs.m12),
	        m13: (lhs - rhs.m13),

	        m20: (lhs - rhs.m20),
	        m21: (lhs - rhs.m21),
	        m22: (lhs - rhs.m22),
	        m23: (lhs - rhs.m23),

	        m30: (lhs - rhs.m30),
	        m31: (lhs - rhs.m31),
	        m32: (lhs - rhs.m32),
	        m33: (lhs - rhs.m33)
	    );
	}


	static public Matrix4x4 operator / (float lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
	        m00: (lhs / rhs.m00),
	        m01: (lhs / rhs.m01),
	        m02: (lhs / rhs.m02),
	        m03: (lhs / rhs.m03),

	        m10: (lhs / rhs.m10),
	        m11: (lhs / rhs.m11),
	        m12: (lhs / rhs.m12),
	        m13: (lhs / rhs.m13),

	        m20: (lhs / rhs.m20),
	        m21: (lhs / rhs.m21),
	        m22: (lhs / rhs.m22),
	        m23: (lhs / rhs.m23),

	        m30: (lhs / rhs.m30),
	        m31: (lhs / rhs.m31),
	        m32: (lhs / rhs.m32),
	        m33: (lhs / rhs.m33)
	    );
	}


	static public Matrix4x4 operator * (Matrix4x4 lhs, float rhs)
	{
	    return Matrix4x4(
	        m00: (lhs.m00 * rhs),
	        m01: (lhs.m01 * rhs),
	        m02: (lhs.m02 * rhs),
	        m03: (lhs.m03 * rhs),

	        m10: (lhs.m10 * rhs),
	        m11: (lhs.m11 * rhs),
	        m12: (lhs.m12 * rhs),
	        m13: (lhs.m13 * rhs),

	        m20: (lhs.m20 * rhs),
	        m21: (lhs.m21 * rhs),
	        m22: (lhs.m22 * rhs),
	        m23: (lhs.m23 * rhs),

	        m30: (lhs.m30 * rhs),
	        m31: (lhs.m31 * rhs),
	        m32: (lhs.m32 * rhs),
	        m33: (lhs.m33 * rhs)
	    );
	}


	static public Matrix4x4 operator * (float lhs, Matrix4x4 rhs)
	{
	    return Matrix4x4(
	        m00: (lhs * rhs.m00),
	        m01: (lhs * rhs.m01),
	        m02: (lhs * rhs.m02),
	        m03: (lhs * rhs.m03),

	        m10: (lhs * rhs.m10),
	        m11: (lhs * rhs.m11),
	        m12: (lhs * rhs.m12),
	        m13: (lhs * rhs.m13),

	        m20: (lhs * rhs.m20),
	        m21: (lhs * rhs.m21),
	        m22: (lhs * rhs.m22),
	        m23: (lhs * rhs.m23),

	        m30: (lhs * rhs.m30),
	        m31: (lhs * rhs.m31),
	        m32: (lhs * rhs.m32),
	        m33: (lhs * rhs.m33)
	    );
	}



}