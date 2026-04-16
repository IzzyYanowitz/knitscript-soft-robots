// test of brioche increase and decrease

import cast_ons;
import bind_offs;

width = 50;
height = 50;
center = int(width / 2) + (1 - int(width / 2) % 2);


// make sure front carr has smaller index than back carr
front_carr = c4;
back_carr = c8;

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
        tuck Back_Needles[2 * width];
    }
    drop Back_Needles[2 * width];
    
    // set up row
    brioche_along(knit_loops = Back_Loops, tuck_needles = Front_Loops[1 : width + 1], direct = Leftward);
    
    releasehook;
}

row_direct = Rightward;
// i do a while loop here because i need a continue or next keyword
// but knit script doesn't have it so i wanted to do row++ but the for loops
// fucking act so weirdly i don't understand why it has something to do with compilers probably
row = 0;
while row < height: {

    if row == int(height / 3): {
        // decrease right
        
        xfer Back_Needles[center] across;
        xfer Front_Needles[center - 2] 1 to Right;
        xfer Back_Needles[center - 1] 1 to Right;
        width = width - 2;
        
    }
    
    if row == int(height / 3) + 1: {
        // right leaning increase
        
        with Carrier as front_carr: {
            in row_direct direction: {
                knit Front_Loops[-1];
            }
            brioche_along(knit_loops = Front_Loops[int((center + 1) / 2) + 1: len(Front_Loops) - 1], tuck_needles = Back_Loops[int((center - 1) / 2) + 1 : len(Back_Loops)], direct = row_direct);
        
            in row_direct direction: {
                split Front_Needles[center];
            }
            xfer Back_Needles[center] 2 to Left;
            
            in row_direct direction: {
                tuck Back_Needles[center];
            }
            brioche_along(knit_loops = Front_Loops[1 : int((center + 1) / 2)], tuck_needles = Back_Loops[ : int((center - 1) / 2)], direct = row_direct);
            in row_direct direction: {
                knit Front_Loops[0];
            }
        }
        
        width = width + 2;
        
        with Carrier as back_carr: {
            brioche_along(knit_loops = Back_Loops, tuck_needles = Front_Loops[1:len(Front_Loops) - 1], direct = row_direct);
        }
        
        row_direct = [Leftward, Rightward][row % 2];
        row = row + 1;
        
    }

    f_needles = Front_Loops[1:len(Front_Loops) - 1];
    b_needles = Back_Loops;
    
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
        
        brioche_along(knit_loops = f_needles, tuck_needles = b_needles, direct = row_direct);
        
        in row_direct direction: {
            knit last_needle;
        }
        
    }   
    
    with Carrier as back_carr: {
        brioche_along(knit_loops = b_needles, tuck_needles = f_needles, direct = row_direct);
        
    }
    // i swap direct at end so I can use it after
    row_direct = [Leftward, Rightward][row % 2];
    row = row + 1;
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
        tuck Front_Needles[2 * width + 2 : 3 * width + 2 : 2];
    }
}