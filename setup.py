from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

setup(
    cmdclass= {'build_ext':build_ext},
    ext_modules = [Extension("pgt", ["Vector2.pyx","Vector3.pyx","Matrix3.pyx","AAB.pyx"])]
)