// can knit any two color bitmap
// it will knit it upside down, but thats kind of a good thing
// a zero will be carriers[0], and a 1 will be carriers[1]
// the back of the peice will have a color swapped and backwards version of the bitmap

import cast_ons;
import bind_offs;

bit_map = [[(i + (j % 2)) % 2  for i in range(4)] for j in range(4)]; // checkerboard
bit_map = [[0, 0, 0, 0, 0, 0, 0], 
           [0, 1, 1, 0, 1, 1, 0], 
           [1, 1, 1, 1, 1, 1, 1], 
           [1, 1, 1, 1, 1, 1, 1], 
           [0, 1, 1, 1, 1, 1, 0], 
           [0, 0, 1, 1, 1, 0, 0], 
           [0, 0, 0, 1, 0, 0, 0]]; // heart

pixel_width = 4; // number of stitches per pixel in x direction
pixel_height = 4; // number of stitches per pixel in y direction

pattern_width = len(bit_map[0]);
pattern_height = len(bit_map); 

carriers = [c5, c8];



def expand_pattern_row(pattern_row, bit_map, pixel_width): {
    // goes from bitmap and row to pattern
    
    expanded_row = [];
    for i in range(0, len(bit_map[pattern_row]) * pixel_width, 1): {
        expanded_row.append(bit_map[pattern_row][int(i / pixel_width)]);
    }
    
    return expanded_row;
}

def get_loops_from_pattern(expanded_row, sheet_is): {
    // goes from pattern and sheet to loops
    
    // these have to be declared before the with block for scoping reasons
    front_pattern_loops = [];
    back_pattern_loops = [];  

    with Sheet as sheet_is: {
        xfer Loops across to Front bed; // THIS IS SO INEFFICIENT IT MAKES ME CRY
        // bascially, Loops stores all the front and then all the back
        // until i find a way to sort that, this is what i have to do

        for i, loop in enumerate(Loops): {

                if expanded_row[i] == 0: {
                    front_pattern_loops.append(loop);
                }
                else: {
                    back_pattern_loops.append(loop);
                }
            }
    }

    return [front_pattern_loops, back_pattern_loops];
}


def set_up_loops(pattern_row, bit_map, pixel_width, pixel_height): {
    // goes from row and bit_map to xfering both sheets

    pattern = expand_pattern_row(pattern_row, bit_map, pixel_width, pixel_height);
    sheet0_loop_pattern = get_loops_from_pattern(pattern, s0);
    sheet1_loop_pattern = get_loops_from_pattern(pattern, s1);
    xfer sheet0_loop_pattern[0] across to Front bed;
    xfer sheet0_loop_pattern[1] across to Back bed;
    // sheet 1 has front and back swapped
    xfer sheet1_loop_pattern[1] across to Front bed;
    xfer sheet1_loop_pattern[0] across to Back bed;
}

// cast on
with Carrier as carriers[0]: {
        cast_ons.alt_tuck_cast_on(2 * pattern_width * pixel_width, is_front = True);
        xfer Loops[1::2] across; // xfer every other loop across for sheets
    }

with Gauge as 2: {
    // setup sheets
    with Carrier as carriers[0], Sheet as s0: {
        for _ in range(2): {
            in reverse direction: {
                knit Loops;
            }
        }
    }
    with Carrier as carriers[1], Sheet as s1: {
        for _ in range(2): {
            in reverse direction: {
                knit Loops;
            }
        }
    }

    // at this point all the white loops are in the front and all the black loops are in the back

    // knit rows
    for pattern_row in range(pattern_height): {
        
        // moves loops to correct spots
        set_up_loops(pattern_row, bit_map, pixel_width, pixel_height);
        
        for pixel_row in range(pixel_height): {
            with Carrier as carriers[0], Sheet as s0: {
                in reverse direction: {
                    knit Loops;
                }
            }


            with Carrier as carriers[1], Sheet as s1: {
                // very important that this is current direction
                in current direction: {
                    knit Loops;
                }
            }

        }
        
    }
}

// bind off
xfer Loops across to Front bed;
with Carrier as carriers[0]: {
    // knit two rows for stability
    for _ in range(2): {
        in reverse direction: {
                knit Loops;
        }
    }
    bind_offs.chain_bind_off(Loops, Leftward);
}

