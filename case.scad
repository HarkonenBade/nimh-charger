$fn=36;

module rbox(size, r) {
    linear_extrude(size.z) offset(r=r) offset(delta=-r) square([size.x, size.y]);
}

module rbox_rtop(size, rs, rt) {
    translate([rt, rt, rt]) minkowski() {
        rbox([for(i=size) i - (2*rt)], rs);
        sphere(r=rt);
    }
}

module led() {
    cylinder(d=5.5, h=10);
}

module pillar() {
    difference() {
        cylinder(d=8, h=4);
        cylinder(d=3.5, h=4);
        translate([0, 0, 1.5]) cylinder(d=6.5, h=2.5, $fn=6);
    }
}

//Box
difference() {
    union(){
        difference(){
            translate([0, 0, -2.5]) rbox_rtop([95, 95, 9.6], rs=7.5, rt=1);
            translate([3.75, 3.75, 0]) rbox([87.5, 87.5, 5.6], r=5);
            translate([2.25, 2.25, -2.5]) rbox([90.5, 90.5, 4.1], r=5);
        }
        translate([2.5, 2.5, 0]) {
            for(y=[30, 70]){
                translate([45, y, 1.6]) pillar();
            }
            for(x=[1.3, 49.8]) {
                translate([x, 1.25, 1.6]) cube([38.9, 59.5, 4]);
            }
        }
    }
    translate([2.5, 2.5, 0]) {
        for(x=[11, 30.5, 59.5, 79]) {
            translate([x, 83-1.27, 1.59]) led();
        }
        translate([45, 57+1.27, 1.59]) led();
        for(x=[2.3, 21.8, 50.8, 70.3]) {
            translate([x, 2.25, 1.59]) cube([17.4, 57.5, 10]);
        }
        translate([45-(9.6/2), -0.25, 1.6]) cube([9.6, 4, 4]);
        translate([45-(9.6/2), 0, 1.1]) rotate([90, 0, 0]) rbox([9.6, 4, 2.5], r=1.9);
    }
}


//Lid
translate([100, 0, -2.5])
difference() {
    union() {
        difference() {
            rbox([90, 90, 2.5], r=5);
            translate([1.5, 1.5, 1]) rbox([87, 87, 1.51], r=5);
        }
        for(y=[30, 70]){
            translate([45, y, 1]) cylinder(d=8, h=1.5);
        }
        for(y=[15, 30, 50, 70]) {
            translate([0, y-1, 1]) cube([90, 2, 1.5]);
        }
        for(x=[20.75, 69.25]) {
            translate([x, 0, 1]) cube([2, 90, 1.5]);
        }
        translate([44, 0, 1]) {
            translate([0, 15, 0]) cube([2, 15, 1.5]);
            translate([0, 70, 0]) cube([2, 20, 1.5]);
        }
    }
    for(y=[30, 70]){
        translate([45, y, 0]) {
            cylinder(d=3.5, h=3);
            cylinder(d1=8, d2=0, h=4);
        }
    }
    translate([45-(9.6/2), -0.25, 1]) cube([9.6, 2, 1.51]);
}  

//color("green") translate([2.5, 92.5, 0]) import("nimh-charger.stl");