// so this is a crazy idea and doesn't fully work
// if a block of color is too long, then you get a long float when the other color tries to skip it
// i need a way to link the yarn...

import cast_ons;
import bind_offs;

bit_map = [[(i + (j % 2)) % 2  for i in range(10)] for j in range(10)];


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

def get_loops_from_pattern(expanded_row): {
    // goes from pattern and sheet to loops
    

    xfer Loops across to Front bed; // THIS IS SO INEFFICIENT IT MAKES ME CRY
    // bascially, Loops stores all the front and then all the back
    // until i find a way to sort that, this is what i have to do
    
    front_pattern_loops = [];
    back_pattern_loops = [];    
        
        for i, loop in enumerate(Loops): {

            if expanded_row[i] == 1: {
                front_pattern_loops.append(loop);
            }
            else: {
                back_pattern_loops.append(loop);
            }
        }
    
    return [front_pattern_loops, back_pattern_loops];
}


def set_up_loops(pattern_row, bit_map, pixel_width, pixel_height): {
    // goes from row and bit_map to xfering both sheets

    pattern = expand_pattern_row(pattern_row, bit_map, pixel_width, pixel_height);
    loop_pattern = get_loops_from_pattern(pattern);
    xfer loop_pattern[0] across to Front bed;
    xfer loop_pattern[1] across to Back bed;
}

// cast on
with Carrier as carriers[0]: {
    cast_ons.alt_tuck_cast_on(pattern_width * pixel_width, is_front = True);
}

// knit rows
for pattern_row in range(pattern_height): {
    // moves loops to correct spots
    set_up_loops(pattern_row, bit_map, pixel_width, pixel_height);
    
    for pixel_row in range(pixel_height): {
        with Carrier as carriers[0]: {
            in reverse direction: {
                knit Front_Loops;
            }
        }

        xfer Loops across;

        with Carrier as carriers[1]: {
            // very important that this is current direction
            in current direction: {
                knit Front_Loops;
            }
        }

        xfer Loops across;
    }
    
}

// bind off
with Carrier as carriers[0]: {
    bind_offs.chain_bind_off(Loops, Leftward);
}

