$fn = 250;
baseHeight = 32;
baseWidth = 96;
lineHeight = 7;
textThickness = 3;
verticalTextOffset = 4.5;
shouldAnimate = true;
useAlternativeBase = false;

COLOR_VBRED = [237 / 255, 28 / 255, 36 / 255];
COLOR_GOLD = [255 / 255, 215 / 255, 0 / 255];
COLOR_WHITE = [255 / 255, 255 / 255, 255 / 255];
COLOR_BASE = COLOR_WHITE;

module base() {
    translate([0, 0, -baseHeight + (baseHeight * 0.2 / 2)])
    cube([baseWidth, baseWidth, baseHeight * 0.2], center = true);
    
    rotate([0, 0, 45])
    translate([0, 0, -baseHeight * 0.8 / 2])
    cylinder(h = baseHeight * 0.8, r = baseWidth * 0.6, r2 = baseWidth * 0.4, $fn = 4, center = true);
}

module baseAlt() {
    translate([0, 0, -(baseHeight * 0.333) * 2.5])
    cube([baseWidth, baseWidth, baseHeight * 0.333], center = true);

    translate([0, 0, -(baseHeight * 0.333) * 1.5])
    cube([baseWidth * 0.8, baseWidth * 0.8, baseHeight * 0.333], center = true);

    translate([0, 0, -(baseHeight * 0.333) * 0.5])
    cube([baseWidth * 0.6, baseWidth * 0.6, baseHeight * 0.333], center = true);
}

module description(name) {
    color(COLOR_WHITE)
    translate([0, -8, useAlternativeBase ? -4 : 0])
    cube([baseWidth * 0.7, baseHeight * 0.8, useAlternativeBase ? textThickness * 3 : textThickness], center = true);

    color(COLOR_VBRED)
    translate([0, -verticalTextOffset, 0])
    linear_extrude(height = textThickness) {
        text("VideoBlocks", font = "Pacifico", size = 4, halign = "center");
    }

    color(COLOR_VBRED)
    translate([0, -verticalTextOffset + -lineHeight * 0.7, 0])
    linear_extrude(height = textThickness) {
        text("Innovation Day 2016", font = "Pacifico", size = 4, halign = "center");
    }

    color(COLOR_VBRED)
    translate([0, -verticalTextOffset + -lineHeight * 2, 0])
    linear_extrude(height = textThickness) {
        text(str(name, name == "Popular Vote" ? "" : " Award"), font = "Open Sans:style=Bold", size = name == "Technology" ? 5 : 6, halign = "center");
    }

}

module cultureTop() {
    translate([0, 0, 1])
    scale([1, 1, 1])
    rotate([0, 0, 90])
    import("vendor/MicroMarblerun_2a5.stl", center = true);
}

module popularVoteTop() {
    translate([10, 5, 0])
    scale([0.7, 0.7, 0.7])
    rotate([0, 0, 0])
    import("vendor/thumbup.stl", center = true);
}

module impactTop() {
    translate([15, 0, 70])
    scale([1.75, 1.75, 1.75])
    rotate([90, -80, 0])
    import("vendor/polysoup.stl", center = true);
}

module technologyTop() {
    translate([0, 0, 0])
    scale([1.7, 1.7, 1.7])
    rotate([0, 0, 0])
    import("vendor/UltimakerRobot_support.stl", center = true);
}

module wowTop() {
    translate([0, 18, 24])
    scale([25, 25, 25])
    rotate([90, 180, 90])
    import("vendor/dogemix.stl", center = true);

    color(COLOR_VBRED)
    translate([0, 0, 0])
    rotate([0, 0, 0])
    linear_extrude(height = textThickness) {
        text("wow", font = "Open Sans", size = 6, halign = "center");
    }

    color(COLOR_VBRED)
    translate([0, -15, 0])
    rotate([0, 0, 0])
    linear_extrude(height = textThickness) {
        text("such award", font = "Open Sans", size = 6, halign = "center");
    }
}

module renderTrophy(name) {
    color(COLOR_BASE)
    /*if (useAlternativeBase) {
        baseAlt();
    } else {
        base();
    }*/
    color(COLOR_GOLD)
    if (name == "Culture") {
        cultureTop();
    } else if (name == "Popular Vote") {
        popularVoteTop();
    } else if (name == "Impact") {
        impactTop();
    } else if (name == "Technology") {
        technologyTop();
    } else if (name == "Wow") {
        wowTop();
    }
/*
    if (useAlternativeBase) {
        translate([0, -40, -2])
        rotate([60, 0, 0])
        description(name);
    } else {
        difference() {
            translate([0, -28, -2])
            rotate([60, 0, 0])
            description(name);

            translate([3, -15, 2.4])
            cube([baseWidth * 0.8, baseWidth * 0.8, baseHeight * 0.15], center = true);
        }
    }*/
}

awardSpacing = baseWidth * 2;

//translate([awardSpacing * 0, 0, 0])
//rotate([0, 0, shouldAnimate ? $t * 360 : 0])
//renderTrophy("Culture");

//translate([awardSpacing * 1, 0, 0])
//rotate([0, 0, shouldAnimate ? $t * 360 : 0])
//renderTrophy("Popular Vote");

//translate([awardSpacing * 2, 0, 0])
//rotate([0, 0, shouldAnimate ? $t * 360 : 0])
//renderTrophy("Impact");

//translate([awardSpacing * 3, 0, 0])
//rotate([0, 0, shouldAnimate ? $t * 360 : 0])
renderTrophy("Technology");

//translate([awardSpacing * 4, 0, 0])
//rotate([0, 0, shouldAnimate ? $t * 360 : 0])
//renderTrophy("Wow");