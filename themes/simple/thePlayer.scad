module thePlayer(){
  face_color=[1,1,0];
  eyes_color=[0,0,0];
  
  module eyes(){
    translate([0.3,0.5,0.5])
    cube([0.1,0.2,0.5]);
    translate([0.6,0.5,0.5])
    cube([0.1,0.2,0.5]);
  }
  
  module face(){
    translate([0.5,0.5,0.5])
    sphere(d=1,$fn=100);
  }
  
  color(face_color)
  render(convexity=5)
  difference(){
    face();
    eyes();
  }
  
  color(eyes_color)
  render(convexity=5)
  intersection(){
    face();
    eyes();
  }
}

thePlayer();