module theGoal(){
  detail=16;
  
  // Give the coordinates of a regular polygon
  function regular_polygon_coords(order=4, r=1) =
    [ for (th=[ for (i = [0:order-1]) i*(360/order) ]) [r*cos(th), r*sin(th)] ];
  
  little_coords=regular_polygon_coords(order=detail,r=0.2);
  little_face=[for (i=[0:len(little_coords)-1]) i];
  
  big_coords=regular_polygon_coords(order=detail,r=0.25);
  big_face=[for (i=[0:len(big_coords)-1]) i];
  
  color([1,0,0])
  render(convexity=1)
  translate([0.5,0.5,0.02])
  polyhedron(
    little_coords,
    [
      little_face
    ],
    convexity=1
  );

  gray=0.8;
  color([gray,gray,gray])
  render(convexity=5)
  translate([0.5,0.5,0.01])
  polyhedron(
    big_coords,
    [
      big_face
    ],
    convexity=3
  );
}

theGoal();