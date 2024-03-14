namespace bug.NanInInverseMatrix;


using System;
using System.Diagnostics;
using System.Math;


class Program
{
	static void Main ()
	{
		Vector3 position = Vector3(-5, 5, -5);
		Vector3 target = .Zero;
		Vector3 upwards = .Up;
		Matrix4x4 m = .CreateTRS(position, Quaternion(Matrix4x4.CreateLookAt(position, target, upwards)), Vector3(1, 1, 1));

		Debug.WriteLine("Translation/Rotation/Scale:\n{}", m);
		Debug.WriteLine("Translation/Rotation/Scale inversed:\n{}", m.Inverse);

		Debug.WriteLine("---");
		TestMatrix4x4 tm = TestMatrix4x4(
			0.707107F, -0, -0.707107F, 0F,
			0.408248F, 0.816496F, 0.408248F, 0F,
			0.57735F, -0.57735F, 0.57735F, 0F,
			0F, 0F, 1F, 0F
		);
		Debug.WriteLine("TM TRS: {}", tm);
		Debug.WriteLine("TM INVERSE: {}", tm.Inverse);
	}
}