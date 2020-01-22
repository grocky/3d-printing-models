// Which one would you like to see?
part = "both"; // [top,base,both]

/* [Basic] */

plaqueTextTop="Penguin";
plaqueTextTopSize=5;
plaqueTextBottom="Focus Innovation 2020";
plaqueTextBottomSize=3;
placeText="1";
placeSuperscript="st";
placeTextSize=27;
placeSuperscriptSize=8;
trophyFileName="Penguin_t.stl";

/* [Advanced] */

baseRadius=42;
baseHeight=8;
platformHeight=6;
platformRadius=28;
platformAngle=30;
platformDonutRadius=2;
plaqueAngle=20;
plaqueThickness=4;
plaqueWidth=42;
plaqueHeight=20;
connectorHeight=20;
ringOuterRadius=35;
ringInnerRadius=25;
ringWidth=11;

$fn = 150;

render();
module render() {
  if (part != "base") {
    topPiece($fn=70);
  }
  if (part != "top") {
    bottomPiece($fn=70);
  }
}

module bottomPiece() {
  base();
  platform();
  plaque();
}

module topPiece() {
  aboveConnector() trophyTop();
  connector();
}

function skew(point, scheme) = [
  // matrix/column vector multiplication
  point * scheme[0], point * scheme[1], point * scheme[2]
];

function _projectnofactor(point, focallen) = [
  point[0] * focallen / point[2],
  point[1] * focallen / point[2],
  0
];

function _scale(val, scaledval, factor) = 
  (val - scaledval) * factor + scaledval;

function _projectscale(point, scaledpoint, factor) = [
  _scale(point[0], scaledpoint[0], factor),
  _scale(point[1], scaledpoint[1], factor),
  _scale(point[2], scaledpoint[2], factor)
];

function project(point, focallen, factor) = 
  _projectscale(point, _projectnofactor(point, focallen), factor);

module trophyTop() {
    scale(1)
    rotate([0, 0, 90]) import(str("vendor/", trophyFileName), center = true);
}

module connector() {
  abovePlatform() xycenteredcube([
      ringWidth,
      ringWidth,
      connectorHeight
  ]);
}

module centerring() {
  translate([0, 0, baseHeight + platformHeight + connectorHeight + ringOuterRadius]) children();
}

module plaque() {
  difference() {
    abovePlatform() hull() {
      translate([platformRadius * .6, 0, -1])
          rotate([0, -plaqueAngle, 0])
          xycenteredcube([plaqueThickness, plaqueWidth, plaqueHeight]);
      translate([-platformRadius * .5, 0, 0])
          xycenteredcube([plaqueThickness, plaqueWidth, 0.1]);
      }
    connector();
    abovePlatform() translate([platformRadius * .6, 0, 0])
        rotate([90, -plaqueAngle, 0])
        rotate([0, 90, 0])
        translate([0, 0, .7])
        linear_extrude(1)
        union() {
          translate([0, (plaqueHeight - plaqueTextTopSize)*2/3])
            text(plaqueTextTop, font="Optimist:style=Bold", size=plaqueTextTopSize, halign="center");
          translate([0, plaqueTextBottomSize])
            text(plaqueTextBottom, font="Optimist:style:Regular", size=plaqueTextBottomSize, halign="center");
        }
  }
}

module aboveConnector() {
  translate([0, 0, baseHeight + platformHeight + connectorHeight]) children();
}

module platform() {
  r2 = platformRadius + platformDonutRadius * 3;
  r1 = r2 + tan(platformAngle) * platformHeight;
  difference() {
    aboveBase()
        cylinder(r1=r1, r2=r2, h=platformHeight);
    abovePlatform()
        rotate_extrude()
        translate([platformRadius + platformDonutRadius, 0])
        circle(r=platformDonutRadius);
  }
}

module abovePlatform() {
  translate([0,0,baseHeight + platformHeight]) children();
}

module base() {
  cylinder(r=baseRadius,h=baseHeight);
}

module aboveBase() {
  translate([0,0,baseHeight]) children();
}

module xycenteredcube(dims) {
  translate([-dims[0]/2, -dims[1]/2, 0]) cube(dims);
}

module logo(h, r1, r2) {
  difference() {
    sideCylinder(h, r=r1);
    translate([0,0, r1-r2]) sideCylinder(h*2, r=r2);
  }
}

module sideCylinder(h, r) {
  translate([-h/2, 0, r]) rotate([0, 90, 0]) cylinder(h, r=r);
}
