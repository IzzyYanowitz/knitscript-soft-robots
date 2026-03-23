
// the dat converter freaks out if you use more than 2 carriers
// i don't know why

import cast_ons;
import bind_offs;




// it knits the bit map upside down, but that is kind of a good thing...
checkerboard = [[(i + (j % 2)) % 2  for i in range(8)] for j in range(4)]; // checkerboard

heart = [[0, 0, 0, 0, 0, 0, 0], 
           [0, 1, 1, 0, 1, 1, 0], 
           [1, 1, 1, 1, 1, 1, 1], 
           [1, 1, 1, 1, 1, 1, 1], 
           [0, 1, 1, 1, 1, 1, 0], 
           [0, 0, 1, 1, 1, 0, 0], 
           [0, 0, 0, 1, 0, 0, 0]];

smiley_face = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
           [0, 1, 1, 1, 0, 0, 1, 1, 1, 0], 
           [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
           [0, 0, 1, 0, 0, 0, 0, 1, 0, 0], 
           [0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
           [0, 1, 0, 0, 0, 0, 0, 0, 1, 0], 
           [0, 0, 1, 1, 1, 1, 1, 1, 0, 0]];

ghost = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
         [0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0], 
         [0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0], 
         [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], 
         [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], 
         [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], 
         [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0], 
         [0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0], 
         [0, 1, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 0], 
         [0, 0, 1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2, 1, 0], 
         [0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0], 
         [0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0], 
         [0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0], 
         [0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0], 
         [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]];

bit_map = ghost;
pixel_width = 8; // number of stitches per pixel in x direction
pixel_height = 12; // number of stitches per pixel in y direction

pattern_width = len(bit_map[0]);
pattern_height = len(bit_map); 

carriers = [c2, c9, c5]; // make sure len(carriers) - 1 = max(bit_map)

do_ribbing = False; // ribbing makes it curl less but fucks with pattern slightly
do_garder = True; // might also help with the curl

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
    
    
    pattern_loops = [];


    for i, loop in enumerate(Loops): {

            if expanded_row[i] == color_index: {
                pattern_loops.append(loop);
            }

        }

    return pattern_loops;
}


with Carrier as carriers[0]: {
    cast_ons.alt_tuck_cast_on(pixel_width * pattern_width, is_front = True);
    if do_ribbing: {
        xfer Loops[1 : : 2] across; // xfer every other loop to back for ribbing
    }
    
}

// set up all carriers
// you need to knit a bit to hold the new yarn in place
for carr in carriers: {
    with Carrier as carr: {
    for _ in range(2): {
        in reverse direction: {
            knit Loops;
        }
    }
        releasehook;
    }
}

active_needles = Front_Loops;
    
if do_ribbing: {
    // you need to intersperse front_loops and back_loops
    active_needles = [];
    for i in range(len(Front_Loops)): {
        active_needles.append(Front_Loops[i]);
        active_needles.append(Back_Loops[i]);
    }
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
        
        if do_garder: {
            xfer Loops across;
            active_needles = [Back_Loops, Front_Loops][row % 2];
            
            // you have to get the pattern loops again because you changed where the loops are
            color_patterns = [];
            for i in range(len(carriers)): {
                color_patterns.append(get_loops_from_pattern(expanded_pattern_row, i));
            }
        }

    
        direc = [Leftward, Rightward][row % 2];
        
        for i, carr in enumerate(carriers): {
            
            with Carrier as carr: {
                
                alt_tuck_linking(color_patterns[i], active_needles, direc);

            }

        }
    }
}

with Carrier as carriers[0]: {
    
    // knit a row to stabalize
    
    in reverse direction: {
        knit Loops;
    }

    if do_ribbing or do_garder: {
        xfer Back_Loops across;
    }

    bind_offs.chain_bind_off(Front_Loops, Rightward);
}
