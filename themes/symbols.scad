/*
Author: Antonio Bianco
GitHub: TonyWhite
License: GPL3
*/

module printChar(char="?"){
  translate([0.5,0.5,0.005])
  linear_extrude(0.1)
  translate([-0.015,-0.008,0]) resize([1,1,1]) text(char,font="DejaVu Sans",size=1,halign="center",valign="center");
}

module theBox(){
  color("black")
  printChar("\u2610");
  //color([0.6,0.2,0])
  color("white")
  translate([0.5,0.5,0.055])
  cube([0.9,0.9,0.07],center=true);
}

module theFloor(){
  color([0,0.6,0])
  polyhedron([[0,0],[1,0],[1,1],[0,1]],[[0,1,2,3]],convexity=1);
}

module theGoal(){
  color("black")
  translate([0.2,0.2,0])
  scale([0.6,0.6,0.9])
  printChar("\u00d7");
}

module thePlayer(){
  color("black")
  printChar("\u263a");
  color("yellow")
  translate([0.5,0.5,0.055])
  cylinder(d=0.9,h=0.09,center=true,$fn=16);
}

module theWall(){
  color("black")
  printChar("\u2610");
  color("gray")
  translate([0.5,0.5,0.055])
  cube([0.9,0.9,0.07],center=true);
}