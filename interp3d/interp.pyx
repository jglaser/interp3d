cimport numpy as np
import numpy as np
from libc.math cimport floor
from cython cimport boundscheck, wraparound, nonecheck, cdivision

@cdivision(True)
cpdef np.float_t _interp3D(np.float_t[:,:,::1] v, np.float_t x, np.float_t y, np.float_t z, int X, int Y, int Z):

    cdef:
        int i, x0, x1, y0, y1, z0, z1, dim
        np.float_t xd, yd, zd, c00, c01, c10, c11, c0, c1, c
        np.float_t *v_c

    v_c = &v[0,0,0]

    x0 = <int>floor(x)
    x1 = x0 + 1
    y0 = <int>floor(y)
    y1 = y0 + 1
    z0 = <int>floor(z)
    z1 = z0 + 1

    xd = (x-x0)/(x1-x0)
    yd = (y-y0)/(y1-y0)
    zd = (z-z0)/(z1-z0)

    if x0 >= 0 and y0 >= 0 and z0 >= 0 and x1 < X and y1 < Y and z1 < Z:
        c00 = v_c[Y*Z*x0+Z*y0+z0]*(1-xd) + v_c[Y*Z*x1+Z*y0+z0]*xd
        c01 = v_c[Y*Z*x0+Z*y0+z1]*(1-xd) + v_c[Y*Z*x1+Z*y0+z1]*xd
        c10 = v_c[Y*Z*x0+Z*y1+z0]*(1-xd) + v_c[Y*Z*x1+Z*y1+z0]*xd
        c11 = v_c[Y*Z*x0+Z*y1+z1]*(1-xd) + v_c[Y*Z*x1+Z*y1+z1]*xd

        c0 = c00*(1-yd) + c10*yd
        c1 = c01*(1-yd) + c11*yd

        c = c0*(1-zd) + c1*zd

    else:
        c = 0
    return c
