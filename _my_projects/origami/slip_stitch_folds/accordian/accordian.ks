import cast_ons;

size = 5;
width_repeats = 3;
width = 2 * (size + 1) * width_repeats;
height = width;

fabric_carr = c1;

with Carrier as fabric_carr: {
    
    cast_ons.knit_cast_on(Front_Needles[0 : width], Leftward, extra_knits = 1);

    garder_loops = [];
    
    for i in range(2 * width_repeats): {
        garder_loops = garder_loops + [(size + 1) * i + j for j in range(0, size)];
    }
    
    xfer Front_Needles[(2 * size) + 1 : width : 2 * (size + 1)] across; // move valley fold loops
    
    for row in range(height): {
        
        xfer [Front_Needles[i] for i in garder_loops] across;
        
        in Leftward direction: {
            knit Back_Loops;
        }
        
        xfer [Back_Needles[i] for i in garder_loops] across;
        
        in Rightward direction: {
            knit Front_Loops;
        }

    }

    xfer Back_Loops across; // bring all loops to front for bind off;



    // bind off
    // I didn't use chain bind off method because I don't trust it right now...
    
    xfer_dir = Right;
    bo_needles = Front_Loops;
    bo_dir = reverse;
    
    if bo_dir == Leftward: {
        xfer_dir = Left;
        bo_needles = bo_needles[ : : -1];
    }
    
    for i, needle in enumerate(bo_needles): {
        
        // get index of the needle across from the one we are binding off
        acr = i;
        if (bo_dir == Leftward): {
            acr = len(bo_needles) - 1 - i;
        }

        // bring stitch from previous bind off onto current needle
        xfer Back_Needles[acr] across;
        
        // knit those two loops together
        in bo_dir direction: {
            knit needle;
        }

        // split the loop so the back bed can hold onto the piece
        in bo_dir direction: {
            split needle;
        }

        // move new loop over so it can be knit together with the next bind off needle

        if (i != (len(bo_needles) - 1)): {
            xfer needle 1 to xfer_dir;
        }

    }
}