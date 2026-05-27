// compile with keep!!!!!!!

import cast_ons;
import bind_offs;

starting_needle = 20;
ending_needle = 149 + starting_needle;
height = 50;

fabric_carrier = c6;

with Carrier as fabric_carrier: {
    // cast on
    cast_ons.alt_tuck_cast_on(ending_needle - starting_needle, is_front = True, first_needle = starting_needle);
    
    xfer Front_Loops[1 : len(Front_Loops) : 2] across;
    
    for row in range(height): {
        
        in reverse direction: {
            knit Loops;
        }
        
        xfer Loops across;
    }

}