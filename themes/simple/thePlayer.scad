module thePlayer(){
  face_color=[1,1,0];
  eyes_color=[0,0,0];
  
  module eyes(){
    translate([0.3,0.5,0.6])
    cube([0.1,0.2,0.01]);
    translate([0.6,0.5,0.6])
    cube([0.1,0.2,0.01]);
  }
  
  module mouth(){
    translate([0.5,0.5,0.6])
    rotate([0,0,-90-45])
    rotate_extrude(angle=90,convexity=2,$fn=20)
    translate([0.3,0,0])
    square([0.1,0.01],center=true);
  }
  
  module face(){
    translate([0.5,0.5,0.5])
    cylinder(h=0.2,d=1,center=true,$fn=20);
  }
  
  color(face_color)
  render(convexity=5)
  face();
  
  color(eyes_color)
  render(convexity=5)
  eyes();
  
  color(eyes_color)
  render(convexity=5)
  mouth();
}

thePlayer();