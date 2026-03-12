// this is an implementation of the oriel lace by shirley paden
// I found it on knitting daily

import cast_ons;
import bind_offs;
import lace_stitches;


width_pattern_repeats = 3;
height_pattern_repeats = 2;

width = 12 * width_pattern_repeats + 1;
height = 28 * height_pattern_repeats;

def knit_across(width, direction_is): {
    // for each needle station it tries to knit front, then back, then tuck
    // only runs inside width

    for needle_index in range(width - 1, -1, -1): {

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

def prepare_center_lace(ktog_indices, ssk_indices, purl_indices, shift_dist): {
    // used in rows 7-19
    // this has the lace stitches in the center then yarn overs moved out
    xfer Back_Loops across to Front bed;

    lace_stitches.right_eyelet(ktog_indices, knit_rows_after = 0, do_tuck = False);
    lace_stitches.slip_slip_knit(ssk_indices, knit_rows_after = 0, do_tuck = False);

    left_shift_loops = [];
    right_shift_loops = [];
    purl_needles = [];
    
    for j in range(width_pattern_repeats): {

        left_shift_loops = left_shift_loops + Front_Needles[(12 * j) + 8: (12 * j) + 8 + shift_dist];
        right_shift_loops = right_shift_loops + Front_Needles[(12 * j) + 5 - shift_dist: (12 * j) + 5];
        for k in purl_indices: {
            purl_needles.append(Front_Needles[12 * j + k]);
        }
    }
    purl_needles.append(Front_Needles[width - 1]);

    xfer left_shift_loops 1 to Left;
    xfer right_shift_loops 1 to Right;

    xfer Back_Loops across to Front bed;
    xfer purl_needles across to Back bed;
    xfer [Front_Needles[i-1] for i in ssk_indices] across to Back bed;


}

def prepare_outside_lace(ktog_indices, ssk_indices, shift_dist): {
    // used for rows 1-6 and 21-27
    // this has the lace stitches on the outside then yarn overs moved to center
    // set up needle groups
    left_shift_loops = []; 
    right_shift_loops = [];
    purl_needles = [];
    
    for j in range(width_pattern_repeats): {
        // i used j here because this used to be inside the loop below
        // I could change it but i cannot be fucked at this juncture
        left_shift_loops = left_shift_loops + Front_Needles[2 + (12 * j) : 2 + shift_dist + (12 * j)];
        right_shift_loops = right_shift_loops + Front_Needles[(12 * j) + 11 - shift_dist  : (12 * j) + 11];

        purl_needles.append(Front_Needles[12 * j]);
        for stitch in range(shift_dist + 2, 11 - shift_dist): {
            purl_needles.append(Front_Needles[(12 * j) + stitch]);
        }
        
    }
    purl_needles.append(Front_Needles[width - 1]);

    xfer Back_Loops across to Front bed;
    
    // row 1
    
    
    lace_stitches.right_eyelet(ktog_indices, knit_rows_after = 0, do_tuck = False);
    lace_stitches.slip_slip_knit(ssk_indices, knit_rows_after = 0, do_tuck = False);
    
    xfer Back_Loops across to Front bed; // moves the ssk double loops to front temporarily
    
    xfer left_shift_loops 1 to Left;
    xfer right_shift_loops 1 to Right;
    
    xfer Back_Loops across to Front bed;
    xfer [Front_Needles[i-1] for i in ssk_indices] across to Back bed; // moves ssk double loops to back

    xfer purl_needles across to Back bed;
    
    knit_across(width, Leftward);

    xfer [Back_Needles[i-1] for i in ssk_indices] across to Front bed; // moves ssk loops to front

    // row 2

    in reverse direction: {
        knit Loops;
    }
}

with Carrier as c1: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
    

    for row in range(height_pattern_repeats): {
        // do lace stitches, set up purls, knit across, bring all to front
        
        // row 1 - 6

        ktog_indices = [i + 1 for i in range(0, width, 12)];
        ssk_indices = [i + 10 for i in range(0, width, 12)];
        for i in range(3): {
            prepare_outside_lace(ktog_indices, ssk_indices, 4);
        }

        // rows 7 - 14
        
        // these indices stay the same until row 21.
        ktog_indices = [(12 * i) + 7 for i in range(width_pattern_repeats)];
        ssk_indices = [(12 * i) + 5 for i in range(width_pattern_repeats)];
        for i in range(4): {
            // row 7

            shift = 4 - i;
            purls = [j for j in range(i + 1)] + [6] + [11 - j for j in range(i)];
            
            prepare_center_lace(ktog_indices, ssk_indices, purl_indices = purls, shift_dist = shift);
            knit_across(width, Leftward);

            // row 8
            xfer [Back_Needles[i-1] for i in ssk_indices] across to Front bed;
            in reverse direction: {
                knit Loops;
            }
        }
        
        // rows 15 - 20
        for i in range(3): {
            // row 15
            prepare_center_lace(ktog_indices, ssk_indices, purl_indices = [0, 6], shift_dist = 4);
            knit_across(width, Leftward);

            // row 16
            xfer [Back_Needles[i-1] for i in ssk_indices] across to Front bed;
            in reverse direction: {
                knit Loops;
            }
        }

        // rows 21-27
        ktog_indices = [i + 1 for i in range(0, width, 12)];
        ssk_indices = [i + 11 for i in range(0, width, 12)];
        for row in range(4): {
            prepare_outside_lace(ktog_indices, ssk_indices, shift_dist = 4 - row);
        }
    }
    xfer Back_Loops across to Front bed;
    bind_offs.chain_bind_off(Loops, Leftward);
}