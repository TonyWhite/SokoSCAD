module theBox(){
  box_color=[0.6,0.2,0];
  plank_width=1/6;
  plank_height=0.05;
  plank_cut=0.02;
  
  module plank(length){
    linear_extrude(length,center=true)
    polygon([[-plank_width/2,0],
             [plank_width/2,0],
             [plank_width/2,plank_height-plank_cut],
             [plank_width/2-plank_cut,plank_height],
             [-(plank_width/2-plank_cut),plank_height],
             [-plank_width/2,plank_height-plank_cut]]
    );
  }
  
  module face(){
    difference(){
      union(){
        // Parallel planks
        for(i=[0:(1/plank_width)-plank_width]){
          translate([plank_width*i,0,0]) // Slide on face
          translate([plank_width/2-0.5,0.5-(plank_height*2),0]) // Put plank on face
          plank(1);
        }
        
        // Borders
        for(i=[0:90:270]){
          rotate([0,i,0])
          intersection(){
            translate([0.5-plank_width/2,0.5-plank_height,0]) plank(1);
            rotate([90,45,0]) linear_extrude(2,center=true) polygon([[0,0],[0,1.5],[1.5,0]]);
          }
        }
      }
      linear_extrude(2,center=true) polygon([[-2,2],[-2,0],[0,0]]);
      rotate([0,90,0]) linear_extrude(2,center=true) polygon([[-1.5,1.5],[-1.5,0],[0,0]]);
      rotate([0,180,0]) linear_extrude(2,center=true) polygon([[-1.5,1.5],[-1.5,0],[0,0]]);
      rotate([0,270,0]) linear_extrude(2,center=true) polygon([[-1.5,1.5],[-1.5,0],[0,0]]);
    }
  }
  
  color(box_color)
  render(convexity=10){
    // Faces
    face();
    rotate([180,0,0]) face();
    rotate([0,90,90]) face();
    rotate([0,0,-90]) face();
    rotate([90,0,0]) face();
    rotate([270,0,90]) face();
    
    // Diagonal planks
    rotate([0,0,0]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
    rotate([90,0,90]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
    rotate([180,0,0]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
    rotate([0,90,90]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
    rotate([180,90,90]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
    rotate([270,0,90]) rotate([0,45,0]) translate([0,0.5-plank_height,0]) plank(1);
  }
}

theBox();