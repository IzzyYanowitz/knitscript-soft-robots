// this is a test of the gauge of a stk tube.

import cast_ons;

width = 25;
height = 25;

carr = c1;

with Carrier as carr: {
    // cast on front and back. I don't release and don't knit extra because I want an accurate account of the number of rows
    cast_ons.alt_tuck_cast_on(width, is_front = True, tuck_lines = 1, knit_lines = 0, release = False);
    cast_ons.alt_tuck_cast_on(width, is_front = False, tuck_lines = 1, knit_lines = 0, release = False);

    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }

    // i didn't bind off for more percise gauging
}