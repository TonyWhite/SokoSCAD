module theWall(){
  brick_color="gray";
  brick_d=[1,0.5,0.5];
  gap=0.1;
  
  module brick_old(){
    translate([brick_d.x/2,brick_d.y/2,brick_d.z/2]){
      render(convexity=10)
      intersection(){
        cube(brick_d,true);
        union(){
          cube([brick_d.x-gap/2,brick_d.y-gap/2,brick_d.z+gap],true);
          cube([brick_d.x+gap,brick_d.y-gap/2,brick_d.z-gap/2],true);
          cube([brick_d.x-gap/2,brick_d.y+gap,brick_d.z-gap/2],true);
        }
      }
    }
  }
  
  module brick(){
    module cutter(){
      linear_extrude(max(brick_d)*2,center=true)
      polygon([[-gap,gap],[gap,0],[0,-gap]]);
    }
    render()
    difference(){
      cube(brick_d,center=true);
      translate([-brick_d.x/2,brick_d.y/2,0]) cutter();
      translate([brick_d.x/2,brick_d.y/2,0]) rotate([0,0,-90]) cutter();
      translate([brick_d.x/2,-brick_d.y/2,0]) rotate([0,0,180]) cutter();
      translate([-brick_d.x/2,-brick_d.y/2,0]) rotate([0,0,90]) cutter();
      
      translate([-brick_d.x/2,0,brick_d.z/2]) rotate([90,0,0]) cutter();
      translate([brick_d.x/2,0,brick_d.z/2]) rotate([90,90,0]) cutter();
      translate([brick_d.x/2,0,-brick_d.z/2]) rotate([90,180,0]) cutter();
      translate([-brick_d.x/2,0,-brick_d.z/2]) rotate([90,-90,0]) cutter();
      
      translate([0,-brick_d.y/2,brick_d.z/2]) rotate([90,0,0]) rotate([0,90,0]) cutter();
      translate([0,brick_d.y/2,brick_d.z/2]) rotate([0,0,0]) rotate([0,90,0]) cutter();
      translate([0,brick_d.y/2,-brick_d.z/2]) rotate([-90,0,0]) rotate([0,90,0]) cutter();
      translate([0,-brick_d.y/2,-brick_d.z/2]) rotate([180,0,0]) rotate([0,90,0]) cutter();
    }
  }
  
  module brick_layer(){
    render(convexity=10)
    intersection(){
      union(){
        translate([0,-brick_d.y/2,0]) brick();
        translate([brick_d.x/2,brick_d.y/2,0]) brick();
        translate([-brick_d.x/2,brick_d.y/2,0]) brick();
      }
      cube([1,1,1],center=true);
    }
  }
  
  color(brick_color)
  render(convexity=10)
  translate([0.5,0.5,0.25]){
    brick_layer();
    translate([0,0,brick_d.z]) rotate([0,0,180]) brick_layer();
  }
}

theWall();