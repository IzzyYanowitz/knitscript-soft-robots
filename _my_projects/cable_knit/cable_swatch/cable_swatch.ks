import cast_ons;
import bind_offs;

width_patterns = 3;
height_patterns = 4;
border_width = 4;
cable_width = 1;
background_width = 5; // just one side of the background
pattern_width = 2 * (background_width + cable_width);
normal_rows = 4;

carr = c1;

with Carrier as carr: {
    
    cast_ons.alt_tuck_cast_on((2 * border_width )+ (width_patterns * pattern_width), is_front = True);

    // set up garder bottom
    for row in range(border_width): {
        in reverse direction: {
            knit Loops;
        }
        xfer Loops across; 
    }
    
    xfer Back_Loops across to Front bed;

    background_loops = [];
    left_cable_loops = [];
    right_cable_loops = [];

    for i in range(width_patterns): {
        background_loops = background_loops + [border_width + (pattern_width * i) + j for j in range(background_width)];
        background_loops = background_loops + [border_width + (pattern_width * i) + background_width + (2 * cable_width) + j for j in range(background_width)];

        left_cable_loops = left_cable_loops + [border_width + (pattern_width * i) + background_width + j for j in range(cable_width)];
        right_cable_loops = right_cable_loops + [border_width + (pattern_width * i) + background_width + cable_width + j for j in range(cable_width)];
    }
    
    xfer [Front_Needles[i] for i in background_loops] across to Back bed;
    
    for reps in range(height_patterns): {
        
        // normal rows
        for row in range(normal_rows): {
            in reverse direction: {
                knit Loops;
            }

            // set up garder edges
            xfer [Front_Needles, Back_Needles][row % 2][ : border_width] across; 
            xfer [Front_Needles, Back_Needles][row % 2][(width_patterns * pattern_width) + border_width: (width_patterns * pattern_width) + (2 * border_width)] across;
        }

        // cable row
        xfer [Front_Needles[i] for i in right_cable_loops] cable_width to Left;
        xfer [Front_Needles[i] for i in left_cable_loops] cable_width to Right;
        
        xfer [Back_Needles[i] for i in right_cable_loops] across to Front bed;
        xfer [Back_Needles[i] for i in left_cable_loops] across to Front bed;

        // normal rows
        for row in range(normal_rows): {
            in reverse direction: {
                knit Loops;
            }

            // set up garder edges
            xfer [Front_Needles, Back_Needles][row % 2][ : border_width] across; 
            xfer [Front_Needles, Back_Needles][row % 2][width_patterns * pattern_width + border_width: (width_patterns * pattern_width) + (2 * border_width)] across;
        }
    }

    // garder border
    xfer Back_Loops across to Front bed;
    for row in range(border_width): {
        in reverse direction: {
            knit Loops;
        }
        xfer Loops across; 
    }

    bind_offs.chain_bind_off(Loops, Leftward);
}