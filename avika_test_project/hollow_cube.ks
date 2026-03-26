import cast_ons;
import bind_offs;

// Gauge 2 means we use every other needle (half-gauge)
// This is standard for 3D/tubular shapes to avoid snagging
with Gauge as 2, Carrier as 1, width as 30, height as 30: {
    
    // Cast on both sheets to create the bottom of the cube
    for s in range(0, Gauge): {
        with Sheet as s: {
            cast_ons.alt_tuck_cast_on(width);
        }
    }

    // The Walls: Knit the front sheet then the back sheet
    for r in range(0, height): {
        for s in range(0, Gauge): {
            with Sheet as s: {
                in reverse direction: {
                    knit Loops;
                }
            }
        }
    }
    
    // Closing the top: Transfer Sheet 1 (back) to Sheet 0 (front)
    // This seals the 'lid' of the cube
    xfer s1.Loops across to Front bed;
    with Sheet as 0: {
        in reverse direction: { knit Loops; }
    }

    bind_offs.chain_bind_off(Loops, Rightward);
}