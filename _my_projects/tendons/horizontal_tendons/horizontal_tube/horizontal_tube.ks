// also based on the paper
// tube is closed on one end so you can stuff it

import cast_ons;

width = 75;
height = 25;

fabric_carrier = c1;
front_tendon_carrier = c2;

front_tendon = True;
back_tendon = True;

tendon_rows = [10, 20, 30, 40];
tendon_end_length = 10; // this gives you something to hold on to and cut
tendon_tuck_gap = 4; // remember you'll be knitting half gauge


first_needle = tendon_end_length;
last_needle = tendon_end_length + width;
front_tendon_holders = [Front_Needles[2 * i] for i in range(first_needle, last_needle, tendon_tuck_gap)]; // times two accounts for gauge
back_tendon_holders = [Back_Needles[1 + (2 * i)] for i in range(first_needle, last_needle, tendon_tuck_gap)];

with Gauge as 2: {
    // set gauge to 2 so we can have room for the weaving of the tendon

    with Carrier as fabric_carrier: {

        // these are for setting up the tendon holders later
        // i have to declare them here for *reasons*
        begining = [i for i in range(0, first_needle, tendon_tuck_gap)];
        end = [i for i in range(last_needle, last_needle + tendon_end_length, tendon_tuck_gap)];

        // i could make this a function, but i only do this code twice, it doesn't seem worth it
        // maybe I will later?
        
        with sheet as s0: {
            cast_ons.alt_tuck_cast_on(width, is_front = True, first_needle = tendon_end_length + 1); // cast on front
            
            // free up the tendon holders
            if front_tendon: {
                xfer front_tendon_holders 1 to Right;
                xfer Back_Loops across;
                front_tendon_holders = [Front_Needles[i] for i in begining] + front_tendon_holders + [Front_Needles[i] for i in end];
            }
        }

        with sheet as s1: {
            cast_ons.alt_tuck_cast_on(width, is_front = False, first_needle = tendon_end_length + 1); // cast on back
            
            // free up the tendon holders
            if back_tendon: {
                xfer back_tendon_holders 1 to Right;
                xfer Front_Loops across;
                back_tendon_holders = [Back_Needles[i + 1] for i in begining] + back_tendon_holders + [Back_Needles[i + 1] for i in end]; // +1 accounts for offset
            }
        }
        

        // knit up to tendon insertion
        for row in range(int(height / 4)): {

            // knits front, back, back, front to close on one end only
            with sheet as s0: {
                in reverse direction: {
                    knit Front_Loops;
                }
            }
            
            with sheet as s1: {
                in reverse direction: {
                    knit Back_Loops;
                }

                in reverse direction: {
                    knit Back_Loops;
                }
            }

            with sheet as s0: {
                in reverse direction: {
                    knit Front_Loops;
                }
            }
            
        }

    }

    with Carrier as front_tendon_carrier: {
        with sheet as s0: {

            xfer Front_Loops[1 : : 2] across to Back bed;
            
            
            in Leftward direction: {
                tuck front_tendon_holders;
            }
            // for some reason it doesn't let me xfer Back_Loops across???
            
            
        }
        

    }


}
