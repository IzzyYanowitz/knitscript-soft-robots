// my thinking was it might be useful to have a fabric that is conductive only on one side
// to color brioche seems like it was practically made for a knitting machine
// its so hard to do by hand but it seems easy for the machine

import cast_ons;
import bind_offs;

width = 50;
height = 50;


// make sure front carr has smaller index than back carr
front_carr = c4;
back_carr = c5;

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

// set up rows
with Carrier as front_carr: {

    cast_ons.alt_tuck_cast_on(width, is_front = True);
    xfer Front_Loops[1 : : 2] 1 to Left; // sets up ribbing
    // it is important to have the two beds ontop of each other so to speak because of the way brioche knitting works

    brioche_knit(knit_loops = Front_Loops, tuck_needles = Back_Loops, direct = Leftward);
}

with Carrier as back_carr: {
    brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops, direct = Leftward);
}

row_direct = Rightward;
for row in range(height): {
    
    
    with Carrier as front_carr: {
        brioche_knit(knit_loops = Front_Loops, tuck_needles = Back_Loops, direct = row_direct);
    }
    
    with Carrier as back_carr: {
        brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops, direct = row_direct);
    }
    // i swap direct at end so I can use after
    row_direct = [Leftward, Rightward][row % 2];
}

with Carrier as front_carr: {
    xfer Back_Loops 1 to Right; // re-interlace back and front loops
    bind_offs.chain_bind_off(Loops, row_direct);
}