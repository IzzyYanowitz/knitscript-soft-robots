// attempt to recreate my memory of prof. roberts design

import cast_ons;
import bind_offs;

width = 20;
height = 30;

ktog_index = 5;


// make sure tendon carr is behind fabric carr
fabric_carr = c1;
tendon_carr = c5;


with Carrier as fabric_carr: {
    cast_ons.alt_tuck_cast_on(width, is_front = True);
}
with Carrier as tendon_carr: {
    in Leftward direction: {
        tuck Back_Needles[ ktog_index : width : 2]; // tuck every other needle down to the ktog index
    }
    xfer Back_Loops across;
}

for i in range(int(height / 2)): {
   
    with Carrier as fabric_carr: {
        
        if ktog_index < (width - 5): {
            xfer Front_Needles[ktog_index] 1 to Left;
            xfer Back_Needles[ktog_index - 1] across to Front bed;
        }
        

        in Leftward direction: {
            knit Front_Loops;
        }
    }

    // the tondon is being pulled to the right with this method
    // I tuck it in the leftward direction because I think twisting the loop should increase stability.
    with Carrier as tendon_carr: {
        if ktog_index < (width - 5): {
            in Leftward direction: {
                tuck Front_Needles[ktog_index];
            }
        }
    }
    

    


    with Carrier as fabric_carr: {
        
        in Rightward direction: {
            knit Front_Loops;
        }
        
    }

    ktog_index = ktog_index + 1;

}

with Carrier as fabric_carr: {
    bind_offs.chain_bind_off(Loops, reverse, hold = False, extra_knits = 0);
}