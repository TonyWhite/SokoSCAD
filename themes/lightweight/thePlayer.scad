module thePlayer(){
  face_color=[1,1,0];
  eyes_color=[0,0,0];
  
  // Give the coordinates of a regular polygon
  function regular_polygon_coords(order=4, r=1) =
    [ for (th=[ for (i = [0:order-1]) i*(360/order) ]) [r*cos(th), r*sin(th)] ];
  
  module mouth(detail=4, r_min=1, r_max=1.5){
    angles=[ for (i = [0:detail-1]) i*(90/(detail-1))-(90+45) ];
    coords_min=[ for (th=angles) [r_min*cos(th), r_min*sin(th)] ];
    coords_max=[ for (i=[len(angles)-1:-1:0]) [r_max*cos(angles[i]), r_max*sin(angles[i])] ];
    faces=[ for (i=[0:(detail*2)-1]) i ];
    polyhedron(concat(coords_min,coords_max),[faces],convexity=2);
  }
  
  // Face
  color(face_color)
  render(convexity=5)
  translate([0.5,0.5,0.01])
  polyhedron(regular_polygon_coords(8,0.5),[[0,1,2,3,4,5,6,7]],convexity=1);
  
  // Eyes
  color(eyes_color)
  render(convexity=5)
  polyhedron(
    [
      [0.3,0.5,0.02],[0.3+0.1,0.5,0.02],[0.3+0.1,0.5+0.2,0.02],[0.3+0,0.5+0.2,0.02],
      [0.6,0.5,0.02],[0.6+0.1,0.5,0.02],[0.6+0.1,0.5+0.2,0.02],[0.6+0,0.5+0.2,0.02]
    ],
    [
      [0,1,2,3],
      [4,5,6,7]
    ],convexity=5
  );
  
  // Mouth
  color(eyes_color)
  render(convexity=5)
  translate([0.5,0.5,0.02])
  mouth(detail=6, r_min=0.25, r_max=0.35);
}

thePlayer();