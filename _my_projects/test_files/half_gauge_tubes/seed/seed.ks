import cast_ons;
import bind_offs;

fabric_carr = c8;
starting_needle = 350;
width = 30;
height = 70;

with Carrier as fabric_carr: {
    co_needles = [];

    for i in range(width): {
        co_needles.append(Back_Needles[2 * i + starting_needle]);
        co_needles.append(Front_Needles[2 * i + starting_needle + 1]);
        
    }

    cast_ons.knit_cast_on(co_needles, Leftward, extra_knits = 0, outhook = False);
    
    in Rightward direction: {
        knit Back_Loops;
    }

    for i in range(2): {
        
        in Leftward direction: {
            knit Front_Loops;
        }
        
        in Rightward direction: {
            knit Back_Loops;
        }
    }

    releasehook;
}

with Gauge as 2, Carrier as fabric_carr: {

    for s in range(2): {
        with Sheet as s: {
            rib_loops = Loops[0 : : 4] + Loops[1 : : 4];
            xfer rib_loops across;
        }
    }
    
    for row in range(height): {
        for s in range(2): {
            with Sheet as s: {
                
                xfer Loops across;
                
                in reverse direction: {
                    knit Loops;
                }
            }
        }
    }

    for s in range(2): {
        with Sheet as s: {
            xfer Loops across to Front bed;
            bind_offs.chain_bind_off(Loops, [Leftward, Rightward][s], hold = False, extra_knits = 0);
        }
    }
}
