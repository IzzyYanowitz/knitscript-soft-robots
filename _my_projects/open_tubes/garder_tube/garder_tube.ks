import cast_ons;
import bind_offs;
// This program uses sheets, which is slightly ineffecient
// because of the specific pattern, needles end up getting xfered twice in a row
// I could fix this, but I won't because I wrote this program to understand the language
// not to make this since it doesn't even have a bind off

width = 40;
height = 40;

with Gauge as 2, Carrier as c1: {
    with Sheet as s0: {
        cast_ons.alt_tuck_cast_on(width, is_front = True);
    }

    with Sheet as s1: {
        cast_ons.alt_tuck_cast_on(width, is_front = False);
        // the back sheet is cast on in the back because the back of this sheet is the outside but the front of sheet 1 is the outside
    }
    // casts on every other shift in the front and calls those sheet 1. 
    // when i switch between sheets, all the loops i'm no longer using get xfered out of the way
    // sheets also act like a loop scope. inside a with sheet block you can only see the loops in that sheet
    
    for row in range(height): {
        with Sheet as s0: {
            in reverse direction: {
                knit Loops;
            }
            xfer Loops across;
        }

        with Sheet as s1: {
            in reverse direction: {
                knit Loops;
            }
            xfer Loops across;
        }
    }

    with Sheet as s0: {
        bind_offs.chain_bind_off(Loops, Leftward);
    }

    with Sheet as s1: {
        bind_offs.chain_bind_off(Loops, Leftward);
    }
}