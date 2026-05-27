// my thinking was it might be useful to have a fabric that is conductive only on one side
// to color brioche seems like it was practically made for a knitting machine
// its so hard to do by hand but it seems easy for the machine

import cast_ons;
import bind_offs;

width = 30;
height = 30;


// make sure front carr has smaller index than back carr
front_carr = c3;
back_carr = c6;

def brioche_knit(knit_loops, tuck_needles, direct): {
    
    // flip order of knit_loops and tuck_needles if going leftward
    if direct == Leftward: {
        knit_loops = knit_loops[ : : -1];
        tuck_needles = tuck_needles[ : : -1];
    }


    for needle_index in range(len(knit_loops)): {
        in direct direction: {
            knit knit_loops[needle_index];
            tuck tuck_needles[needle_index];
        }
    }
}
with Gauge as 2: {
    // set up rows
    with Carrier as front_carr: {

        cast_ons.knit_cast_on(Front_Needles[ : (2 * width) + 2], extra_knits = 3);
        xfer Front_Loops[2 : 2 * width  + 1: 2] 1 to Left; // sets up ribbing
        
        // it is important to have the two beds ontop of each other so to speak because of the way brioche knitting works
        
        brioche_knit(knit_loops = Front_Loops[1 : width + 1], tuck_needles = Back_Loops, direct = Leftward);
        
    }

    with Carrier as back_carr: {
        // gets yarn inserting hook in correct place
        in Leftward direction: {
            tuck Back_Needles[2 * width];
        }
        drop Back_Needles[2 * width];
        
        // set up row
        brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops[1 : width + 1], direct = Leftward);
        
        releasehook;
    }

    row_direct = Rightward;
    for row in range(height): {
        
        
        with Carrier as front_carr: {
            first_needle = Front_Loops[0];     
            last_needle = Front_Loops[-1];

            if row_direct == Leftward: {
                first_needle = Front_Loops[-1];     
                last_needle = Front_Loops[0];
            }

            in row_direct direction: {
                knit first_needle;
            }
            brioche_knit(knit_loops = Front_Loops[1 : width + 1], tuck_needles = Back_Loops, direct = row_direct);
            in row_direct direction: {
                knit last_needle;
            }
        }   
        
        with Carrier as back_carr: {
            brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops[1 : width + 1], direct = row_direct);
        }
        // i swap direct at end so I can use after
        row_direct = [Leftward, Rightward][row % 2];
    }

    cut back_carr;

    // bind off

    with Carrier as front_carr: {
        xfer Back_Loops 1 to Right; // re-interlace back and front loops
        

    
        
        


        bo_needles = Loops[1:-1];
        double_loops = 1;
        xfer_direction = Right;
        
        first_needle = Front_Loops[0];     
        last_needle = Front_Loops[-1];

        if row_direct == Leftward: {
            bo_needles = bo_needles[::-1];
            double_loops = 0;
            xfer_direction = Left;
            first_needle = Front_Loops[-1];     
            last_needle = Front_Loops[0];
        }
        
        // bind off first needle
        in row_direct direction: {
            knit first_needle;
        }
        xfer first_needle 1 to xfer_direction;
        
        // bind off brioche needles
        for i, needle in enumerate(bo_needles): {
            
            // if the needle has two loops, knit it, then bind off as normal
            if (i % 2) == double_loops: {
                in row_direct direction: {
                    knit needle;
                }
            }
            
            xfer Back_Needles[i + 1] across;
            in row_direct direction: {
                    knit needle;
                }
            xfer needle 1 to xfer_direction;
        }

        // bind off last needle
        xfer Back_Loops across;
        in row_direct direction: {
            knit last_needle;
        }
        // move over piece on bed
        in Rightward direction: {
            tuck Front_Needles[2 * width + 2 : 3 * width + 2: 2];
        }
        
    }
}
