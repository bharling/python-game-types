from libc.math cimport sqrt

cdef class Quaternion:
    
    def __cinit__(self, double w=1.0, double x=0.0, double y=0.0, double z=0.0):
        self.w = w
        self.x = x
        self.y = y
        self.z = z
        
    cpdef Quaternion copy(self):
        cdef Quaternion Q
        Q = Quaternion()
        Q.w = self.w
        Q.x = self.x
        Q.y = self.y
        Q.z = self.z
        return Q
    
    
    
    def __repr__(self):
        return 'Quaternion(real=%.2f, imag=<%.2f, %.2f, %.2f>)' % \
            (self.w, self.x, self.y, self.z)