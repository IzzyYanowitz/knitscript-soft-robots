// stockenette patch closed on all four sides

import cast_ons;
import bind_offs;

width = 40;
height = 40;

with Gauge as 2, Carrier as c1: {
    // cast on the bottom as 1 piece then knit 2 rows for stability
    cast_ons.alt_tuck_cast_on(2 * width, is_front = True);
    // xfer every other loop to the back bed across from its partner
    
    xfer Loops[1 : 2 * width : 2] across;

    // now we have loops on every other needle, front and back, misaligned

    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }

        in reverse direction: {
            knit Back_Loops;
        }
    }

    // xfer back loops to front
    xfer Back_Loops across;

    // bind off

    bind_offs.chain_bind_off(Loops, Leftward);
    
}