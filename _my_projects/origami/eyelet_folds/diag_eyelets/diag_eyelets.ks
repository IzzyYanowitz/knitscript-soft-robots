import cast_ons;
import bind_offs;

width = 30;
height = 30;

fabric_carr = c1;

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

with Carrier as fabric_carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
    for row in range(height): {
        print(row);
        if (row < (width - 1)) and ((row % 2) == 0): {
            xfer Front_Loops[row] 1 to Right;
            xfer Back_Loops across;
            knit_across(width, Leftward);
        }
        
        else: {
            in reverse direction: {
                knit Loops;
            }
        }
        
    }
    bind_offs.chain_bind_off(Front_Loops, reverse);

}