// This is the sample code

// header
import bind_offs;

width = 30;
height = 30;

fabric_carrier = c2;

with Carrier as fabric_carrier: {
	
// cast on

    for row in range(2): {
        in Leftward direction: {
            tuck Front_Needles[1 : width : 2];
        }

        in Rightward direction: {
            tuck Front_Needles[0 : width : 2];
        }
    }
    
	
	// body
	
	for row in range(height): {		
        in reverse direction: {
			knit Front_Loops;
		}
	}

	// bind off
	bind_offs.chain_bind_off(Front_Loops, reverse, hold = False, extra_knits = 0);
}
