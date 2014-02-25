from Vector3 cimport Vector3

cdef class AAB:
	cdef public Vector3 center, extents
	cdef Vector3 minCorner, maxCorner
	cpdef extend (self, Vector3 point)
	cpdef int contains( self, Vector3 point )
	cpdef setCenter( self, Vector3 newCenter )
	cpdef AAB intersect( self, AAB other )
	cpdef int overlaps(self, AAB other )
	cdef updateBounds(self)
	cdef updateCenter(self)
        