cdef class Quaternion:
	cdef public double w, x, y, z
	cpdef Quaternion copy( self )
	