import cast_ons;
import bind_offs;

width = 40;
height = 40;

with Carrier as c1: {
    cast_ons.alt_tuck_cast_on(width, is_front = True); // cast on front needles
    cast_ons.alt_tuck_cast_on(width, is_front = False); // cast on back needles

    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }
    bind_offs.chain_bind_off(Front_Loops, Leftward, hold = True);
    bind_offs.chain_bind_off(Back_Loops, Leftward, hold = True);
}