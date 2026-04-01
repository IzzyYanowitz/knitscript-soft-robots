import cast_ons;
import bind_offs;

height = 30;
width = 30;

with Carrier as c1: {
    cast_ons.knit_cast_on(Front_Needles[:width], Leftward, extra_knits = 2);
    cast_ons.knit_cast_on(Back_Needles[:width], Leftward, extra_knits = 2);

    for row in range(10): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }
    
    for end_needle in range(width): {

        for move_needle in range(width - 1, end_needle, -1): {
            
            xfer Back_Loops[move_needle] 1 to Right;
            
            xfer Front_Loops[move_needle + 1] across;
            
            xfer Front_Loops[move_needle] across;
            
            xfer Back_Loops[move_needle] 1 to Right;
        }
    }
    xfer Back_Loops 1 to Right;
    xfer Front_Loops[1 : : 2] across;
}
with Carrier as c1, Gauge as 2: {
    with Sheet as s0: {
        xfer Loops[1 : : 2] across;
    }
    with Sheet as s1: {
        xfer Loops[1 : : 2] across;
    }

    for row in range(height): {
        with Sheet as s0: {
            in reverse direction: {
                knit Loops;
            }
        }

        with Sheet as s1: {
            in reverse direction: {
                knit Loops;
            }
        }
    }

    with Sheet as s0: {
        xfer Loops across to Front bed;
        bind_offs.chain_bind_off(Loops, Rightward, hold = False, extra_knits = 0);
    }

    with Sheet as s1: {
        xfer Loops across to Back bed;
        bind_offs.chain_bind_off(Loops, Leftward, hold = False, extra_knits = 0);
    }
}

    
