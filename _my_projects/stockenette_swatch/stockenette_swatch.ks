// this is a simple stockinette stitch swatch

width = 10;
height = 10;

// carrier is the thing that moves the yarn along
// this is just saying use the first carrier for everything we do in this pattern
with Carrier as c1: {
    // this means do this next block of code moving from right to left
    in Leftward direction: {
        tuck Front_Needles[0:width:2];
        // casts on every other needle for the width of the piece
        // every other needle just makes a more stable piece
    }

    in reverse direction: {
        // turns around (carrier traveling left to right) and does the following code
        tuck Front_Needles[1:width:2];
        // casts on to the loops we missed in the left pass
    }
    for _ in range(height): {
        // does the following row for as many rows as you wanted
        in reverse direction: {
            // turns around and does the following code
            knit Loops;
            // Loops are only needles with already cast on loops
            // needles are the needles themselves
        }
    }
}

