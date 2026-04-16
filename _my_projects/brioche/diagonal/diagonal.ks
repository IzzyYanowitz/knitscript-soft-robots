// combonation of increases and decreases in a way that appears to move a column on a diagonal

import cast_ons;
import bind_offs;

width = 30;

// make sure front carr has smaller index than back carr
front_carr = c3;
back_carr = c9;

def brioche_along(knit_loops, tuck_needles, direct): {
    // more robust version of brioche_knit

    // flip order of knit_loops and tuck_needles if going leftward
    if direct == Leftward: {
        knit_loops = knit_loops[ : : -1];
        tuck_needles = tuck_needles[ : : -1];
    }

    for needle_index in range(len(knit_loops)): {
        if knit_loops[needle_index] in Loops: {
            in direct direction: {
                knit knit_loops[needle_index];
                tuck tuck_needles[needle_index];
            }
                
        } else: {
            in direct direction: {
                tuck knit_loops[needle_index];
                tuck tuck_needles[needle_index];
            }
        }
    }
}

// set up rows
with Carrier as front_carr: {
    width = int(width / 2); // important to have an even width
    cast_ons.knit_cast_on(Front_Needles[ : (2 * width) + 2], extra_knits = 3);
    
    xfer Front_Loops[2 : 2 * width  + 1: 2] 1 to Left; // sets up ribbing
    
    // it is important to have the two beds ontop of each other so to speak because of the way brioche knitting works
    
    brioche_along(knit_loops = Front_Loops[1 : width + 1], tuck_needles = Back_Loops, direct = Leftward);
    
}

with Carrier as back_carr: {
    // gets yarn inserting hook in correct place
    in Leftward direction: {
        tuck Back_Needles[2 * width + 5];
    }
    drop Back_Needles[2 * width + 5];
    
    // set up row
    brioche_along(knit_loops = Back_Loops, tuck_needles = Front_Loops[1 : width + 1], direct = Leftward);
    
    releasehook;
}

row_direct = Rightward;
row = 0;
current_needle = 3;
while row < ((2 * width) - 5): {
    
    if (row % 2) == 0: {
        xfer Back_Needles[current_needle] across;
        xfer Front_Needles[current_needle - 2] 1 to Right;
        xfer Back_Needles[current_needle - 1] 1 to Right;
        current_needle = current_needle + 2; // plus two because the loops are every other needle
        width = width - 2;
    }
    
    f_loops = Front_Loops[1 : len(Front_Loops) - 1];
    b_loops = Back_Loops[0 : len(Back_Loops)];
    
    with Carrier as front_carr: {
        if (row % 2) == 0: {
            // knit normal

            first_needle = Front_Loops[0];     
            last_needle = Front_Loops[-1];

            if row_direct == Leftward: {
                first_needle = Front_Loops[-1];     
                last_needle = Front_Loops[0];
            }
            
            in row_direct direction: {
                knit first_needle;
            }
            brioche_along(knit_loops = f_loops, tuck_needles = b_loops, direct = row_direct);
            in row_direct direction: {
                knit last_needle;
            }
            
        }

        elif (row % 2) == 1: {
            // increase
            // only works if carrier is traveling leftward
            
            in row_direct direction: {
                knit Front_Loops[-1];
            }
            brioche_along(knit_loops = Front_Loops[int((current_needle - 1) / 2) + 1: len(Front_Loops) - 1], tuck_needles = Back_Loops[int((current_needle - 3) / 2) + 1 : len(Back_Loops)], direct = row_direct);
        
            in row_direct direction: {
                split Front_Needles[current_needle - 2];
            }
            xfer Back_Needles[current_needle - 2] 2 to Left;
            
            in row_direct direction: {
                tuck Back_Needles[current_needle - 2];
            }
            brioche_along(knit_loops = Front_Loops[1 : int((current_needle - 1) / 2)], tuck_needles = Back_Loops[ : int((current_needle - 3) / 2)], direct = row_direct);
            in row_direct direction: {
                knit Front_Loops[0];
            }
            width = width + 2;
        }
        
    }

    
    
    with Carrier as back_carr: {
        brioche_along(knit_loops = b_loops, tuck_needles = f_loops, direct = row_direct);
    }
    
    // i swap direct at end so I can use after
    row_direct = [Leftward, Rightward][row % 2];
    
    row = row + 1;
}

cut back_carr;

// bind off

with Carrier as front_carr: {
    
    xfer Back_Loops 1 to Right; // re-interlace back and front loops
    
    bo_needles = Loops[1:-1];
    
    xfer_direction = Right;
    
    first_needle = Front_Loops[0];     
    last_needle = Front_Loops[-1];

    if row_direct == Leftward: {
        bo_needles = bo_needles[::-1];
        
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
        if (i % 2) == 1: {
            in row_direct direction: {
                knit needle;
            }
        }
        
        xfer Back_Loops[0] across; // I know this isn't very robust but I can't be fucked
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
    
    in Rightward direction: {
        tuck Back_Needles[0:3*width];
    }
    
}