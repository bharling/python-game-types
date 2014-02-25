from pgt import *
import math
import unittest

class TestVector3Functions(unittest.TestCase):
    
    def test_length(self):
        v = Vector3.unit_x().mulScalar(100.0)
        self.assertEqual(v.length, 100, "length should be 100")
        
    def test_rotate_by_quaternion(self):
        v = Vector3.unit_z()
        q = Quaternion.fromAxisAngle(Vector3.unit_y(), 90*math.pi/180.0)
        v = v.mulQuaternion(q)
        self.assertEqual(v.x, 1.0, "rotated vector should have x==1.0")
        
    def test_reflect(self):
        v = Vector3.unit_x()
        wall = Vector3.neg_unit_x()
        v = v.reflect(wall)
        self.assertEqual(v.x, -1.0, "reflected vector should have x==-1.0")
        
    def test_distance_to(self):
        v1 = Vector3(100.0, 0.0, 0.0)
        v2 = Vector3(-100.0, 0.0, 0.0)
        self.assertEqual(v1.distanceTo(v2), 200.0, 'distance should be 200')
        
    def test_angle_to(self):
        v1 = Vector3.unit_z()
        v2 = Vector3.unit_x()
        self.assertEqual(v1.angleTo(v2), 90*math.pi/180.0, 'angle should be 90 degrees in radians')
        
    def test_normalize(self):
        v = Vector3.random().mulScalar(100.0)
        v.normalize()
        self.assertAlmostEqual(v.length, 1.0, 3, "normalized length should be 1.0")
        
    def test_lerp(self):
        v1 = Vector3(0.0, 0.0, 0.0)
        v2 = Vector3(100.0, 0.0, 0.0)
        lerped = v1.lerp(v2, 0.5)
        self.assertEqual(lerped.x, 50.0, 'interpolated vector should have x==50')
        
if __name__=='__main__':
    unittest.main()


