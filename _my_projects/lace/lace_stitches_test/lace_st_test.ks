import cast_ons;
import lace_stitches;
import bind_offs;

width = 76;
buffer_height = 5; // this should be odd to cancel out the weird tuck rounds in the lace stitches
lace_gap = 5;

with Carrier as c1: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
    
    tuck_index = [i for i in range(width)][lace_gap : 0 - lace_gap : lace_gap];
    
    for row in range(buffer_height + 1): {
        // + 1 aligns cast offs at end
        in reverse direction: {
            knit Loops;
        }
        
    }

    lace_stitches.left_eyelet(tuck_index, knit_rows_after = buffer_height);


    lace_stitches.right_eyelet(tuck_index, knit_rows_after = buffer_height);


    lace_stitches.slip_slip_knit(tuck_index, knit_rows_after = buffer_height);

    
    lace_stitches.knit_3_together(tuck_index, knit_rows_after = buffer_height, do_tuck = True);

    lace_stitches.slip_knit_2_together(tuck_index, knit_rows_after = buffer_height, do_tuck = True);
        

    bind_offs.chain_bind_off(Loops, Leftward);


}