// herringbone teselation showing vertical and diagonal mountain and valley folds

import cast_ons;
import bind_offs;

width_repeats = 3;
height_repeats = 2;
herringbone_size = 8; // is width of first half
width = (2 * width_repeats * (herringbone_size + 1)) - 1;

waste_carr = c2;
fabric_carr = c1;

// waste yarn
cast_ons.backward_loop_with_waste(co_carr = fabric_carr, waste_carr = waste_carr, width = width);

// actual thing

with Carrier as fabric_carr: {
    vert_mountains = [];
    vert_valleys = [];
    non_slip_loops = [];

    for i in range(1, 2 * width_repeats): {
        if (i % 2) == 1: {
            // add mountain
            vert_mountains.append((herringbone_size + 1) * i - 1);
        }
        else: {
            // add valley
            vert_valleys.append((herringbone_size + 1) * i - 1);
        }
        non_slip_loops = non_slip_loops + [j for j in range((i-1) * (herringbone_size + 1), i * (herringbone_size + 1) - 1)];
    }
    non_slip_loops = non_slip_loops + [j for j in range(((2 * width_repeats) - 1) * (herringbone_size + 1), (2 * width_repeats) * (herringbone_size + 1) - 1)];
    

    
    for repeat in range(height_repeats): {
        // straight section

        xfer [Front_Needles[i] for i in vert_valleys] across to Back bed;
        for row in range(herringbone_size): {
            xfer [Front_Needles[i] for i in non_slip_loops] across to Back bed;
            
            in Leftward direction: {
                knit [Back_Needles[i] for i in non_slip_loops];
            }
            
            xfer [Back_Needles[i] for i in non_slip_loops] across to Front bed;
            
            in Rightward direction: {
                knit Loops;
            }
                
        }
        /* xfer Back_Loops across;
        
        // diagonal section
        vert_mountains = vert_mountains + vert_valleys;
        print(vert_mountains);
        for row in range(herringbone_size): {
            // [Front_Needles[2 * (herringbone_size + 1) * i + row] for i in range(0, width_repeats)];
            //  [Front_Needles[(2 * (herringbone_size + 1) * i) - row - 2] for i in range(1, width_repeats + 1)];
            

        } */
    }
    



    xfer Loops across to Front bed;
    bind_offs.chain_bind_off(Front_Loops, reverse, extra_knits = 0);

}