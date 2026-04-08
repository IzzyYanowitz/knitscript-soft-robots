import cast_ons;
import bind_offs;


width = 30;
height = 30;

fabric_carr = c4;
tendon_carr = c6;

vert_gap = 5; // number of rows between cable rows
horz_gap = 3; // number of stitches between each instance of a cable bit

with Carrier as fabric_carr: {
    cast_ons.knit_cast_on(Front_Needles[ : width], Leftward, extra_knits = 3);
} 

with Carrier as tendon_carr: {
    
    cast_ons.knit_cast_on(Back_Needles[int(width / 2) : 2 * (width)], Leftward, extra_knits = 2);
    releasehook;
}

for tendon_repeat in range(int(height / (vert_gap))): {
    for row in range(vert_gap): {
        with Carrier as fabric_carr: {
            // normal rows 
            //xfer Loops across;
            in [Leftward, Rightward][(tendon_repeat + row) % 2] direction: {
                knit Front_Loops;
            }
        }  
    }
        if tendon_repeat == 2: {
            drop Back_Loops;
        }
        // bring loops to front if in back
        //xfer Loops across to Front bed;
        
        // cable section
        if tendon_repeat % 2 == 0: {
            cable_left = int(width / 2) - horz_gap;
            cable_right = cable_left + 1;

            xfer Front_Needles[cable_left] 1 to Right;
            with Carrier as tendon_carr: {
                
                in Leftward direction: {
                    tuck Back_Needles[cable_left - 1];
                }
                
            }
            xfer Front_Needles[cable_right] 1 to Left;
            
            xfer Back_Needles[cable_left] across;
            xfer Back_Needles[cable_right] across;
            drop Back_Needles[cable_left - 1];
            
            
        }

        if tendon_repeat % 2 == 1: {
            
            cable_left = int(width / 2) + horz_gap;
            cable_right = cable_left + 1;

            xfer Front_Needles[cable_right] 1 to Left;
            with Carrier as tendon_carr: {
                
                in Leftward direction: {
                    tuck Back_Needles[cable_right + 1];
                }
                
            }
            xfer Front_Needles[cable_left] 1 to Right;
            drop Back_Needles[cable_right + 1];
            xfer Back_Needles[cable_left] across;
            xfer Back_Needles[cable_right] across;
            
        }
        
}

with Carrier as fabric_carr: {
    for row in range(vert_gap): {
        in reverse direction: {
            knit Loops;
        }
    }
    bind_offs.chain_bind_off(Loops, reverse, hold = False, extra_knits = 0);
}