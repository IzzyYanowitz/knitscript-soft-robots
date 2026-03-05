import cast_ons;
import bind_offs;

width = 10;
height = 10;

with Gauge as 2, Carrier as c1: {
    // MAKE SURE TO CAPITALIZE Sheet
    with Sheet as s0: {
        cast_ons.alt_tuck_cast_on(width, is_front = True);
        xfer Loops[::2] across; // xfer every other loop for ribbing
    }

    with Sheet as s1: {
        cast_ons.alt_tuck_cast_on(width, is_front = False);
        xfer Loops[::2] across; // xfer every other loop for ribbing
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
        bind_offs.chain_bind_off(Loops, Leftward);
    }

    with Sheet as s1: {
        bind_offs.chain_bind_off(Loops, Rightward);
    }
}