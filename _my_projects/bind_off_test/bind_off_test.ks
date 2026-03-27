import cast_ons;
import bind_offs;
print(bind_offs);

width = 30;
height = 30;

carr = c1;

with Carrier as carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);

    // knit something random
    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
    }

    // cast off
    bind_offs.chain_bind_off(Loops, Leftward, hold = False);

}