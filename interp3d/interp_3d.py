from .interp import _interp3D

class Interp3D(object):
    def __init__(self, v, x, y, z):
        self.v = v
        self.min_x, self.max_x = x[0], x[-1]
        self.min_y, self.max_y = y[0], y[-1]
        self.min_z, self.max_z = z[0], z[-1]
        self.delta_x = self.max_x - self.min_x
        self.delta_y = self.max_y - self.min_y
        self.delta_z = self.max_z - self.min_z

    def __call__(self, t):
        X,Y,Z = self.v.shape[0], self.v.shape[1], self.v.shape[2]

        x = (X-1)*(t[0]-self.min_x)/self.delta_x
        y = (Y-1)*(t[1]-self.min_y)/self.delta_y
        z = (Z-1)*(t[2]-self.min_z)/self.delta_z


        return _interp3D(self.v, x, y, z, X, Y, Z)
