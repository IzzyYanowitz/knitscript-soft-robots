// simple stripes
import cast_ons;
import bind_offs;

width = 64;
stripe_number = 16;
stripe_thickness = 4;
carriers = [c5, c8];

with Carrier as carriers[0]: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
}

for stripe in range(stripe_number): {
    xfer Loops across;
    with Carrier as carriers[0]: {
        for row in range(2 * stripe_thickness): {
            in reverse direction: {
            knit Loops;
        }
        }
    }

    with Carrier as carriers[1]: {
        xfer Loops across;
        for row in range(2 * stripe_thickness): {
            in reverse direction: {
            knit Loops;
        }
        }
    }
}

with Carrier as carriers[-1]: {
    bind_offs.chain_bind_off(Loops, Leftward);
}