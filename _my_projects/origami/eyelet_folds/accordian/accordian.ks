import cast_ons;
import bind_offs;

def knit_across(width, direction_is): {
    // for each needle station it tries to knit front, then back, then tuck
    // only runs inside width
    
    needle_indices = [i for i in range(width)];
    
    if direction_is == Leftward: {
        needle_indices = needle_indices[ : : -1];
    }
    
    for needle_index in needle_indices: {

            if Front_Needles[needle_index] in Loops: {
                in direction_is direction: {
                    knit Front_Needles[needle_index];
                }
                
            }

            elif Back_Needles[needle_index] in Loops: {
                in direction_is direction: {
                    knit Back_Needles[needle_index];
                }
            }

            else: {
                in direction_is direction: {
                    tuck Front_Needles[needle_index];
                }
            }
        }

}

size = 5;
width_repeats = 3;
width = (2 * (size + 1) * width_repeats) + size;
height = width;

fabric_carr = c1;

with Carrier as fabric_carr: {
    
    in Leftward direction: {
        tuck Front_Needles[width : width + 30 : 2];
    }
    drop Front_Needles[width: width + 30 : 2];

    cast_ons.knit_cast_on(Front_Needles[0 : width], Leftward, extra_knits = 3);

    // set up lists containing the index of the needles we want to garder stich, mountain fold, and valley fold
    garder_loops = [];
    mountain_loops = [];
    valley_loops = [];
    
    for i in range(2 * width_repeats): {
        garder_loops = garder_loops + [(size + 1) * i + j for j in range(0, size)];
        
        if (i % 2 == 0): {
            mountain_loops.append((size + 1) * i + size);
        }
        
        else: {
            valley_loops.append((size + 1) * i + size);
        }
        
    }
    garder_loops = garder_loops + [i for i in range((2 * (size + 1) * width_repeats), (2 * (size + 1) * width_repeats) + size)];
    
    xfer [Front_Needles[i] for i in valley_loops] across; // move valley fold loops
    
    for row in range(height): {
        
        if (row % 2) == 0: {

            // set up double decrease
            // garder loops on front

            // valley double decrease
            xfer [Front_Needles[i - 1] for i in valley_loops] 1 to Right;
            xfer [Front_Needles[i + 1] for i in valley_loops] 1 to Left;

            // mountain double decrease
            xfer [Front_Needles[i - 1] for i in mountain_loops] 1 to Right;
            xfer [Front_Needles[i + 1] for i in mountain_loops] 1 to Left;
            xfer [Back_Needles[i] for i in mountain_loops] across;

            knit_across(width, Leftward);

            xfer [Front_Needles[i] for i in garder_loops] across;

            // need to split the mountain and valley needles so we can use them later so this part gets gross
            // but it is really just a return knitting pass

            for repeat in range(width_repeats): {
                
                // garder section
                in Rightward direction: {
                    knit Back_Needles[(2 * (size + 1) * repeat) : (2 * (size + 1) * repeat) + size];
                }

                // mountain fold
                in Rightward direction: {
                    split Front_Needles[(2 * (size + 1) * repeat) + size];
                }

                // garder section
                in Rightward direction: {
                    knit Back_Needles[(2 * (size + 1) * repeat) + size + 1 : (2 * (size + 1) * repeat) + (2 * size) + 1];
                }

                // valley fold
                in Rightward direction: {
                    split Back_Needles[(2 * (size + 1) * repeat) + (2 * size) + 1];
                }

            }
            

            // now you need to deal with that last little bit on the right
                in Rightward direction: {
                    knit Back_Loops[(2 * (size + 1) * width_repeats) : width];
                }
                
                xfer [Back_Needles[i] for i in garder_loops] across;
        }
        
        else: {
            // set up knit below
            // loops on front

            // move split loops onto the fold loops
            xfer [Back_Needles[i] for i in mountain_loops] across;
            xfer [Front_Needles[i] for i in valley_loops] across;


            // i do this weird thing to make sure everything is in the right order

            // right leaning decreases to left of folds
            xfer [Front_Needles[i - 2] for i in mountain_loops] across;
            xfer [Front_Needles[i - 2] for i in valley_loops] across;

            xfer [Front_Needles[i - 1] for i in mountain_loops] 1 to Left;
            xfer [Front_Needles[i - 1] for i in valley_loops] 1 to Left;

            xfer [Back_Needles[i - 2] for i in mountain_loops] across;
            xfer [Back_Needles[i - 2] for i in valley_loops] across;

            // left leaning decreases to right of folds
            xfer [Front_Needles[i + 2] for i in mountain_loops] across;
            xfer [Front_Needles[i + 2] for i in valley_loops] across;

            xfer [Front_Needles[i + 1] for i in mountain_loops] 1 to Right;
            xfer [Front_Needles[i + 1] for i in valley_loops] 1 to Right;

            xfer [Back_Needles[i + 2] for i in mountain_loops] across;
            xfer [Back_Needles[i + 2] for i in valley_loops] across;

            knit_across(width, Leftward);

            // rightward pass
            // no need to split this time so its easy
            xfer [Front_Needles[i] for i in garder_loops] across;
            knit_across(width, Rightward);

            // xfer garder loops one last time to return to orginal state
            xfer [Back_Needles[i] for i in garder_loops] across;
        }

    }

    xfer Back_Loops across; // bring all loops to front for bind off;
    bind_offs.chain_bind_off(Front_Loops, reverse, hold = False, extra_knits = 0);
    
}