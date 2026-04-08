//I don't know what to call this
//just read the code and figure it out

import cast_ons;
import bind_offs;

width = 30;
section_height = 20;

with Carrier as c4: {
    cast_ons.knit_cast_on(Front_Needles[:2 * width:2], Leftward, extra_knits = 0, outhook = False);
    cast_ons.knit_cast_on(Back_Needles[1:2 * width:2], Rightward, extra_knits = 0, outhook = False);

    // knit section
    for row in range(section_height): {
        for needle_set in [Front_Loops, Back_Loops]: {
            in reverse direction: {
                knit needle_set;
            }
        }
    }
    releasehook;
    // double_thick section
    for row in range(section_height): {
        for needle_set in [Front_Loops, Back_Loops]: {
            in reverse direction: {
                tuck needle_set;
            }
        }
        for needle_set in [Front_Loops, Back_Loops]: {
            in reverse direction: {
                knit needle_set;
            }
        }
    }

}

with Carrier as c4, Gauge as 2: {
    // rib section
    
    for s in range(2): {
        with Sheet as s: {
            xfer Loops[::2] across;
        }
        
    }

    for row in range(section_height): {
        for s in range(2): {
            with Sheet as s: {
                in reverse direction: {
                    knit Loops;
                }
            }
            
        }
    }

    // double thick rib
    for row in range(section_height): {
        for s in range(2): {
            with Sheet as s: {
                in reverse direction: {
                    split Loops;
                }
                xfer Back_Loops across;
                xfer Loops[::2] across;
            }
        }

        for s in range(2): {
            with Sheet as s: {
                in reverse direction: {
                    knit Loops;
                }
            }
        }
    }

    // bind_off

    for s in range(2): {
        with Sheet as s: {
            xfer Loops[::2] across;
        }    
    }

    // move piece over
    with Sheet as s0: {
        
        in Rightward direction: {
            tuck Front_Needles[width : 2 * width];
        }
        
        in Leftward direction: {
            tuck Front_Needles[width : 2 * width];
        }
        
        drop Front_Needles[width : 2 * width];
    }

    with Sheet as s0: {
        bind_offs.chain_bind_off(Loops, Leftward, hold = False);
    }
    with Sheet as s1: {
        bind_offs.chain_bind_off(Loops, Rightward, hold = False);
    }
    
    
}

