import cast_ons;
import bind_offs;

fabric_carr = c8;
starting_needle = 350;
width = 30;
height = 70;
cable_width = 2;

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
    
    for row in range(height): {
        for s in range(2): {
            with Sheet as s: {
                
                xfer Loops across;

                knit_loops = [Back_Loops, Front_Loops][s];
                purl_loops = [Front_Loops, Back_Loops][s];
                knit_needles = [Back_Needles, Front_Needles][s];
                purl_needles = [Front_Needles, Back_Needles][s];
                
                if (row % 2 == 1): {
                    xfer purl_loops across;
                }
                

                if (row % 2 == 0): {
                    xfer knit_loops across;
                    xfer purl_needles[int(starting_needle / 2) + int(width / 2) - cable_width : int(starting_needle / 2) + int(width / 2)] cable_width to Right;
                    xfer purl_needles[int(starting_needle / 2) + int(width / 2) : int(starting_needle / 2) + int(width / 2) + cable_width] cable_width to Left;
                }
                

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
