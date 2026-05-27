// mostly garder with a hinge of knits

import cast_ons;
import bind_offs;

width = 30;
height = 30;
crease_height = 3;

fabric_carr = c1;

with Carrier as fabric_carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);

    for row in range(int(height / 2)): {
        in reverse direction: {
            knit Loops;
        }
        xfer Loops across;
    }
    xfer Back_Loops across;

    for row in range(crease_height): {
        in reverse direction: {
            knit Loops;
        }
    }

    for row in range(int(height / 2)): {
        in reverse direction: {
            knit Loops;
        }
        xfer Loops across;
    }

    xfer Back_Loops across;
    bind_offs.chain_bind_off(Front_Loops, reverse);
}