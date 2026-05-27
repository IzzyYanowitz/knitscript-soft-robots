import cast_ons;
import bind_offs;

width = 20;
height = 20;
left_shift = 30; // amount piece should be shifted over by

fabric_carr = c2;
tendon_carr = c3;

tendon_start = 10;
tendon_stop = width - 5;
tendon_move = 0; // positive is rightward, negative is leftward

gauge = 2;

with Gauge as gauge: {
    
    // cast on
    with Carrier as fabric_carr: {
        cast_ons.alt_tuck_cast_on(width, is_front = True);
    }

    with Carrier as tendon_carr: {
        // this just brings the tendon_carrier into play in the right place and moves the piece over
        in Leftward direction: {
            tuck Back_Needles[tendon_start : width + left_shift : 2];
        }
        drop Back_Needles[tendon_start : width + left_shift : 2];
    }

    tuck_index = tendon_start;
    // knit
    for row in range(height): {
        
        if (row % 3) == 0: {
            
            // i tried to wrap this bit into a function, but it didn't work???
            move_sign = 0;
            
            if tendon_move > 0: {
                move_sign = 1;
            }
            
            elif tendon_move < 0: {
                move_sign = -1;
            }
            
            if (move_sign * tuck_index) <= (move_sign * tendon_stop): {
                
                // xfer for ktog
                xfer Front_Needles[tuck_index] 1 to Left;
                xfer Back_Needles[tuck_index - 1] across;
                
                // knit row
                with Carrier as fabric_carr: {
                    in Leftward direction: {
                        knit Loops;
                    }
                }

                // tuck tendon
                with Carrier as tendon_carr: {
                    in Leftward direction: {
                        tuck Front_Needles[tuck_index];
                    }
                }

                tuck_index = tuck_index + tendon_move;
            }
            
            else: {
                // knit row
                with Carrier as fabric_carr: {
                    in Leftward direction: {
                        knit Loops;
                    }
                }
            }

            
        }
        
        elif (row % 3) == 1: {
            
            // knit row
            with Carrier as fabric_carr: {
                in Rightward direction: {
                    knit Loops;
                }
            }
        }

        elif (row % 3) == 2: {
            xfer Front_Loops across;
            with Carrier as fabric_carr: {
                for i in range(2): {
                    in reverse direction: {
                        knit Back_Loops;
                    }
                }
            }
            xfer Back_Loops across;
        }
    }

    // bind off
    bind_offs.chain_bind_off(Loops, reverse, hold = False, extra_knits = 0);
}