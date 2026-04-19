import cast_ons;
import bind_offs;

width = 50;
height = 50;

fabric_carr = c1;

with Carrier as fabric_carr: {
    cast_ons.knit_cast_on(Front_Needles[0 : 2 * width : 2], Leftward, extra_knits = 3);

    for row in range(height): {
        if (row % 2) == 0: {
            // decrease
            xfer Front_Loops[0 : width : 2] 1 to Right;
            xfer Back_Loops across;
            xfer Front_Loops[1 : width : 2] 1 to Left;
            in reverse direction: {
                knit Loops;
            }
        }
        elif (row % 2) == 1: {
            // increase
            in reverse direction: {
                split Front_Loops;
            }
            xfer Front_Loops 1 to Right;
            xfer Back_Loops[0:len(Front_Loops):2] across;
            in reverse direction: {
                split Front_Loops;
            }
            xfer Back_Loops 1 to Left;
            
        }
    }
}

