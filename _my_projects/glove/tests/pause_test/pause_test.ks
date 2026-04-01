import cast_ons;
import bind_offs;

width = 30;
height = 30;

with Carrier as c1: {
    cast_ons.knit_cast_on(Front_Needles[0 : width]);
    for row in range(height): {
        if row == int(width / 2): {
            pause;
        }
        in reverse direction: {
            knit Loops;
        }
    }

    bind_offs.chain_bind_off(Loops, Leftward, extra_knits = 0, hold = True);
}