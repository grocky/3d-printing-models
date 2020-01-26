$fn = 250;

module xycenteredcube(dims) {
  translate([-dims[0]/2, -dims[1]/2, 0]) cube(dims);
}

xycenteredcube([10, 10, 5]);