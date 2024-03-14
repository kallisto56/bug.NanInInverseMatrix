namespace bug.NanInInverseMatrix;


using System;


[CRepr]
struct TestMatrix4x4
{
	public float[16] mValues;

	public this (params float[] values)
	{
		this.mValues = float[16]();
		for (int n = 0; n < this.mValues.Count; n++)
			this.mValues[n] = values[n];
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

	public TestMatrix4x4 Adjugate
	{
		get
		{
			return TestMatrix4x4(
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

	public TestMatrix4x4 Inverse
	{
		[Inline] get { return this.Adjugate / this.Determinant; }
	}

	static public TestMatrix4x4 operator / (TestMatrix4x4 lhs, float rhs)
	{
		return TestMatrix4x4(
			lhs.m00 / rhs, lhs.m01 / rhs, lhs.m02 / rhs, lhs.m03 / rhs,
			lhs.m10 / rhs, lhs.m11 / rhs, lhs.m12 / rhs, lhs.m13 / rhs,
			lhs.m20 / rhs, lhs.m21 / rhs, lhs.m22 / rhs, lhs.m23 / rhs,
			lhs.m30 / rhs, lhs.m31 / rhs, lhs.m32 / rhs, lhs.m33 / rhs
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

	override public void ToString (String buffer)
	{
		buffer.AppendF(scope $"""
			TestMatrix4x4(
				{m00}, {m01}, {m02}, {m03},
				{m10}, {m11}, {m12}, {m13},
				{m20}, {m21}, {m22}, {m23},
				{m30}, {m31}, {m32}, {m33}	
			);
		""");
	}
}