module theFloor(){
  color([0,0.6,0])
  polyhedron([[0,0,0],[1,0,0],[1,1,0],[0,1,0]],[[0,1,2,3]],convexity=1);
}

theFloor();