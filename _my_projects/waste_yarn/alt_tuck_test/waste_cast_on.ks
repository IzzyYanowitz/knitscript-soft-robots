import cast_ons;
import bind_offs;

waste_carr = c1;
fabric_carr = c4;

width = 30;
height = 30;
waste_height = 10; // must be even


with Carrier as waste_carr: {
    cast_ons.alt_tuck_cast_on(int(1.5 * width), is_front = True);
    
    
    in Leftward direction: {
        knit Loops[width : int(1.5 * width)];
    }
    
    
    drop Loops[width : int(1.5 * width)];
    
    for row in range(waste_height): {
        in reverse direction: {
            knit Loops;
        }
    }
    
    xfer Loops across to Back bed;
    
    cast_ons.alt_tuck_cast_on(width, is_front = True, tuck_lines = 1, knit_lines = 0);
    drop Back_Loops;
}
cut waste_carr;


with Carrier as fabric_carr: {
    cast_ons.knit_cast_on(Front_Needles[0 : width]);
    
    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

    bind_offs.chain_bind_off(Front_Loops, reverse);
}