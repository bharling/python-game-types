from pgt import *
import math
import unittest

class TestVector3(unittest.TestCase):
    
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
        
class TestAAB(unittest.TestCase):
    def test_contains_point(self):
        point = Vector3(100.0,100.0,100.0)
        box = AAB( Vector3.zero(), Vector3(300.0, 300.0, 300.0))
        self.assertTrue(box.contains(point), "Box should contain point")
        
    def test_update_center(self):
        box = AAB( Vector3.zero(), Vector3(100.0, 100.0, 100.0) )
        newcenter = Vector3(50.0, 0.0, 0.0)
        box.setCenter(newcenter)
    
    def test_extend_alters_dimensions(self):
        box = AAB( Vector3.zero(), Vector3(100.0, 100.0, 100.0 ) )
        point = Vector3(-200.0, 0.0, 0.0)
        box.extend(point)
        self.assertEqual(box.width, 250.0, "width not updated by extend")
        
    def test_extend_changes_center(self):
        box = AAB( Vector3.zero(), Vector3(100.0, 100.0, 100.0 ) )
        point = Vector3(0.0, 250.0, 0.0)
        box.extend(point)
        self.assertEqual(box.center.y, 100.0, "center not updated by extend")
             
if __name__=='__main__':
    unittest.main()


