// mostly garder with a hinge of knits

import cast_ons;
import bind_offs;

width = 30;
height = 30;
crease_height = 3;

fabric_carr = c1;

with Carrier as fabric_carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);

    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
        needles_set = [Front_Needles, Back_Needles][row % 2];
        xfer needles_set[0 : int((width - crease_height) / 2)] across;
        xfer needles_set[int((width + crease_height) / 2) : width] across;
    }

    xfer Back_Loops across;
    bind_offs.chain_bind_off(Front_Loops, reverse);
}