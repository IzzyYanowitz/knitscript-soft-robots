// wavy sheet from paper
// uses short rows

import cast_ons;
import bind_offs;

width = 200;

fabric_carrier = c1;
tendon_carrier = c2;


tendon_end_length = 10; // this gives you something to hold on to and cut
tendon_tuck_gap = 3;

wavelength = 20; // in stitches
wave_repeats = 10;



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

    // since we just decreased so many times, we effectively have a smaller width
    width = len(Loops);
}

// upwards wave

with Carrier as fabric_carrier: {
    for i in range(int(width / wavelength)): {

        // this method requires all relevant loops be on front bed
        
        first_loop = width - (i * wavelength); // i use loops here to skip over the needles with no loops
        wave_loops = Loops[first_loop - wavelength : first_loop];
        
        

        for wave_row in range(int(wavelength / 2)): {
            
            // this basically knits a triangle, but it should turn into more of a wave shape, hopefully
            in reverse direction: {
                knit wave_loops;
            }

            wave_loops = wave_loops[1 : len(wave_loops) - 1];
        }
    }
}


// inlay

// downwards wave