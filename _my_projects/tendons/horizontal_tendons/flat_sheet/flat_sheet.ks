// this is based on a paper by some folks at carnegie mellon univeristy
// they seem to be the leads on a lot of this work
import cast_ons;
import bind_offs;

width = 50;
height = 50;

fabric_carrier = c1;
tendon_carrier = c2;

tendon_rows = [10, 20, 30, 40];
tendon_end_length = 10; // this gives you something to hold on to and cut
tendon_tuck_gap = 5;

tendon_direction = 0;


inlay_holders = [Front_Needles[i] for i in range(tendon_end_length, tendon_end_length + width, tendon_tuck_gap)];


// cast on

with Carrier as fabric_carrier: {
    cast_ons.alt_tuck_cast_on(width, is_front = True, first_needle = tendon_end_length + 1);

    
    
    // free hooks that will hold the inlays
    // im not sure if doing a bunch of decreases like this will cause issues down the line...
    xfer inlay_holders 1 to Right;
    xfer Back_Loops across;


    // add the ends to inlay_holders
    begining = [Front_Needles[i] for i in range(0, tendon_end_length, tendon_tuck_gap)];
    end = [Front_Needles[i] for i in range(tendon_end_length + width + 1, (2 * tendon_end_length) + width + tendon_tuck_gap + 1, tendon_tuck_gap)];
    inlay_holders = begining + inlay_holders + end;
    
   

}

row = 0;
for end_point in tendon_rows: {
    
    with Carrier as fabric_carrier: {
        
        // knit up to next inlay
        for section_row in range(row, end_point): {
            
            in reverse direction: {
                knit Loops;
            }
            row = row + 1;
        }

        // xfer every other loop
        
    }

    with Carrier as tendon_carrier: {
        

        // tuck leftward
        xfer Loops[ : : 2] across to Back bed; 

        in Leftward direction: {
            tuck inlay_holders;
        }
        
        xfer Back_Loops across to Front bed;
        drop inlay_holders;

        // tuck rightward

        xfer Loops[1 : : 2] across to Back bed; 

        in Rightward direction: {
            tuck inlay_holders;
        }
        
        xfer Back_Loops across to Front bed;
        drop inlay_holders;

    }

}

with Carrier as fabric_carrier: {
    bind_offs.chain_bind_off(Loops, Leftward);
}