import random

from libc.math cimport sqrt

from Quaternion cimport Quaternion

cdef class Vector3:
    
    @classmethod
    def random(cls):
        return cls(random.uniform(-1.0, 1.0), random.uniform(-1.0, 1.0), random.uniform(-1.0, 1.0))
    
    def cinit(self, double x, double y, double z):
        self.x = x
        self.y = y
        self.z = z
    
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
        
    def __repr__(self):
        return 'Vector3(%.2f, %.2f, %.2f)' % \
            (self.x, self.y, self.z)
            
    def __add__(self, Vector3 other):
        return Vector3( self.x + other.x, self.y + other.y, self.z + other.z )
    
    def __iadd__(self, Vector3 other):
        self.x += other.x
        self.y += other.y
        self.z += other.z
        return self
    
    def __sub__(self, Vector3 other):
        return Vector3( self.x - other.x, self.y - other.y, self.z - other.z )
    
    def __isub__(self, Vector3 other):
        self.x -= other.x
        self.y -= other.y
        self.z -= other.z
        return self
        
    def __mul__(self, Vector3 other):
        if isinstance(other, Quaternion):
            return self.mulQuaternion(other)
        return Vector3(self.x * other.x, self.y * other.y, self.z * other.z)
    
    cpdef Vector3 mulQuaternion(self, Quaternion Q):
        return Vector3.zero()
    
    def __imul__(self, Vector3 other):
        self.x *= other.x
        self.y *= other.y
        self.z *= other.z
        return self
    
    cpdef Vector3 mulScalar(self, double other):
        return Vector3( self.x * other, self.y * other, self.z * other)
    
    def __div__(self, Vector3 other):
        return Vector3( self.x / other.x, self.y / other.y, self.z / other.z)
    
    def __idiv__(self, Vector3 other):
        self.x /= other.x
        self.y /= other.y
        self.z /= other.z
        return self
    
    cpdef Vector3 divScalar( self, double other ):
        return Vector3( self.x / other, self.y / other, self.z / other )
    
    cpdef normalize( self ):
        self /= self.length()
        return self
    
    cdef inline double length(self):
        return sqrt(self.x**2 + self.y**2 + self.z**2)
    
    property length:
        def __get__(self):
            return self.length()
        def __set__(self, double value):
            self.normalize().mulScalar(value)
            
            
    cpdef double squaredLength(self):
        return self.x**2+self.y**2+self.z**2
    
    cpdef double dot(self, Vector3 other):
        return self.x*other.x+self.y*other.y+self.z*other.z
    
    cpdef Vector3 lerp(self, Vector3 final, double percent):
        return self + ((final-self).mulScalar(percent))