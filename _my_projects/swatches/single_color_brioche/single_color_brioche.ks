/*

State 1:
| = | = | =
- | - | - |

State 2: knit back loops while tucking front needles
| - | - | -
= | = | = |

State 3: knit front loops while tucking back needles
| = | = | =
- | - | - |

*/



import cast_ons;
import bind_offs;

width = 50;
height = 50;
carr = c4;




def brioche_knit(knit_loops, tuck_needles, direct): {
    
    // flip order of knit_loops and tuck_needles if going leftward
    if direct == Leftward: {
        knit_loops = knit_loops[ : : -1];
        tuck_needles = tuck_needles[ : : -1];
    }


    for needle_index in range(len(knit_loops)): {
        in direct direction: {
            knit knit_loops[needle_index];
            tuck tuck_needles[needle_index];
        }
    }
}


with Carrier as carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
    xfer Front_Loops[1 : : 2] 1 to Left; // sets up ribbing
    // it is important to have the two beds ontop of each other so to speak because of the way brioche knitting works

    for row in range(height): {
        if row % 2 == 0: {
            brioche_knit(knit_loops = Front_Loops, tuck_needles = Back_Loops, direct= Leftward);
        }
        else: {
            brioche_knit(knit_loops = Back_Loops, tuck_needles = Front_Loops, direct = Rightward);
        }
    }

    xfer Back_Loops 1 to Right; // re-interlace back and front loops
    bind_offs.chain_bind_off(Loops, [Leftward, Rightward][height % 2]);

}
