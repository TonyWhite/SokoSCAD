module theBox(){
  box_color=[0.6,0.2,0];
  
  module plank(length){
    linear_extrude(length,center=true)
    polygon([[-0.05,0],[0.05,0],[0.05,0.03],[0.03,0.05],[-0.03,0.05],[-0.05,0.03]]);
  }
  
  module border(){
    translate([-0.45,-0.45,0])
    translate([-0.05,-0.05,-0.5])
    difference(){
      union(){
        translate([0.05,0.05,0])
        rotate([0,0,180])
        translate([0,0,0.5])
        plank(1);
        translate([0,0.05,0])
        cube([0.1,0.05,1]);
      }
      
      rotate([0,-45,0])
      translate([0,0,-0.1])
      cube([1,0.1,0.1],center=false);
      
      translate([0,0,1])
      rotate([0,45,0])
      cube([1,0.1,0.1],center=false);
      
      rotate([0,0,45])
      cube([1,0.1,1],center=false);
    }
  }
  
  module diagonal(){
    difference(){
      rotate([90,0,45])
      plank(sqrt((0.85^2)+(0.85^2)));
      
      // Cut the tips
      translate([-0.45,0,0]) rotate([90,0,0]) plank(2);
      translate([0,0.45,0]) rotate([90,0,90]) plank(2);
      translate([0.45,0,0]) rotate([90,0,0]) plank(2);
      translate([0,-0.45,0]) rotate([90,0,90]) plank(2);
    }
  }
  
  module face(){
    // Parallel planks
    for(i=[0:0.1:0.7]){
      rotate([180,0,0])       // Rotate on front face
      translate([i,0,0])      // Slide on face
      translate([-0.4,0.4,0]) // Put on face
      translate([0.05,0,0])   // Align vertex
      plank(0.8);
    }
    // Borders
    border();
    rotate([0,90,0]) border();
    rotate([0,180,0]) border();
    rotate([0,270,0]) border();
    // Diagonal plank
    translate([0,-0.45,0]) rotate([90,0,0]) diagonal();
  }
  
  color(box_color)
  render(convexity=10)
  translate([0.5,0.5,0.5]){
    face();
    rotate([90,0,-90]) face();
    rotate([180,0,0]) face();
    rotate([270,0,-90]) face();
    rotate([0,-90,90]) face();
    rotate([0,90,-90]) face();
  }
}

theBox();