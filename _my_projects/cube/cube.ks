import cast_ons;
import bind_offs;

width = 30;
height = 30;
base_height = 10;

carr = c1;

with Carrier as carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);

    // start base
    in Leftward direction: {
        split Loops;
    }
    
    // knit base
    for row in range(base_height): {
        in reverse direction: {
            knit Front_Loops;
        }
    }

    // knit sides

    for row in range(height): {
        in reverse direction: {
            knit Front_Loops;
        }

        in reverse direction: {
            knit Back_Loops;
        }
    }

    
}