from pgt import *
import math


q = Quaternion()
t = q.copy()
print t

v = Vector3.random().mulScalar(100.0)
print v

q2 = Quaternion.fromAxisAngle(Vector3(1.0, 0.0, 0.0), math.pi / 2.0)
rotated = v.mulQuaternion(q2)
print v, q2, rotated


