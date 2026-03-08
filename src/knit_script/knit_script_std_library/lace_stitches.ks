// these are some common lace stitches
// for more info on my diagrams, email me at iyanowitz@wesleayn.edu

/*
left eyelet
this is roughly equivalent to a yarn over followed by SKP

state 0:
| | | | |
- - - - -

state 1: transfer stitch across
| | - | |
- - | - -

state 2: transfer stitch 1 to left
| | | | |
- = | - -

state 3: tuck empty needle
| | | | |
- = ~ - -

state 4: knit Loops
| | | | |
- - - - -

*/

def left_eyelet(tuck_needles_index, knit_rows_after = 0, do_tuck = True): {
    // requires empty back bed
    
    tuck_needles = [Loops[i] for i in tuck_needles_index];
    
    xfer tuck_needles across;
    xfer Back_Loops 1 to Left;
    
    if do_tuck: {
        in reverse direction: {
            tuck tuck_needles;
        }
    }

    for row in range(knit_rows_after): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

}

/*
right eyelet
this is roughly equivalent to a K2TOG before a yarn over

state 0:
| | | | |
- - - - -

state 1: transfer stitch across
| | - | |
- - | - -

state 2: transfer stitch 1 to left
| | | | |
- - | = -

state 3: tuck empty needle
| | | | |
- - ~ = -

state 4: knit Loops
| | | | |
- - - - -

*/

def right_eyelet(tuck_needles_index, knit_rows_after = 0, do_tuck = True): {
    // requires empty back bed
    
    tuck_needles = [Loops[i] for i in tuck_needles_index];
    
    xfer tuck_needles across;
    xfer Back_Loops 1 to Right;
    
    if do_tuck: {
        in reverse direction: {
            tuck tuck_needles;
        }
    }

    for row in range(knit_rows_after): {
        in reverse direction: {
            knit Front_Loops;
        }
    }
}

/*
slip slip knit
this is equivalent to a SSK
it is very similar to a SKP, but the double stitch is knit on the back bed
that seems backwards because I think the P stands for purl, but it seems to be right
I don't really know what's up with that

state 0:
| | | | |
- - - - -

state 1: transfer tuck_needle 1 to Left
| - | | |
- - | - -

state 2: transfer loop to back
| = | | |
- | | - -

state 3: tuck tuck_needle
| = | | |
- | ~ - -

state 4: knit Loops
| - | | |
- | - - -

state 5: transer back loops
| | | | |
- - - - -
*/

def slip_slip_knit(tuck_needles_index, knit_rows_after = 1, do_tuck = True): {
    // requires empty back bed
    // knit_rows_after must be at least 1
    
    tuck_loops = [Loops[i] for i in tuck_needles_index];
    next_to = [Loops[i - 1] for i in tuck_needles_index];
    
    xfer tuck_loops 1 to Left;
    xfer next_to across;
    if do_tuck: {
        in reverse direction: {
            tuck tuck_loops;
        }
    }
    
    
    in reverse direction: {
        knit Loops; // you need to knit the back loops
    }

    xfer Back_Loops across;

    for row in range(knit_rows_after - 1): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

}

/*
knit three together
this is equivalent to the K3TOG
for purposes of the visualization, i have included a double yarn over after
this can be toggled in the 

state 0:
| | | | |
- - - - -

state 1: transfer Front_Loops[2] 1 right
| | | - |
- - | - -

state 2: transfer Back_Loops[1] to front
| | | | |
- - | = -

state 3: transfer Front_Loops[3] 2 right 
(i did it in this order because I'm not sure how the machine will handle transfering two loops at once)
| | | - |
- | | = -

state 4: transfer Back_Loops[2] across
| | | | |
- | | 3 -

state 5: tuck Front_Loops[2, 3]
| | | | |
- ~ ~ 3 -

state 6: knit Loops
| | | | |
- - - - -
*/

def knit_3_together(tuck_needles_index, knit_rows_after = 0, do_tuck = True): {
    // requires empty back bed

    left_tuck_needles = [Loops[i - 1] for i in tuck_needles_index];
    right_tuck_needles = [Loops[i] for i in tuck_needles_index];    

   
    xfer right_tuck_needles 1 to Right;
    xfer Back_Loops across to Front bed;
    
    xfer left_tuck_needles 2 to Right;
    xfer Back_Loops across to Front bed;

    
    if do_tuck: {
        // have to do two passes so there aren't two tucks in a row
        in reverse direction: {
            tuck left_tuck_needles;
        }

        in reverse direction: {
            tuck right_tuck_needles;
        }
    }
    
    for row in range(knit_rows_after): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

}

/* 
this is the slip, knit 2, pull
it is equivalent to the SK2P
it is K3TOG backwards I think?

state 0:
| | | | |
- - - - -


state 1: transfer Loops[2] 1 left
| - | | |
- - | - -

state 2: transfer Back_Loops front
| | | | |
- = | - -

state 3: transfer Loops[3] 2 left
| - | | |
- = | | -

state 4: transfer Loops[3] across
| | | | |
- 3 | | -

state 5: tuck Loops[2, 3]
| | | | |
- 3 ~ ~ -

state 6: knit Loops
| | | | |
- - - - -
*/

def slip_knit_2_together(tuck_needles_index, knit_rows_after = 0, do_tuck = True): {
    // requires empty back bed

    left_tuck_needles = [Loops[i] for i in tuck_needles_index];
    right_tuck_needles = [Loops[i + 1] for i in tuck_needles_index];

    
    xfer left_tuck_needles 1 to Left;
    xfer Back_Loops across to Front bed;

    xfer right_tuck_needles 2 to Left;
    xfer Back_Loops across to Front bed;
    

    if do_tuck: {
        // have to do two passes so there aren't two tucks in a row
        in reverse direction: {
            tuck left_tuck_needles;
        }

        in reverse direction: {
            tuck right_tuck_needles;
        }
    }
    
    for row in range(knit_rows_after): {
        in reverse direction: {
            knit Front_Loops;
        }
    }
}

/*
I don't know what this is called
it creates 2 adjacent eyelets
two_eyelets it is?
state 0:
| | | | |
- - - - -

state 1: transfer Loops[1] 1 Right
| | - | |
- | - - -

state 2: transfer Back_Loops across
| | | | |
- | = - -

state 3: transfer Loops[3] 1 Left
| | - | |
- | = | -

state 4: transfer Back_Loops across
| | | | |
- | 3 | -

state 5: tuck Loops[1, 3]
| | | | |
- ~ 3 ~ -

state 6: knit Loops
| | | | |
- - - - -
*/

def two_eyelets(tuck_needles_index, knit_rows_after = 1, do_tuck = True): {
    // requires empty back bed

    left_tuck_needles = [Loops[i] for i in tuck_needles_index];
    right_tuck_needles = [Loops[i + 2] for i in tuck_needles_index];
    tuck_needles = left_tuck_needles + right_tuck_needles;

    xfer left_tuck_needles 1 to Right;
    xfer Back_Loops across;

    xfer right_tuck_needles 1 to Left;
    xfer Back_Loops across;

    if do_tuck: {
        in reverse direction: {
            tuck tuck_needles;
        }
    }

    for row in range(knit_rows_after): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

}