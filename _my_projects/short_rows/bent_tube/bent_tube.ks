import cast_ons;

width = 30;
height = 30;

fabric_carr = c1;

with Carrier as fabric_carr: {

    cast_ons.knit_cast_on(Front_Needles[0 : width], Leftward);
    cast_ons.knit_cast_on(Back_Needles[0 : width], Leftward);

    for row in range(height): {
        in Leftward direction: {
            knit Front_Loops;
        }
        in Rightward direction: {
            knit Back_Loops;
        }
        if row == int(height / 2): {
            // short rows for bending
            for row in range(1, width - 1): {
                in Leftward direction: {
                    knit Front_Loops[row : width];
                }
                in Rightward direction: {
                    knit Front_Loops[row: width];
                }
                in Leftward direction: {
                    knit Back_Loops[row : width];
                }
                in Rightward direction: {
                    knit Back_Loops [row: width];
                }
            }
        }
    }
}