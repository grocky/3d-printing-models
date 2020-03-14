$fn=100;

roundedCornerRadius = 3;

overhangGap = 3;
overhangLength = 7;

baseWidth = 130;
baseLength = 55;
baseDepth = 2;

labelWidth = 151;
labelLength = 98;
labelDepth = 2.25 - roundedCornerRadius;

labelMargin = 5 - roundedCornerRadius;

plateWidth = labelWidth + labelMargin;
plateLength = labelLength + labelMargin;
plateDepth = 5 - roundedCornerRadius;

jointDepth = 2;
jointClearance = 0.3;

part = "plate"; // [over-hang:Over Hang, plate:Plate, both:All]

print_part();

module print_part() {
    if (part == "over-hang") {
        overHang();
    } else if (part == "plate") {
        plate();
    } else {
        both();
    }
}

module both() {
    translate([0, (plateLength - baseLength) / 2, -(baseDepth + plateDepth) / 2 - overhangGap])
        overHang();
    plate();
}

module overHang() {
    union() {
        cube([baseWidth, baseLength, baseDepth], center=true);

        wedgeZStart = (overhangGap + baseDepth) / 2;
        translate([0, (baseLength - overhangLength) / 2, wedgeZStart])
            cube([baseWidth, overhangLength, overhangGap], center=true);

        joinZStart = (baseDepth + jointDepth) / 2 + overhangGap;
        translate([0, (baseLength - overhangLength) / 2, joinZStart])
            joint();
    }
}

module joint() {
    cube([baseWidth / 2, 1, jointDepth], center=true);
}

module jointHole() {
    cube([baseWidth / 2 + jointClearance, 1 + jointClearance, jointDepth + 0.3], center=true);
}

module plate() {
    difference() {
        minkowski() {
            cube([plateWidth, plateLength, plateDepth], center=true);
            sphere(roundedCornerRadius);
        }
        translate([ 0, (plateLength - overhangLength) / 2, -(plateDepth - jointDepth)/2 - roundedCornerRadius])
            jointHole();
        translate([0, 0, (plateDepth + 10) /2 - labelDepth ])
            cube([labelWidth, labelLength, 10], center=true);
    }
}