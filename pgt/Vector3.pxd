
from Quaternion cimport Quaternion

cdef class Vector3:
    cdef public double x, y, z
    cpdef Vector3 mulQuaternion(self, Quaternion Q)
    cpdef Vector3 mulScalar(self, double other)
    cpdef Vector3 divScalar( self, double other )
    cpdef normalize( self )
    cdef inline double length(self)
    cpdef double squaredLength(self)
    cpdef double dot(self, Vector3 other)
    cpdef Vector3 lerp(self, Vector3 final, double percent)