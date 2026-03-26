import cast_ons;
import bind_offs;

width_patterns = 3;
height_patterns = 2;
border_width = 4;
cable_width = 4;
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
    left1_cable_loops = [];
    right1_cable_loops = [];
    left2_cable_loops = [];
    right2_cable_loops = [];


    // this is a great example of why you shouldn't write code when you're feeling lazy
    for i in range(width_patterns): {
        background_loops = background_loops + [border_width + (pattern_width * i) + j for j in range(background_width)];
        background_loops = background_loops + [border_width + (pattern_width * i) + background_width + (2 * cable_width) + j for j in range(background_width)];

        left2_cable_loops = left2_cable_loops + [border_width + (pattern_width * i) + background_width + j for j in range(int(cable_width / 2))];
        right1_cable_loops = right1_cable_loops + [border_width + (pattern_width * i) + background_width + cable_width + j for j in range(int(cable_width / 2))];
        left1_cable_loops = left1_cable_loops + [border_width + (pattern_width * i) + background_width + j + (int(cable_width / 2)) for j in range(int(cable_width / 2))];
        right2_cable_loops = right2_cable_loops + [border_width + (pattern_width * i) + background_width + cable_width + j + (int(cable_width / 2)) for j in range(int(cable_width / 2))];
    }
    print(left2_cable_loops);
    print(right2_cable_loops);
    left_cable_loops = left1_cable_loops + left2_cable_loops;
    right_cable_loops = right1_cable_loops + right2_cable_loops;
    

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

        // cable row 1
        
        xfer [Front_Needles[i] for i in right1_cable_loops] int(cable_width / 2) to Left;
        xfer [Front_Needles[i] for i in left1_cable_loops] int(cable_width / 2) to Right;
        
        xfer [Back_Needles[i - 2] for i in right1_cable_loops] across to Front bed;
        xfer [Back_Needles[i + 2] for i in left1_cable_loops] across to Front bed;

        in reverse direction: {
            knit Loops;
        }

        // cable row 2
        xfer [Front_Needles[i - 2] for i in right1_cable_loops] int(cable_width / 2) to Left;
        xfer [Front_Needles[i + 2] for i in left1_cable_loops] int(cable_width / 2) to Right;
        xfer [Front_Needles[i] for i in right2_cable_loops] int(cable_width / 2) to Left;
        xfer [Front_Needles[i] for i in left2_cable_loops] int(cable_width / 2) to Right;
        
        xfer [Back_Needles[i - 4] for i in right1_cable_loops] across;
        xfer [Back_Needles[i + 4] for i in left1_cable_loops] across;
        xfer [Back_Needles[i - 2] for i in right2_cable_loops] across;
        xfer [Back_Needles[i + 2] for i in left2_cable_loops] across;

        in reverse direction: {
            knit Loops;
        }
        

        // cable row 3
        xfer [Front_Needles[i] for i in right1_cable_loops] int(cable_width / 2) to Left;
        xfer [Front_Needles[i] for i in left1_cable_loops] int(cable_width / 2) to Right;
        
        xfer [Back_Needles[i - 2] for i in right1_cable_loops] across to Front bed;
        xfer [Back_Needles[i + 2] for i in left1_cable_loops] across to Front bed;


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