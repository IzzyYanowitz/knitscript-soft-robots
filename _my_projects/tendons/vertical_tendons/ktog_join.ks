// attempt to recreate my memory of prof. roberts design

import cast_ons;
import bind_offs;

width = 20;
height = 30;

ktog_index = int(width / 2);

fabric_carr = c1;
tendon_carr = c5;


with Carrier as fabric_carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
}
with Carrier as tendon_carr: {
    in Leftward direction: {
        tuck Back_Needles[ ktog_index : width : 2]; // tuck every other needle down to the ktog index
    }
    
}

for i in range(int(height / 2)): {
    // rightward pass
   
    with Carrier as fabric_carr: {

        xfer Front_Loops[ktog_index] 1 to Left;
        xfer Back_Loops across to Front bed;

        in Leftward direction: {
            knit Front_Loops[1 + ktog_index : width];
        }
    }

    with Carrier as tendon_carr: {
        in Leftward direction: {
            tuck Front_Needles[ktog_index];
        }
    }

    with Carrier as fabric_carr: {
        in Leftward direction: {
            knit Front_Loops[ : ktog_index];
        }
    }


    // leftward pass
    /* with Carrier as fabric_carr: {
        
        xfer Front_Loops[ktog_index] 1 to Right;
        xfer Back_Loops across to Front bed;

        in Rightward direction: {
            knit Front_Loops[ : ktog_index];
        }
    }

    with Carrier as tendon_carr: {
        in Rightward direction: {
            tuck Front_Needles[ktog_index];
        }
    }

    with Carrier as fabric_carr: {
        
        in Rightward direction: {
            knit Front_Loops[1 + ktog_index : width];
        }
    } */

    with Carrier as fabric_carr: {
        
        in reverse direction: {
            knit Loops;
        }
        
    }


}

with Carrier as fabric_carr: {
    bind_offs.chain_bind_off(Loops, Leftward);
}