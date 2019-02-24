$fn = 50;

r1 = 30/2;
r2 = 40/2;
L = r2*2;
ws = 2;     // Wandstärke
os = 1/3;   // offset


module das_teil(){
difference(){
    hull(){
        cylinder(r=r2,h=1);
        translate([0,0,L-r2]) sphere(r=r2);
    }
    hull(){
        translate([0,0,-1]) cylinder(r=r2-ws,h=1);
        translate([0,0,L-r2]) sphere(r=r2-ws);
    }
    translate([r2*os,-r2,-1]) cube([r2,2*r2,L+2]);
}

difference(){
    cylinder(r=r2,h=ws);
    translate([0,0,-1]) cylinder(r=r1,h=ws+2);
    translate([r2*os,-r2,-1]) cube([r2,2*r2,L+2]);
}
}

//rotate([0,90,0]) 
translate([-os*r2,0,0]) das_teil();
