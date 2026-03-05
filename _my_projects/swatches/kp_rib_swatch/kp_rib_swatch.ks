import cast_ons;

width = 5;
height = 5;

with Carrier as c1: {
    
        cast_ons.alt_tuck_cast_on(width, is_front = True);
        xfer Loops[0:width:2] across;

    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
    }
    
}