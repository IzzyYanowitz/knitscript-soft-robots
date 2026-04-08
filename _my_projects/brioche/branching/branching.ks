import cast_ons;


front_carr = c1;
back_carr = c2;

width = 50;
height = 50;
setup_height = 10;

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

    cast_ons.knit_cast_on(Front_Needles[:width], extra_knits = 3);
    xfer Front_Loops[1 : : 2] 1 to Left; // sets up ribbing
    // it is important to have the two beds ontop of each other so to speak because of the way brioche knitting works

    brioche_knit(knit_loops = Front_Loops, tuck_needles = Back_Loops, direct = Leftward);
}

with Carrier as back_carr: {
    in Leftward direction: {
        tuck Back_Needles[width];
    }
    drop Back_Needles[width];
    brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops, direct = Leftward);
    releasehook;
}

row_direct = Rightward;
for row in range(setup_height): {
    
    
    with Carrier as front_carr: {
        brioche_knit(knit_loops = Front_Loops, tuck_needles = Back_Loops, direct = row_direct);
    }
    
    with Carrier as back_carr: {
        brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops, direct = row_direct);
    }
    // i swap direct at end so I can use after
    row_direct = [Leftward, Rightward][row % 2];
}


