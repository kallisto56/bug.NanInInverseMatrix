namespace System;


using System.Math;


extension Math
{
	//static readonly public float Deg2Rad = 0.01745329251994329576922222222222F;
	//static readonly public float Rad2Deg = 57.295779513082320876846364344191F;
	static readonly public float epsilonNormalSqrt = 1e-15F;


	[Inline]
	static public float ToRadians (float degrees)
	{
		return degrees * 0.01745329251994329576922222222222F;
	}

	[Inline]
	static public float ToDegrees (float radians)
	{
		return radians * 57.295779513082320876846364344191F;
	}

	[Inline]
	static public float Map (int value, int fromMin, float fromMax, float toMin, float toMax)
	{
		return (value - fromMin) * (toMax - toMin) / (fromMax - fromMin) + toMin;
	}


	/// <summary>
	/// Calculates intersection between two infinite lines.
	/// </summary>
	/// <param name="p0">First point</param>
	/// <param name="v0">Direction of first line</param>
	/// <param name="p1">Second point</param>
	/// <param name="v1">Direction of second line</param>
	/// <param name="intersection">Intersection between two infinite lines</param>
	/// <returns><see cref="bool" /> Returns true if intersection occurred</returns>
	public static bool LineLineIntersection (Vector3 p0, Vector3 v0, Vector3 p1, Vector3 v1, out Vector3 intersection)
	{
		// Source: https://stackoverflow.com/questions/59449628/check-when-two-vector3-lines-intersect-unity3d
		Vector3 direction = p1 - p0;
		Vector3 cross0 = Vector3.Cross(v0, v1);
		Vector3 cross1 = Vector3.Cross(direction, v1);

		float planarFactor = Vector3.Dot(direction, cross0);

		// is coplanar, and not parallel
		if (Math.Abs(planarFactor) < float.Epsilon && cross0.SqrtMagnitude > float.Epsilon)
		{
			float length = Vector3.Dot(cross1, cross0) / cross0.SqrtMagnitude;
			intersection = p0 + (v0 * length);
			return true;
		}
		else
		{
			intersection = Vector3.Zero;
			return false;
		}
	}


	static public bool LineLineIntersection (Vector2 a1, Vector2 a2, Vector2 b1, Vector2 b2, out Vector2 hitPoint)
    {
        hitPoint = default;

        // determinant
        float d = (a1.x-a2.x)*(b1.y-b2.y) - (a1.y-b2.y)*(b1.x-b2.x);

        // check if lines are parallel
        if (d <= float.Epsilon) return false;

        float px = (a1.x * a2.y - a1.y * a2.x) * (b1.x-b2.x) - (a1.x - a2.x) * (b1.x * b2.y - b1.y * b2.x);
        float py = (a1.x * a2.y - a1.y * a2.x) * (b1.y-b2.y) - (a1.y - a2.y) * (b1.x * b2.y - b1.y * b2.x);

        hitPoint = Vector2(px,py) / d;
        return true;
    }
}