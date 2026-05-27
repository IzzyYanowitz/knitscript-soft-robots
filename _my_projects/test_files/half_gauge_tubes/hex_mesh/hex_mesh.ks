import cast_ons;
import bind_offs;

fabric_carr = c8;
starting_needle = 350;
width = 30;
height = 70;

def knit_along(needle_set, direct): {
    if direct == Leftward: {
        needle_set = needle_set[::-1];
    }
    
    for needle in needle_set: {
        if needle in Loops: {
            in direct direction: {
                knit needle;
            }
        }

        else: {
            in direct direction: {
                tuck needle;
            }
        }
    }
}

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

                knit_loops = [Back_Loops, Front_Loops][s];
                purl_loops = [Front_Loops, Back_Loops][s];
                knit_needles = [Back_Needles, Front_Needles][s];
                purl_needles = [Front_Needles, Back_Needles][s];

                if (row % 4) == 1: {
                    
                    xfer knit_loops[4 : len(knit_loops) - 1 : 4] 1 to Right;
                    xfer purl_needles[int(starting_needle / 2) : int(starting_needle / 2) + width] across;
                    
                    xfer knit_loops[6 : len(knit_loops) - 1 : 4] 1 to Left;
                    xfer purl_needles[int(starting_needle / 2) : int(starting_needle / 2) + width] across;
                }

                if (row % 4) == 3: {
                    
                    xfer knit_loops[4 : len(knit_loops) - 1 : 4] 1 to Left;
                    xfer purl_needles[int(starting_needle / 2) : int(starting_needle / 2) + width] across;
                    
                    xfer knit_loops[6 : len(knit_loops) - 1 : 4] 1 to Right;
                    xfer purl_needles[int(starting_needle / 2) : int(starting_needle / 2) + width] across;
                }

                knit_along(knit_needles[int(starting_needle / 2) : int(starting_needle / 2) + width], reverse);

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
