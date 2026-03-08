// simple stockenette diamond

import cast_ons;

starting_width = 2;
half_height = 20;

with Carrier as c1: {
    cast_ons.alt_tuck_cast_on(starting_width, is_front = True, first_needle = half_height); // you have to start in the middle so you have space to inc to left
    print Loops;
    
    // increase for half_height
    for row in range(half_height): {
        tuck_needles = [Loops[0], Loops[-1]]; // find ends of piece
        
        // move ends out
        xfer tuck_needles[0] 1 to Left;
        xfer tuck_needles[1] 1 to Right;
        xfer Back_Loops across;

        in reverse direction: {
            knit Loops;
            tuck tuck_needles;
        }

        print Loops;

    }

    // decrease for half_height
    for row in range(half_height): {
        dec_needles = [Loops[0], Loops[-1]];

        // moves ends in and then knits them with their neighbors
        xfer dec_needles[0] 1 to Right;
        xfer dec_needles[1] 1 to Left;
        xfer Back_Loops across;

        in reverse direction: {
            knit Loops;
        }
        print Loops;
    }
}

/*
increase:

state 0:
| | | | |
| † † † |

state 1: xfer Loops[0] 1 to Left;
† | | | |
| | † † †

state 2: xfer Loops[-1] 1 t Right;
† | | | †
| | † | |

state 3: xfer Back_Loops across;
| | | | |
† | † | †

state 4: tuck Loops[1, 3];
| | | | |
† † † † †


decrease:

state 0:
| | | | |
† † † † †

state 1: xfer Loops[0] 1 to Right;
| † | | |
| † † † †

state 2: xfer Loops[-1] 1 to Left;
| † | † |
| † † † |

state 3: xfer Back_Loops across;
| | | | |
| ‡ † ‡ |

state 4: knit Loops;
| | | | |
| † † † |
*/

