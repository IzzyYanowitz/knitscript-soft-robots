// simple lace, alternates left eylet, knit, right eylet, knit

import cast_ons;
import bind_offs;
import lace_stitches;


width = 50;
height = 50;
eyelet_spacing = 5; // knit stiches inbetween eyelet tucks

with Carrier as c1: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);

    for row in range(height): {
        if row % 4 == 0: {
            // left eyelet
            tuck_needles = [n for n in Front_Loops[eyelet_spacing - 1 : 0 - eyelet_spacing : eyelet_spacing]];
            xfer tuck_needles across to Back bed;
            xfer Back_Loops 1 to Left;
            lace_stitches.knit_across(width, Leftward);
            
        }
        elif row % 4 == 2: {
            // right eyelet
            tuck_needles = [n for n in Front_Loops[eyelet_spacing - 1: 0 - eyelet_spacing: eyelet_spacing]];
            xfer tuck_needles across to Back bed;
            xfer Back_Loops 1 to Right;
            lace_stitches.knit_across(width, Leftward);
            
        }
        else: {
            
            xfer Loops across to Back bed;
            
            in Rightward direction: {
                knit Loops;
            }

            xfer Loops across to Front bed;
        }


    }
    bind_offs.chain_bind_off(Loops, Leftward);
}

/*
brief explination of left eyelet (right eyelet is same but reversed)

-: knitted loop
=: double loop
|: empty needle
~: tucked needle
top row is back bed
bottom row is front bed

state 0:
| | | | |
- - - - -

state 1: xfer Loops[2] across to Back bed;
| | - | |
- - | - -

state 2: xfer Back_Loops[2] 1 to Left;
| | | | |
- = | - -

state 3: tuck Loops[2];
| | | | |
- = ~ - -

state 4: knit Loops;
| | | | |
- - - - -
overall effect is a decrease and an increase that cancel out so you get a gap in the fabric
*/

