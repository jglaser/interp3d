from distutils.core import setup
from Cython.Build import cythonize

from distutils.extension import Extension

import numpy as np

setup(name='interp3d',
      ext_modules=cythonize('interp3d/interp.pyx'),
      packages=['interp3d'],
      include_dirs=[np.get_include()])
