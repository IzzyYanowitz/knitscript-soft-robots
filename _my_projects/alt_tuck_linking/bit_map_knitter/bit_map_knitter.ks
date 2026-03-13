import cast_ons;
import bind_offs;

bit_map = [[(i + (j % 2)) % 2  for i in range(4)] for j in range(4)]; // checkerboard
pixel_width = 4; // number of stitches per pixel in x direction
pixel_height = 4; // number of stitches per pixel in y direction

pattern_width = len(bit_map[0]);
pattern_height = len(bit_map); 

carriers = [c5, c8]; // make sure len(carriers) = max(bit_map)


def alt_tuck_linking(color_needles, all_needles, direction_is): {
        
    // this is responsible for actually knitting

    // if you wanted to knit on the back bed aswell as the front, you'd have to be more careful about this logic
    // maybe implementing something similar to my knit_across function in oriel_lace.ks
        
    do_tuck = False;

     // reverse all_needles if going leftward
    if direction_is == Leftward: {

        all_needles = [all_needles[0 - i] for i in range(1, len(all_needles) + 1)];

    }
    
    for needle in all_needles: {

        if needle in color_needles: {
            
            in direction_is direction: {

                knit needle;

            }
            
            do_tuck = True;
        }

        elif do_tuck: {
            
            in direction_is direction: {

                tuck needle;
                
            }
            
            do_tuck = False;
        }

        else: {
            
            in direction_is direction: {

                miss needle;

            }
            
            do_tuck = True;
        }
    } 
    
    
}

def expand_pattern_row(pattern_row, pixel_width): {
    // goes from bitmap and row to pattern
    
    expanded_row = [];
    for i in range(0, len(pattern_row) * pixel_width, 1): {
        expanded_row.append(pattern_row[int(i / pixel_width)]);
    }
    
    return expanded_row;
}

def get_loops_from_pattern(expanded_row, color_index): {
    // goes from pattern and sheet to loops
    
    
    front_pattern_loops = [];


    for i, loop in enumerate(Loops): {

            if expanded_row[i] == color_index: {
                front_pattern_loops.append(loop);
            }

        }

    return front_pattern_loops;
}


with Carrier as carriers[0]: {
    cast_ons.alt_tuck_cast_on(pixel_width * pattern_width, is_front = True);
}

for pattern_row in bit_map: {
    // the pattern is the same inside a pixel so i have two separate row loops
    // one for each row of the pattern, and one for each row of the pixel
    
    expanded_pattern_row = expand_pattern_row(pattern_row, pixel_width);
    color_patterns = [];

    for i in range(len(carriers)): {

        color_patterns.append(get_loops_from_pattern(expanded_pattern_row, i));

    }
    
    for row in range(pixel_height): {

        direc = [Leftward, Rightward][row % 2];
        
        for i, carr in enumerate(carriers): {

            with Carrier as carr: {
        
                alt_tuck_linking(color_patterns[i], Front_Loops, direc);

            }

        }
    }
}

with Carrier as carriers[0]: {
    
    // knit a row to stabalize
    
    in reverse direction: {
        knit Front_Loops;
    }

    bind_offs.chain_bind_off(Front_Loops, Rightward);
}
