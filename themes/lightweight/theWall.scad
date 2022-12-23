module theWall(){
  brick_color="gray";
  brick_d=[1,0.5,0.5];
  gap=0.1;
  
  color(brick_color)
  render(convexity=2)
  polyhedron(
    [
      [0,0,0],[1,0,0],[1,1,0],[0,1,0],
      [0.1,0.1,0.1],[0.9,0.1,0.1],[0.9,0.9,0.1],[0.1,0.9,0.1]
    ],
    [
      [0,1,2,3],
      [4,5,6,7],
      [0,1,5,4],
      [1,2,6,5],
      [2,3,7,6],
      [3,0,4,7]
    ],
    convexity=5
  );
}

theWall();