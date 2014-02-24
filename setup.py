from distutils.core import setup
from Cython.Distutils import build_ext
from distutils.extension import Extension
import sys, os
from Cython.Build import cythonize

def scandir(path, files=[]):
    for f in os.listdir(path):
        p = os.path.join(path, f)
        if os.path.isfile(p) and p.endswith(".pyx"):
            files.append(p.replace(os.path.sep, ".")[:-4])
        elif os.path.isdir(p):
            scandir(p, files)
    return files

def makeExtension(extName):
    extPath = extName.replace(".", os.path.sep)+".pyx"
    return Extension(
        extName,
        [extPath],
        include_dirs = ["."],
        extra_compile_args = ["-O3"],
    )

setup(
      ext_modules = cythonize("pgt/*.pyx")
)

#setup(
#      name="pgt",
#      packages=["pgt",],
#      ext_modules=extensions,
#      cmdclass= {'build_ext':build_ext},
#)