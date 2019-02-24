$fn = 50;

kl = 60;   // Kantenlänge
ws = 3;

UR_d = kl/4*sqrt(3)*(1+sqrt(5)); // Umkreisradius Dodekaeder
IR_d = kl/2*sqrt((25+11*sqrt(5))/10);  // Inkreisradius Dodekaeder
UR_f = kl/10*sqrt(50+10*sqrt(5)); // Umkreisradius Fünfeck
IR_f = kl/10*sqrt(25+10*sqrt(5)); // Inkreisradius Fünfeck

alphaF = acos(-1/5*sqrt(5)); // Flächenwinkel Dodekaeder

module seitenteil(){
difference(){
linear_extrude(height=IR_d,scale=0)
polygon(points=[    [UR_f*cos(0),UR_f*sin(0)],
                    [UR_f*cos(72),UR_f*sin(72)],
                    [UR_f*cos(144),UR_f*sin(144)],
                    [UR_f*cos(216),UR_f*sin(216)],
                    [UR_f*cos(288),UR_f*sin(288)],
], path=[0,1,2,3,4] );
    translate([0,0,ws]) cylinder(r=UR_f+1,h=IR_d);
}}

module seitenteil_dht22(){
    difference(){
        seitenteil();
        rotate([0,0,2*72]) cube([20,15.1,10], center=true);
    }
}

module seitenteil_schlauch(){
    difference(){
        seitenteil();
        translate([0,0,-1]) cylinder(r=5,h=10);  
    }
}

module seitenteil_usb(){
    difference(){
        seitenteil();
        rotate([0,0,2*72]) cube([5,10,10], center=true);
    }
}

module seitenteil_gitter(){
    difference(){
        seitenteil();
        translate([0,0,-1]) cylinder(r=1.5,h=10);
        for (j=[5:5:25]){
        for (i=[1:1:j]){
          rotate([0,0,360/j*i])  translate([j,0,-1]) cylinder(r=1.5,h=10);
        }
    }
    }
}


module boden(){
seitenteil();
}


module schale(){
    boden();
    rotate([0,0,1*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil_gitter();  
   rotate([0,0,2*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil_dht22(); 
    rotate([0,0,3*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil_usb();
    rotate([0,0,4*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil_schlauch();
    rotate([0,0,5*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil();
}

module deckel(){
    boden();
    for (i=[1:5]){
    rotate([0,0,i*72]) translate([-IR_f,0,0]) rotate([0,180-alphaF,0]) translate([-IR_f,0,0]) rotate([0,0,36]) seitenteil();
    }
}

schale();
translate([0,0,150]) rotate([0,0,72/2]) mirror([0,0,1]) color("red") deckel();


