module theGoal(){
  color([1,0,0])
  render(convexity=1)
  translate([0.5,0.5,0])
  cylinder(d=0.7,h=0.01,$fn=50);

  gray=0.8;
  color([gray,gray,gray])
  render(convexity=5)
  translate([0.5,0.5,0])
  difference(){
    cylinder(d=0.9,h=0.01,$fn=50);
    cylinder(d=0.7,h=0.01,$fn=50);
  }
}

theGoal();