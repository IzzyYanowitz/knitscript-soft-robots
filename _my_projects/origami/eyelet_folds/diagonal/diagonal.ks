import cast_ons;
import bind_offs;

size = 8;
width_repeats = 3;
width = 2 * size * width_repeats;
height = size - 4;

do_right_fold_as_valley = True;

fabric_carr = c3;

def k3tog(triple_index, is_right, do_valley = False): {
    // xfers for a k3tog SPECIFICALLY FOR THIS PATTERN!!!!

    direc = Right;
    direc_sign = 1;
    
    if not is_right: {
        direc = Left;
        direc_sign = -1;
    }
    

    if do_valley: {
        xfer Back_Needles[triple_index - (direc_sign * 3)] across;
    }
    
    xfer Front_Needles[triple_index - (direc_sign * 3) : triple_index : direc_sign] 1 to direc;
    
    if not do_valley: {
        xfer Back_Needles[triple_index - (direc_sign * 2)] across;
    }
    
    xfer Back_Needles[triple_index] across;
    xfer Back_Needles[triple_index - (direc_sign * 1)] 1 to direc;
}

def all_k3tog(width_repeats, row): {
    // does all of the k3togs

    for repeat in range(width_repeats): {
            
            // right leaning
            k3tog(triple_index = row + 4 + (2 * repeat * size), is_right = True);
            
            // left leaning
            k3tog(triple_index = ((repeat + 1) * size * 2) - 5 - row, is_right = False, do_valley = do_right_fold_as_valley);

        }
}

def knit_to(first_index, backwards_index, last_index, direc, is_front, do_tuck, do_valley = False): {
    // this function isn't that complicated I swear
    // it just knits a section

    needles = Back_Needles;
    
    twisted_needle = Front_Needles[backwards_index];
    if do_valley: {
        twisted_needle = Back_Needles[backwards_index];
    }
    
    if is_front: {
        needles = Front_Needles;
    }

    direc_sign = 1;

    if direc == Leftward: {
        direc_sign = -1;
    }

    if direc_sign * first_index >= direc_sign * last_index: {
        temp = first_index;
        first_index = last_index;
        last_index = temp;
    }
    
    end = backwards_index;
    start = backwards_index + direc_sign;
    
    if do_tuck: {
        
        end = end - direc_sign;
        start = start + direc_sign;
    }

    first_set = [needles[i] for i in range(first_index, end, direc_sign)];
    second_set = [needles[i] for i in range(start, last_index, direc_sign)];
    


    // knit section

    in direc direction: {
        knit first_set;
    }
    
    if do_tuck: {
        in direc direction: {
            tuck needles[backwards_index - direc_sign];
        }
    }
    


    // twisted loop section

    in direc direction: {
        miss twisted_needle;
    }

    in reverse direction: {
        // notice this is always front needles for a mountain and back needles for a valey
        knit twisted_needle;
    }

    in direc direction: {
        miss twisted_needle;
    }



    // knit section

    if do_tuck: {
        in direc direction: {
            tuck needles[backwards_index + direc_sign];
        }
    }

    in direc direction: {
        knit second_set;
    }
}

def knit_row(width_repeats, row, direc, is_front, do_tuck): {
    // knits a whole row

    end_adjust = 0;
    start = 0;
    end = width_repeats;
    direc_sign = 1;
    
    
    if direc == Leftward: {
        end_adjust = -1;
        start = width_repeats - 1;
        end = -1;
        direc_sign = -1;
    }

    for repeat in range(start, end, direc_sign): {
            
            section_start = repeat * 2 * size + end_adjust;
            section_middle = (repeat * 2 * size) + size + end_adjust;
            section_end = ((repeat + 1) * 2 * size) + end_adjust;
            left_backwards = ((repeat + 1) * 2 * size) - 3 - row;
            right_backwards = row + 2 + (repeat * 2 * size);

            // you need to do left first if direc is Leftward,  but right first if its not
            if direc == Leftward: {
                
                // left leaning

                knit_to(first_index = section_end, 
                        backwards_index = left_backwards, 
                        last_index = section_middle, 
                        direc = direc, 
                        is_front = is_front, 
                        do_tuck = do_tuck,
                        do_valley = do_right_fold_as_valley);

            }
            

            // right leaning
            
            knit_to(first_index = section_middle,
                    backwards_index = right_backwards,
                    last_index = section_start,
                    direc = direc,
                    is_front = is_front,
                    do_tuck = do_tuck);

            if direc == Rightward: {
                
                // left leaning

                knit_to(first_index = section_end, 
                        backwards_index = left_backwards, 
                        last_index = section_middle, 
                        direc = direc, 
                        is_front = is_front, 
                        do_tuck = do_tuck,
                        do_valley = do_right_fold_as_valley);

            }
            
        }
}

def garder_xfer(width_repeats, current_bed_is_front): {
    
    // xfers garder loops across

    needles = Back_Needles;
    
    if current_bed_is_front: {
        needles = Front_Needles;
    }

    for repeat in range(width_repeats): {

            // right leaning

            backwards_index = row + 2 + (repeat * 2 * size);
            
            xfer needles[repeat * 2 * size : backwards_index] across;
            xfer needles[backwards_index + 1 : (repeat * 2 * size) + size] across;

            // left leaning

            backwards_index = ((repeat + 1) * 2 * size) - 3 - row;

            xfer needles[(repeat * 2 * size) + size : backwards_index] across;
            xfer needles[backwards_index + 1 : (repeat + 1) * 2 * size] across;
        }
}

with Carrier as fabric_carr: {
    
    // cast on
    in Leftward direction: {
        tuck Front_Needles[width : width + 30 : 2];
    }
    

    cast_ons.knit_cast_on(Front_Needles[0 : width], Leftward, extra_knits = 3);
    releasehook;
    
    // do it three times for safety
    drop Front_Needles[width : width + 30 : 2];
    drop Front_Needles[width : width + 30 : 2];
    drop Front_Needles[width : width + 30 : 2];

    // main body
    
    for row in range(height): {
        
        // set up knit togethers with xfers
        all_k3tog(width_repeats, row);

        // knit row
        knit_row(width_repeats, row, Leftward, is_front = True, do_tuck = True);

        // do some xfers for gardering
        garder_xfer(width_repeats, current_bed_is_front = True);

        // purl row
        knit_row(width_repeats, row, Rightward, is_front = False, do_tuck = False);

        // some more xfers for gardering
        garder_xfer(width_repeats, current_bed_is_front = False);
    }
    

    // bind off
    xfer Back_Loops across;
    bind_offs.chain_bind_off(Front_Loops, reverse, hold = False, extra_knits = 0);
    
}