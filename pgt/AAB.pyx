from Vector3 cimport Vector3
from libc.math cimport abs, sqrt, fabs

cdef class AAB:
    
    def __cinit__(self, Vector3 center, Vector3 extents):
        self.center = center
        self.extents = extents
        self.updateBounds()
        
    cdef updateBounds(self):
        cdef double xmin, xmax, ymin, ymax, zmin, zmax
        cdef double halfX, halfY, halfZ
        halfX = self.extents.x / 2.0
        halfY = self.extents.y / 2.0
        halfZ = self.extents.z / 2.0
        
        xmin = self.center.x - halfX
        xmax = self.center.x + halfX
        
        ymin = self.center.y - halfY
        ymax = self.center.y + halfY
        
        zmin = self.center.z - halfZ
        zmax = self.center.z + halfZ
        
        self.minCorner = Vector3(xmin, ymin, zmin)
        self.maxCorner = Vector3(xmax, ymax, xmax)
        
    property height:
        def __get__(self):
            return abs(self.maxCorner.z - self.minCorner.z)
        def __set__(self, double value):
            self.extents.z = value
            self.updateBounds()
            
    property width:
        def __get__(self):
            return abs(self.maxCorner.x - self.minCorner.x)
        def __set__(self, double value):
            self.extents.x = value
            self.updateBounds()
            
    property depth:
        def __get__(self):
            return abs(self.maxCorner.y - self.minCorner.y)
        def __set__(self, double value):
            self.extents.y = value
            self.updateBounds()
            
    cdef updateCenter(self):
        self.center = self.minCorner.lerp(self.maxCorner, 0.5)
            
    cpdef extend (self, Vector3 point):
        cdef double x, y, z, minX, minY, minZ, maxX, maxY, maxZ
        x, y, z = point
        minX, minY, minZ = self.minCorner
        maxX, maxY, maxZ = self.maxCorner
        self.minCorner.x = min(minX, x)
        self.maxCorner.x = max(maxX, x)
        self.minCorner.y = min(minY, y)
        self.maxCorner.y = max(maxY, y)
        self.minCorner.z = min(minZ, z)
        self.maxCorner.z = max(maxZ, z)
        self.updateCenter()
        
    cpdef int contains( self, Vector3 point ):
        if point.x >= self.minCorner.x and \
            point.y >= self.minCorner.y and \
            point.z >= self.minCorner.z and \
            point.x <= self.maxCorner.x and \
            point.y <= self.maxCorner.y and \
            point.z <= self.maxCorner.z: return 1
        return 0
    
    cpdef setCenter( self, Vector3 newCenter ):
        self.center = newCenter
        self.updateBounds()
    
    cpdef int overlaps( self, AAB other ):
        cdef Vector3 offset
        cdef double tX, tY, tZ
        tX = (self.extents.x + other.extents.x) / 2.0
        tY = (self.extents.y + other.extents.y) / 2.0
        tZ = (self.extents.z + other.extents.z) / 2.0
        offset = other.center - self.center
        if fabs(offset.x) <= tX and fabs(offset.y) <= tY and fabs(offset.z) <= tZ:
            return 1
        return 0
    
    cpdef AAB intersect( self, AAB other ):
        pass
        