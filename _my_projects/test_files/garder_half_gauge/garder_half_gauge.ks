import cast_ons;
import bind_offs;

width = 20;
height = 20;

fabric_carr = c5;

with Gauge as 2: {
   
    with Carrier as fabric_carr: {
        cast_ons.alt_tuck_cast_on(width, is_front = True);
    }

    for row in range(height): {
        xfer Loops across;
        in reverse direction: {
            knit Loops;
        }
    }

    xfer Back_Loops across;
    bind_offs.chain_bind_off(Front_Loops, reverse, hold = False, extra_knits = 0);
}
