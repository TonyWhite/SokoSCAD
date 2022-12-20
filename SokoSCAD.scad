/*
Can I play with madness? Yes, I can.
Let's play Sokoban!

How to play?
Set View top orthogonal, than view all
Open Customizer: Menu Window --> Customizer
Open "Player" section
Edit "actions" array.
*/

use<themes/simple/theBox.scad>
use<themes/simple/theFloor.scad>
use<themes/simple/theGoal.scad>
use<themes/simple/thePlayer.scad>
use<themes/simple/theWall.scad>
include <levels/levels.scad>

/* [Player] */
// Array of commands: up, down, left, right.
actions=[];
level=0;

///////////////////////////////////////////////////////
// ! // Variables are processed only in compile-time //
///////////////////////////////////////////////////////
/*
This means that variables cannot be reassigned except within the scope
of the "let" function. Therefore, the constructs (loops and conditions)
must not reassign the value to the variables, but the scopes of
reassignments must simulate the constructs.

And that's supposed to clear my mind? No.
It is just a description of a situation constrained by technicalities.

So how to write a simple application with sequential commands?
You have to replace the cyclic constructs with conditional constructs
that make a recursive call.

...So what?
- Simulate cycles using recursive functions.
- Maintain variable reassignments by initiating recursivity while staying
within the scope of reassignment.
*/

// Get the player position.
function get_player_position(map) = 
  let(tmp = [
    for (y=[0:map_height-1])
      for (x=[0:map_width-1])
        if (map[y][x]==P || map[y][x]==O)
          [x,y]]
  )
  tmp[0]
;

// Edit the map
function edit_map(map,item_x,item_y,item) = [
  for(y=[0:map_height-1])[
    for(x=[0:map_width-1])
      if(item_x==x && item_y==y) item
      else map[y][x]]
];

// The player make a step
function move_player(i,map,player_position,next_step) =
  let(tmp=[
    if(map[player_position.y][player_position.x]==P && map[next_step.y][next_step.x]==F)
      // Move from floor to floor
      let(map=edit_map(map=map,item_x=player_position.x,item_y=player_position.y,item=F))
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=P))
      do_action(i=i+1,map=map)[0]
    else if(map[player_position.y][player_position.x]==P && map[next_step.y][next_step.x]==G)
      // Move from floor to goal
      let(map=edit_map(map=map,item_x=player_position.x,item_y=player_position.y,item=F))
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=O))
      do_action(i=i+1,map=map)[0]
    else if(map[player_position.y][player_position.x]==O && map[next_step.y][next_step.x]==F)
      // Move from goal to floor
      let(map=edit_map(map=map,item_x=player_position.x,item_y=player_position.y,item=G))
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=P))
      do_action(i=i+1,map=map)[0]
    else
      // Move from goal to goal
      let(map=edit_map(map=map,item_x=player_position.x,item_y=player_position.y,item=G))
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=O))
      do_action(i=i+1,map=map)[0]
  ])
  tmp[0]
;

// The player moves with the box
function move_box(i,map,player_position,next_step,b_next_step) =
  let(tmp=[
    if(map[next_step.y][next_step.x]==B && map[b_next_step.y][b_next_step.x]==F)
      // Move from floor to floor
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=F))
      let(map=edit_map(map=map,item_x=b_next_step.x,item_y=b_next_step.y,item=B))
      move_player(i=i,map=map,player_position=player_position,next_step=next_step)
    else if(map[next_step.y][next_step.x]==B && map[b_next_step.y][b_next_step.x]==G)
      // Move from floor to goal
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=F))
      let(map=edit_map(map=map,item_x=b_next_step.x,item_y=b_next_step.y,item=X))
      move_player(i=i,map=map,player_position=player_position,next_step=next_step)
    else if(map[next_step.y][next_step.x]==X && map[b_next_step.y][b_next_step.x]==F)
      // Move from goal to floor
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=G))
      let(map=edit_map(map=map,item_x=b_next_step.x,item_y=b_next_step.y,item=B))
      move_player(i=i,map=map,player_position=player_position,next_step=next_step)
    else
      // Move from goal to goal
      let(map=edit_map(map=map,item_x=next_step.x,item_y=next_step.y,item=G))
      let(map=edit_map(map=map,item_x=b_next_step.x,item_y=b_next_step.y,item=X))
      move_player(i=i,map=map,player_position=player_position,next_step=next_step)
  ])
  tmp[0]
;

// Do action and update map (recursive)
// Returns the updated map. Warning! The map is nested at index=0
function do_action(i,map) = [
  if (i<len(actions)) // Calculate an action
    let(action=actions[i])
    let(player_position=get_player_position(map))
    
    // Calculate next step
    let(next_step=[
      action==L
      ? player_position.x-1
      : action==R
        ? player_position.x+1
        : player_position.x,
      action==U
      ? player_position.y-1
      : action==D
        ? player_position.y+1
        : player_position.y
      ])
    // Detect the next object
    let(next_obj=map[next_step.y][next_step.x])
    
    // Can the player move?
    if(next_obj==F || next_obj==G) // The player can move
      move_player(i=i,map=map,player_position=player_position,next_step=next_step)
    else if(next_obj==B || next_obj==X) // The player hitted a box
      // Calculate beyond the next step
      let(b_next_step=[
        action==L
        ? player_position.x-2
        : action==R
          ? player_position.x+2
          : player_position.x,
        action==U
        ? player_position.y-2
        : action==D
          ? player_position.y+2
          : player_position.y
      ])
      // Detect beyond the next object
      let(b_next_obj=map[b_next_step.y][b_next_step.x])
      // The player can move the box?
      if(b_next_obj==F || b_next_obj==G) // The player can move the box
        move_box(i=i,map=map,player_position=player_position,next_step=next_step,b_next_step=b_next_step)
      else // The player can't move the box
        do_action(i=i+1,map=map)[0]
    else // The player hit ted something
      do_action(i=i+1,map=map)[0]
  else // Ends recursion when player actions end
    map // Returns the updated map
];

// Initialize constant
map_title=levels[level][0];
map_width=levels[level][1];
map_height=levels[level][2];

// Run application
module run(){
  
    
  
  if(level<len(levels)){
    // Center everything at the origin of the axes
    translate([-map_width/2,map_height/2,0]){
      // Draw the game title
      translate([map_width/2,3.5,0]) color("black") text("SokoSCAD",size=1,halign="center",$fn=50);
      // Draw the separator
      translate([map_width*0.1,3,0]) color("green") cube([map_width*0.8,0.1,0.5]);
      // Draw the level title
      translate([map_width/2,2,0]) color("black") text(map_title,size=0.5,halign="center",$fn=50);
      
      // Do actions and update the map
      map=do_action(i=0,map=levels[level][3])[0];
      
      // Draw the map
      for(y=[0:map_height-1]){
        for(x=[0:map_width-1]){
          item=map[y][x];
          translate([x,-y,0]){
            if (item==F || item==W || item==P || item==B || item==G || item==O || item==X) theFloor();
            if (item==W) theWall();
            if (item==P || item==O) thePlayer();
            if (item==B || item==X) theBox();
            if (item==G || item==O || item==X) theGoal();
          }
        }
      }
      
      // Draw moves
      translate([map_width/2,-map_height-0.5]) color("black") text(str("Moves: ",len(actions)),size=0.7,halign="center",$fn=50);
      
      // YOU WIN
      goal_ok=[
        for(y=[0:map_height-1])
          for(x=[0:map_width-1])
          if (map[y][x]==X) 1
      ];
      goal_no=[
        for(y=[0:map_height-1])
          for(x=[0:map_width-1])
          if (map[y][x]==G || map[y][x]==O) 1
      ];
      if (len(goal_ok)>0 && len(goal_no)==0)
        translate([map_width/2,-map_height-2,0]) color("red") text("YOU WIN",size=1,halign="center",$fn=50);
      else
        translate([map_width/2,-map_height-2,0]) color([0,0,0,0]) text("RESERVE SPACE",size=1,halign="center",$fn=50);
    }
  }
  else{
    // Draw the game title
    translate([0,2,0]) color("black") text("SokoSCAD",size=1,halign="center",$fn=50);
    // Draw the separator
    translate([-5,1.5,0]) color("green") cube([10,0.1,0.5]);
    //translate([0,0])
    color("red") text(str("The level ", level, " does not exists (yet)"),size=1,halign="center",$fn=50);
  }
}

run();