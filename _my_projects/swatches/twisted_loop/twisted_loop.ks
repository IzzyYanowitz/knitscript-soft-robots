// I have no idea why you'd ever want to do this, but here it is.

import cast_ons;
import bind_offs;

width = 20;
height = 20;

carr = 1;

with Carrier as carr: {
    // move over
    in Leftward direction: {
        tuck Front_Needles[width : width + 20 : 2];
    }
    drop Loops;

    cast_ons.knit_cast_on(Front_Needles[ : width], extra_knits = 1);

    for row in range(height): {
        miss_direct = [Leftward, Rightward][row % 2];
        knit_direct = [Rightward, Leftward][row % 2];
        knit_loops = Front_Loops;
        
        if miss_direct == Leftward: {
            knit_loops = knit_loops[::-1];
        }
        
        for needle in knit_loops: {
            in miss_direct direction: {
                miss needle;
            }
            
            in knit_direct direction: {
                knit needle;
            }
            
            in miss_direct direction: {
                miss needle;
            }
        }
    }

    bind_offs.chain_bind_off(Front_Loops, reverse);
}