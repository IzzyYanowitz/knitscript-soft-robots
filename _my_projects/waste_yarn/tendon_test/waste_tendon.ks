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
    
    xfer Front_Loops[::2] across to Back bed;
    xfer Front_Loops 1 to Left;

}


with Carrier as fabric_carr: {
    cast_on_needles = [[Front_Needles,Back_Needles][i%2][i] for i in range(width)];
    cast_ons.knit_cast_on(cast_on_needles, extra_knits = 0);
    print(current);
}

with Carrier as waste_carr: {
    in Leftward direction: {
        tuck Front_Needles[1:width:2];
    }
    drop Front_Needles[1:width:2];
    xfer Back_Needles[1:width:2] across;
    drop Back_Loops;
    
}
cut waste_carr;
with Carrier as fabric_carr: {
    
    for row in range(height): {
        in [Rightward, Leftward][row % 2] direction: {
            knit Front_Loops;
        }
    }
    bind_offs.chain_bind_off(Front_Loops, reverse);
}