import cast_ons;

// Define the size of the object
width = 20;
body_height = 30;
edge_height = 5;

// Apply Gauge 2 to the entire object so the machine knows it's a tube
with Gauge as 2: {
    
    // 1. BOTTOM EDGE: Use Carrier 7
    with Carrier as 7: {
        // Cast on both the front and back sheets
        for s in range(0, Gauge): {
            with Sheet as s: { 
                cast_ons.alt_tuck_cast_on(width); // this casts on the front needles for both sheets. Was that intentional?
            }
        }
        
        // Knit the bottom cuff
        for r in range(0, edge_height): {
            for s in range(0, Gauge): {
                with Sheet as s: { 
                    in reverse direction: { 
                        knit Loops; 
                    } 
                }
            }
        }
    }
    
    // 2. MAIN BODY: Switch to Carrier 6
    // Carrier 7 will automatically park on the side of the machine and wait.
    with Carrier as 6: {
        for r in range(0, body_height): {
            for s in range(0, Gauge): {
                with Sheet as s: { 
                    in reverse direction: { 
                        knit Loops; 
                    }
                }
            }
            // for safety, release hook after first course
            releasehook;
        }
    }
    
    // 3. TOP EDGE: Switch back to Carrier 7
    // Carrier 6 parks, and the machine picks Carrier 7 back up.
    with Carrier as 7: {
        for r in range(0, edge_height): {
            for s in range(0, Gauge): {
                with Sheet as s: { 
                    in reverse direction: { 
                        knit Loops; 
                    } 
                }
            }
        }
        
        // Close the top of the tube so it's a sealed 3D shape
        xfer s1.Loops across to Front bed; // s1 loops are already on the front bed, you never put them on the back

        // this doesn't actually seal up the tube because you are only knitting sheet 0
        with Sheet as s0: {
            in reverse direction: { 
                knit Loops; 
            }
        }
    }
}
// KnitScript will automatically generate the final cut commands here to release the object.