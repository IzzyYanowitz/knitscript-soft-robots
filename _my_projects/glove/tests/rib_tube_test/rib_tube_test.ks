// a test of transitioning from stockenette tube to rib tube without changing gauge

import cast_ons;
import bind_offs;

width = 30;
stk_height = 5;
rib_height = 30;


with Carrier as c1: {
    cast_ons.knit_cast_on(Front_Needles[1 : width + 1], co_dir = Leftward, extra_knits = 2);
    cast_ons.knit_cast_on(Back_Needles[1 : width + 1], co_dir = Rightward, extra_knits = 2);

    // knit stk tube
    for row in range(stk_height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }

    // xfer loops in a weird way
    for i in range(len(Front_Loops)): {
        xfer [Back_Needles, Front_Needles][i % 2][i + 1] 1 to Left;
    }

    // get frontside loops and backside loops
    frontside = [[Back_Loops, Front_Loops][i % 2][i] for i in range(len(Front_Loops))];
    backside = [[Front_Loops, Back_Loops][i % 2][i] for i in range(len(Front_Loops))];
    
    // knit rib tube
    for row in range(rib_height): {
        in reverse direction: {
            knit frontside;
        }
        in reverse direction: {
            knit backside;
        }
    }

    // xfer loops back
    for i in range(len(Front_Loops) - 1, -1, -1): {
        xfer [Back_Needles, Front_Needles][i % 2][i + 1] 1 to Right;
    }

    // knit stk tube
    for row in range(stk_height): {
        in reverse direction: {
            knit Front_Loops;
        }
        in reverse direction: {
            knit Back_Loops;
        }
    }
    // not binding off because I need to figure that out later
}