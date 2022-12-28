module theBox(){
  box_color=[0.6,0.2,0];
  plank_width=1/6;
  plank_height=0.05;
  plank_cut=0.02;
  
  module plank(length=1){
    rotate([90,0,0])
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
        // Borders
        for(i=[0:90:270]){
          rotate([0,0,i])
          intersection(){
            translate([0.5-plank_width/2,0,0]) plank(1);
            rotate([0,0,-45]) linear_extrude(2,center=true) polygon([[0,0],[0,1.5],[1.5,0]]);
          }
        }
        // Diagonals
        rotate([0,0,45]) plank(1);
        rotate([0,0,-45]) plank(1);
        // Background
        linear_extrude(0.001)
        square(1,center=true);
      }
    }
  }
  
  color(box_color)
  render(convexity=10)
  translate([0.5,0.5,0.03]){
    face();
  }
}

theBox();