import cast_ons;
width = 20;
height = 30;

with Carrier as c1: {
    cast_ons.knit_cast_on(Front_Needles[ : width]);
    for row in range(height): {
        in reverse direction: {
            knit Loops;
        }
    }

    // bind off

    cast_ons.knit_cast_on(Front_Needles[width : width + 3], co_dir = Rightward, extra_knits = 0);

    while len(Loops) > 3: {
        xfer Loops[-3 : len(Loops)] 1 to Left;
        xfer Back_Loops across;
        
        in Leftward direction: {
            knit Loops[-3 : len(Loops)];
        }
    }

    // now we just have 3 stitches left. We can chain bind off them

    for _ in range(2): {
        
        xfer Loops[-1] 1 to Left;
        xfer Back_Loops across;
        in Leftward direction: {
            knit Loops[-1];
        }
    }

    
    
    
    
    
    
}