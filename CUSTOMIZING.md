# Customizing

You can customize the appearance of the levels by selecting one of the available themes, or create your own.

## Apply a theme

Open `SokoSCAD.scad` with OpenSCAD.

Find the actual theme. The default is "lightweight"

```openscad
include<themes/lightweight.scad>
```

And change the theme name with another

```openscad
include<themes/simple.scad>
```

Update the preview (F5) and join the choosen theme!

## Create a theme

Full structure:

* `themes/simple.scad`
* `themes/simple/preview.png`
* `themes/simple/theBox.scad`
* `themes/simple/theFloor.scad`
* `themes/simple/theGoal.scad`
* `themes/simple/thePlayer.scad`
* `themes/simple/theWall.scad`

Minimal structure:

* `themes/symbols.scad`

You can use the default themes as example. Here is a brief description:

| Theme       | Description                                                                             |
|-------------|-----------------------------------------------------------------------------------------|
| simple      | Full-3D, The first theme I created. Useful if you want to see in perspective mode.      |
| lightweight | Semi-flat, The modified version of `simple` to **reduce the workload** during preview.    |
| symbols     | Semi-flat, high contrast, symbolic. Just minimal in appearance, structure and workload. |

### Drawing the items

1. To draw 2D objects, use the `polyhedron` function.
2. Each item must be drawn inside a 1x1x1 cube.
3. Only "Floor" can lean towards negative Z-axis values.
4. Only "Box", "Player" and "Wall" can protrude towards values greater than 1 on the Z axis.
5. Items must respect the Z coordinate when overlapping each other.

### Items that can be on top of others

> ### ℹ️ This is the overlap to respect
> 
> Floor → Goal → Box or Player  
> Box, Player and Wall: there's nothing that can be on top of it

**First column**: item on bottom  
**Other columns**: item on top

| Item   |  Floor |  Goal  |  Box   | Player |  Wall  |
|--------|:------:|:------:|:------:|:------:|:------:|
| Floor  |   ❌   |   ✅   |   ✅   |   ✅   |   ❌   |
| Goal   |   ❌   |   ❌   |   ✅   |   ✅   |   ❌   |
| Box    |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| Player |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |
| Wall   |   ❌   |   ❌   |   ❌   |   ❌   |   ❌   |

These Z coordinates are examples to respect consistency when overlapping elements.  
_Don't take these values ​​literally._

| Item   | MIN     | MAX   |
|--------|---------|-------|
| Floor  | -1.00   |  0.00 |
| Goal   |  0.01   |  0.02 |
| Box    |  0.03   |  1.00 |
| Player |  0.03   |  1.00 |
| Wall   |  0.00   |  1.00 |

### Create the preview image

The preview is optional, however it is advisable to use a guideline. This way users will be able to immediately find the differences between themes.

1. Open the `SokoSCAD.scad` file at level 0
2. Apply the your theme
3. Resize the Viewport to **900x720**
4. Activate the **orthogonal view**: View > Orthogonal menu
5. View from **top**: View menu > Top [Ctrl+4]
6. Zoom to the **optimal size**: View menu > View All [Ctrl+Shift+V]
7. Export `preview.png`: menu File > Export > Export as image...

## Share a theme

Are you proud of your theme?

If you want to share your theme, you can:
* Make a [pull](https://github.com/TonyWhite/SokoSCAD/pulls) request
* Open an [issue](https://github.com/TonyWhite/SokoSCAD/issues) to request an enhancement.

Remember to include author, license and description in the theme file!